"""
@author: Savage Game Design (@dijksterhuis)

This script is used to build GitHub releases for Mike Force.

It has been written to run on ubuntu GitHub CI runner machines.
Running this script on windows will likely result in errors!

To get more verbose logs, run like this:
```bash
LOG_LEVEL=DEBUG python3 ./release.py
```
"""

import sys
import platform

if platform.system() != "Linux":
    print("This script should only run on a machine with a Linux OS.")
    sys.exit(7)

import os
import io
import re
import git
import glob
import shutil
import logging
import zipfile
import requests
import argparse

from pathlib import Path


PARADIGM_GITHUB_ZIP_URL = (
    "https://github.com/Savage-Game-Design/Paradigm/archive/refs/heads/development.zip"
)

logging.basicConfig(
    format="%(asctime)s ::: %(levelname)s ::: %(message)s",
)

LOGGER = logging.getLogger(__name__)
LOGGER.setLevel(os.environ.get("LOG_LEVEL", "INFO"))


def get_args() -> argparse.Namespace:

    parser = argparse.ArgumentParser()

    parser.add_argument(
        "--build-dirpath",
        type=Path,
        nargs=1,
        required=False,
        default="/tmp/build/",
        help=(
            "Location of temporary build directory for creating the release assets."
            " Will be created if it does not exist."
            " Default: /tmp/build/"
        ),
    )

    parser.add_argument(
        "--release-dirpath",
        type=Path,
        nargs=1,
        required=False,
        default="./release/",
        help=(
            "Location of output release directory containing all GitHub release assets."
            " Will be created if it does not exist."
            " Default: ./release/"
        ),
    )

    parser.add_argument(
        "--teardown",
        action="store_true",
        help=(
            "Provide this flag to remove existing build/release directories before executing the build."
        ),
    )

    parsed = parser.parse_args()
    LOGGER.debug(f"Executing with script arguments: {parsed}")

    return parsed


ARGS = get_args()


class LoggerManager:
    """
    Context managed logging for logical blocks of code.
    Emits a log for "doing this" then emit a log for "did this" when "this" was done.

    Helps with code legibility as it forces different logical blocks of code
    to be split up by context management statements.
    """
    def __init__(self, message):
        self._message = message

    def info(self, message):
        LOGGER.info(message)

    def __enter__(self):
        LOGGER.info("=" * 80)
        LOGGER.info(f"Started: {self._message}")
        return self

    def __exit__(self, *args):
        LOGGER.info(f"Done: {self._message}")


def maybe_tear_down_builddir() -> None:
    """
    If the build directory exists, remove it from the file system. 
    """
    if ARGS.build_dirpath.exists():
        shutil.rmtree(ARGS.build_dirpath)
        LOGGER.debug(f"Removed temporary build directory: path={ARGS.build_dirpath}")


def maybe_tear_down_releasedir() -> None:
    """
    If the release directory exists, remove it from the file system. 
    """
    if ARGS.release_dirpath.exists():
        shutil.rmtree(ARGS.release_dirpath)
        LOGGER.debug(f"Removed release directory: path={ARGS.release_dirpath}")


def get_paradigm_development_files(paradir: Path) -> None:
    """
    Downloads the latest version of the Paradigm 'development' branch
    for this build.

    @param: paradir: dirpath where Paradigm files will be downloaded to
    @return: None
    """

    LOGGER.debug("Getting paradigm development file data ...")
    r = requests.get(PARADIGM_GITHUB_ZIP_URL, stream=True)
    r.raise_for_status()
    LOGGER.debug("Downloaded paradigm development file data.")

    # zipfile contains a directory called Paradigm-development
    # which we dump into /tmp/build, then we move all of the
    # contents to /tmp/build/para

    z = zipfile.ZipFile(io.BytesIO(r.content))
    z.extractall(ARGS.build_dirpath)

    for obj in ARGS.build_dirpath.joinpath("Paradigm-development").glob("*"):
        shutil.move(obj, paradir)

    LOGGER.debug("Extracted paradigm development file data.")


def mkdir_p(path: Path) -> None:
    """
    Recursively create a directory tree on linux, including any parents

    @param: path: directory path to create on system
    @return: nothing
    """
    os.makedirs(path, exist_ok=True)
    LOGGER.debug(f"Created new OS directory: {path}")


def create_build_subdir(dirname: Path) -> Path:
    """
    Create a new subdirectory in the build path

    @param: dirname: anme of the new build sub directory
    @return: pathlib.Path object referencing the location of the nw sub directory
    """
    path = ARGS.build_dirpath.joinpath(dirname)
    mkdir_p(path)
    LOGGER.debug(f"Created new build subdirectory with path: {path}")
    return path


def copy_dir_or_file(src: Path, dest: Path) -> None:
    """
    Conditional file/directory copying.

    @param: src: path to the file or directory needing to be copied
    @param: dest: path to the directroy files will be copied to
    @return: None
    """
    LOGGER.debug(f"Copying: {src} -> {dest}")
    if src.is_dir():
        shutil.copytree(
            src,
            dest,
            dirs_exist_ok=True,
            ignore=shutil.ignore_patterns(
                "*git*",
                "*__pycache__*",
                "*.py",
            ),
        )
    else:
        shutil.copy2(
            src,
            dest,
        )
    LOGGER.debug(f"Copied: {src} -> {dest}")


def rm_dir_or_file(path: Path) -> None:
    """
    Conditional file/directory removal.

    @param: path: path to the file or directory needing to be deleted
    @return: None
    """
    LOGGER.debug(f"Deleting: {path}")
    if path.is_dir():
        shutil.rmtree(path)
    else:
        path.unlink(missing_ok=True)
    LOGGER.debug(f"Deleted: {path}")


