import ctypes
import ctypes.wintypes
from pathlib import Path
import os
import sys
import user_paths

def is_admin():
    try:
        return ctypes.windll.shell32.IsUserAnAdmin()
    except:
        return False

def get_windows_documents_directory():
    CSIDL_PERSONAL = 5       # My Documents
    SHGFP_TYPE_CURRENT = 0   # Get current, not default value

    buf = ctypes.create_unicode_buffer(ctypes.wintypes.MAX_PATH)
    ctypes.windll.shell32.SHGetFolderPathW(None, CSIDL_PERSONAL, None, SHGFP_TYPE_CURRENT, buf)
    return Path(buf.value)

if not is_admin():
    # Re-run the program with admin rights
    ret = ctypes.windll.shell32.ShellExecuteW(None, "runas", sys.executable, " ".join(sys.argv), None, 1)
else:
    mission_stem = "vn_mikeforce_indev"

    content_root = Path(__file__).parent
    mission_root = content_root / "mission"
    paradigm_path = Path(user_paths.PARADIGM_PATH)
    map_root = content_root / "maps"
    map_folders = [ map_path for map_path in map_root.iterdir() if map_path.is_dir() ]

    arma_missions_folder = Path(user_paths.MISSIONS_PATH)
    arma_missions_folder.mkdir(parents=True, exist_ok=True)

    def symlink_immediate_children(target, source):
        for path in source.iterdir():
            (target / path.name).symlink_to(path, target_is_directory=path.is_dir())

    existing_path_found = False
    for map_folder in map_folders:
        target_folder = arma_missions_folder / f"{mission_stem}.{map_folder.name}"
        if target_folder.exists():
            print(f"Existing mission folder exists: {target_folder}")
            existing_path_found = True

        if existing_path_found:
            continue

        target_folder.mkdir()

        print("Symlinking map-specific content...")
        symlink_immediate_children(target_folder, map_folder)
        print("Symlinking mission content...")
        symlink_immediate_children(target_folder, mission_root)
        print("Symlinking paradigm...")
        (target_folder / "paradigm").symlink_to(paradigm_path, target_is_directory=True)

    if existing_path_found:
        print("Cannot create links in Documents/Arma 3 - existing folders found. Please delete these then try again.")

    input("Press any key to exit...")
    exit(1 if existing_path_found else 0)

