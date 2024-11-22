"""
This script is used to build the zip/tar archives included in GitHub releases.

It has been written to run on ubuntu GitHub CI runner machines.
Running this script on windows will likely result in errors!
"""

import platform
import sys

if platform.system() != "Linux":
    print("This script should only run on a machine with a Linux OS.")
    sys.exit(7)

import os
import git
import itertools
import re
import typing
import shutil
import zipfile
import glob
import subprocess
import logging

from pathlib import Path

BUILD_DIR = Path("/tmp/build")
RELEASE_DIR = Path("./release")


def init_logging():

    logging.basicConfig(level=os.environ.get("LOG_LEVEL", "INFO"))

    l = logging.getLogger()
    l.handlers = []
    std_out = logging.StreamHandler(stream=sys.stdout)
    std_err = logging.StreamHandler(stream=sys.stdout)
    std_out.setLevel(logging.INFO)
    std_out.addFilter(lambda record: record.levelno < logging.ERROR)
    std_err.setLevel(logging.ERROR)
    l.addHandler(std_out)
    l.addHandler(std_err)

    return l


logger = init_logging()


def check_git_bin_exists() -> bool:
    logger.info("Checking for git binary executable ...")
    try:
        subprocess.run(
            ["which", "git"],
            capture_output=False,
        )

    except FileNotFoundError as err:
        logger.exception(
            "`git` binary not fund on system. Cannot clone paradigm without `git`.",
            exc_info=err,
        )
        raise
    except Exception as err:
        logger.exception(
            "An unknown error occured, please investigate this.",
            exc_info=err,
        )
        raise err

    logger.info("Found git binary executable.")
    return True


def clone_paradigm(path: Path) -> None:
    logger.info(f"Cloning paradigm to {path} ...")
    subprocess.run(
        [
            "git",
            "clone",
            "https://github.com/Savage-Game-Design/Paradigm",
            path,
        ],
        capture_output=False,
    )
    logger.info(f"Cloned paradigm to {path}")


def mkdir_p(path: Path) -> None:
    """
    Recursively create a directory tree on linux, including any parents

    @param: path: directory path to create on system
    @return: nothing
    """
    os.makedirs(path, exist_ok=True)


def create_build_subdir(dirname: Path) -> Path:
    """
    Create a new subdirectory in the build path

    @param: dirname: anme of the new build sub directory
    @return: pathlib.Path object referencing the location of the nw sub directory
    """
    path = BUILD_DIR.joinpath(dirname)
    mkdir_p(path)
    return path


def copy_dir_or_file(src: Path, dest: Path) -> None:
    """
    Conditional file/directory copying.
    """
    logger.debug(f"Copying: {src} -> {dest}")
    if src.is_dir():
        shutil.copytree(
            src,
            dest,
            dirs_exist_ok=True,
            ignore=shutil.ignore_patterns(
                "*git*",
                "*__pycache__*",
                "*.py",
            )
        )
    else:
        shutil.copy2(
            src,
            dest,
        )
    logger.debug(f"Copied: {src} -> {dest}")


def rm_dir_or_file(path: Path) -> None:
    """
    Conditional file/directory removal.
    """
    logger.debug(f"Deleting: {path}")
    if path.is_dir():
        shutil.rmtree(path)
    else:
        path.unlink(missing_ok=True)
    logger.debug(f"Deleted: {path}")


def get_mf_version() -> str:
    """
    Parse the Mike Force version from mission/version.hpp
    """

    logger.debug(f"Resolving Mike Force version ...")
    with open("mission/version.hpp") as f:
        ver_raw: list = f.readlines()

    no_comments: str = [x for x in ver_raw if not x.startswith("//")]
    first_line = no_comments[0]
    base: str = first_line.lstrip("#define VN_MF_VERSION v")
    ver: str = re.sub(r" .*", "", base)

    # handle suffixes like 'v1.00.04 Indev' or 'v1.000.04 Indev MyServerName'
    possible_suffixes = base.replace(ver, "")
    if len(possible_suffixes) > 0:
        for x in possible_suffixes.split(" "):
            if len(x) > 0:
                ver += "." + x.lower()

    logger.info(f"Resolved Mike Force version: {ver}")

    return ver