def get_mf_version() -> str:
    """
    Parse the Mike Force version from mission/version.hpp

    @return: string version which should match these examples:
        1.00.03; 1.00.03.indev; 1.00.03.indata.myservername
    """

    LOGGER.debug(f"Resolving Mike Force version ...")

    with open("mission/version.hpp") as f:
        ver_raw = f.readlines()

    no_comments = [x for x in ver_raw if not x.startswith("//")]
    first_line = no_comments[0]

    base = first_line.lstrip("#define VN_MF_VERSION v")
    ver = re.sub(r" .*", "", base)

    LOGGER.debug(f"Base version string: {base}")

    # handle suffixes like 'v1.00.04 Indev' or 'v1.000.04 Indev MyServerName'
    possible_suffixes = base.replace(ver, "")
    if len(possible_suffixes) > 0:
        for x in possible_suffixes.split(" "):
            if len(x) > 0:
                ver += "." + x.lower()

    LOGGER.debug(f"Resolved Mike Force version: {ver}")

    return ver


def write_txt_to_file(path: Path, data: str) -> None:
    """
    Simple boilerplate helper to write some string to a file.

    @param: path: Path to of the file to write to
    @param: data: string to write to the file
    """
    with open(path, "w") as f:
        f.write(data)


def main() -> None:

    LOGGER.info(f"Building new Mike Force GitHub release.")

    mf_version = get_mf_version()
    mission_stem = f"vn_mikeforce_{mf_version.replace('.', '_')}"

    with LoggerManager("Setting up build environment") as l:

        if ARGS.teardown:
            maybe_tear_down_builddir()
            maybe_tear_down_releasedir()
            l.info(f"Removed existing build/release directories.")

        src_mapsdir = Path("maps")
        src_missiondir = Path("mission")

        # location for paradigm data
        build_paradir = ARGS.build_dirpath.joinpath("para")

        # mike force 'mission' scripts
        build_missiondir = create_build_subdir("mission")

        # actual build directory, where the individual missions are built
        # ready to be archived
        build_stagedir = create_build_subdir("staging")

        # paradigm directory
        build_paradir = create_build_subdir("para")

        # archives output temporary directory
        build_archivedir = create_build_subdir("archives")

        l.info(f"Configured path locations.")

        # copy mission files into build directory for ease of access
        shutil.copytree(
            src_missiondir,
            build_missiondir,
            dirs_exist_ok=True,
        )
        l.info(f"Copied common mision files.")

        # download paradigm file data files into build directory
        get_paradigm_development_files(
            build_paradir,
        )
        l.info(f"Downloaded paradigm files.")

    with LoggerManager("Compiling mission files for each map.") as l:

        for map_dir in src_mapsdir.glob("*"):

            # example: vn_mikeforce_1_00_04_indev.altis
            map_mission_stem = f"{mission_stem}.{map_dir.name}"
            l.info(f"Compiling mission: {map_mission_stem}")

            # create the necessary map-mission dirs
            map_target_dir = build_stagedir.joinpath(map_mission_stem)
            mkdir_p(map_target_dir.joinpath("paradigm"))

            for path in build_missiondir.glob("*"):
                copy_dir_or_file(
                    path,
                    map_target_dir.joinpath(path.name),
                )
            l.info(f"Copied mission files.")

            for path in build_paradir.glob("*"):
                copy_dir_or_file(
                    path,
                    map_target_dir.joinpath("paradigm").joinpath(path.name),
                )
            l.info(f"Copied paradigm files.")

            for path in map_dir.glob("*"):
                copy_dir_or_file(
                    path,
                    map_target_dir.joinpath(path.name),
                )
            l.info(f"Copied map files.")

    with LoggerManager("Building release archives.") as l:

        for archive_type in ["zip", "gztar"]:

            # 'all' archives contain a directory for each map in the build
            main_fname = f"{mission_stem}.all"
            archive_name = shutil.make_archive(
                build_archivedir.joinpath(main_fname),
                archive_type,
                build_stagedir,
            )
            l.info(f"Built archive file: type={archive_type} fname={main_fname}")

            # individual map archives contain a single directory for that map
            # i.e. the archive only contains a `vn_mikeforce_1_00_04_indev.altis``
            # directory
            for mission in build_stagedir.glob("*"):
                shutil.make_archive(
                    build_archivedir.joinpath(mission.name),
                    archive_type,
                    build_stagedir,
                    mission.name,
                )
                l.info(f"Built archive file: type={archive_type} fname={mission.name}")

    with LoggerManager("Creating GitHub release data.") as l:

        mkdir_p(ARGS.release_dirpath)
        l.info(f"Created release directory.")

        for archive in build_archivedir.glob("*"):
            shutil.move(archive, ARGS.release_dirpath)
        l.info(f"Moved archives.")

        tag_name = mf_version
        release_name = f"Mike Force: {mf_version}"
        commit_summary = git.Repo(".").commit().summary

        write_txt_to_file(
            ARGS.release_dirpath.joinpath("tag_name.txt"),
            f"v{mf_version}",
        )
        l.info(f"Wrote new tag file.")

        write_txt_to_file(
            ARGS.release_dirpath.joinpath("release_name.txt"),
            f"Mike Force: {mf_version}",
        )
        l.info(f"Wrote release name file.")

        write_txt_to_file(
            ARGS.release_dirpath.joinpath("RELEASE.md"),
            f"- {commit_summary}",
        )
        l.info(f"Wrote commit summary file.")

    LOGGER.info("=" * 80)
    LOGGER.info(f"Release build completed.")


main()