def main():

    if not check_git_bin_exists():
        sys.exit(1)

    mf_version = get_mf_version()

    mission_stem = "vn_mikeforce_" + mf_version.replace(".", "_")

    # === setup temporary build directories ===

    src_mapsdir = Path("maps")
    src_missiondir = Path("mission")
    # we will clone this with git via a subprocess in a moment
    src_paradir = BUILD_DIR.joinpath("para")

    # mike force 'mission' scripts
    build_missiondir = create_build_subdir("mission")
    # actual build directory, where the individual missions get built
    build_stagedir = create_build_subdir("stage")
    # paradigm directory
    build_paradir = create_build_subdir("para")
    # final archives output directory
    build_archivedir = create_build_subdir("archives")

    logger.info(f"Configured path locations.")

    # === copy common sources ===
    # put mission and paradigm scripts in build directory
    # for easy access / safe usage
    shutil.copytree(src_missiondir, build_missiondir, dirs_exist_ok=True)
    clone_paradigm(src_paradir)

    logger.info(f"Copied common script files.")

    for map_dir in src_mapsdir.glob("*"):

        map_mission_stem = f"{mission_stem}.{map_dir.name}"
        logger.debug(f"Compiling mission: {map_mission_stem}")

        map_target_dir = build_stagedir.joinpath(map_mission_stem)
        mkdir_p(map_target_dir.joinpath("paradigm"))

        for path in build_missiondir.glob("*"):
            copy_dir_or_file(path, map_target_dir.joinpath(path.name))
        logger.debug(f"Compiled mission files: {map_mission_stem}")

        for path in build_paradir.glob("*"):
            copy_dir_or_file(path, map_target_dir.joinpath("paradigm").joinpath(path.name))
        logger.debug(f"Compiled paradigm files: {map_mission_stem}")

        for path in map_dir.glob("*"):
            copy_dir_or_file(path, map_target_dir.joinpath(path.name))
        logger.debug(f"Compiled map files: {map_mission_stem}")

        logger.info(f"Compiled mission: {map_mission_stem}")

    logger.info(f"Compiled map specific missions.")

    hidden_dirs = [x for x in BUILD_DIR.rglob("*") if ".git" in x.parts or x.name.startswith(".")]

    for hidden_dir in hidden_dirs:
        rm_dir_or_file(hidden_dir)
        logger.debug(f"Removed hidden directory/file: {hidden_dir}")

    logger.info(f"Removed hidden directories/files from build.")

    logger.info(f"Building release ...")

    for archive_type in ["zip", "gztar"]:

        main_fname = f"{mission_stem}.all"
        archive_name = shutil.make_archive(build_archivedir.joinpath(main_fname), archive_type, build_stagedir)
        logger.info(f"Built archive file: fname={main_fname} type={archive_type}")

        for mission in build_stagedir.glob("*"):
            shutil.make_archive(
                build_archivedir.joinpath(mission.name),
                archive_type,
                build_stagedir,
                mission.name,
            )
            logger.info(f"Built archive file: fname={mission.name} type={archive_type}")

    logger.info(f"All archives built.")

    # === create release directory ===
    logger.info(f"Preparing release.")

    mkdir_p(RELEASE_DIR)

    for archive in build_archivedir.glob("*"):
        shutil.move(archive, RELEASE_DIR)

    tag_name = mf_version
    release_name = f"Mike Force: {mf_version}"

    # only handling last commit for now...
    # need to sort out historical tags in the repo to handle automatic changelogs
    changelog = f"- {git.Repo(".").commit().summary}"

    with open(RELEASE_DIR.joinpath("tag_name.txt"), "w") as f:
        f.write(f"v{mf_version}")

    with open(RELEASE_DIR.joinpath("release_name.txt"), "w") as f:
        f.write(f"Mike Force: {mf_version}")

    with open(RELEASE_DIR.joinpath("RELEASE.md"), "w") as f:
        f.write(changelog)

    logger.info(f"Created release text files.")
    logger.info(f"Release built.")


main()