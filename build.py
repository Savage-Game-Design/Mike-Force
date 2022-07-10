import ctypes
from pathlib import Path
import os
import shutil
import sys
import user_paths

arma_missions_folder = Path(user_paths.MISSIONS_PATH)
mission_stem = "vn_mikeforce_indev"

# We don't need these - they bloat the build
blacklisted_folders = [
	"paradigm/.git",
	"paradigm/paradigm_data",
	".vscode",
]

def set_permissions_if_delete_fails(func, path, exc_info):
    """
    Error handler for ``shutil.rmtree``.

    If the error is due to an access error (read only file)
    it attempts to add write permission and then retries.

    If the error is for another reason it re-raises the error.

    Usage : ``shutil.rmtree(path, onerror=onerror)``
    """
    import stat
    if not os.access(path, os.W_OK):
        # Is the error an access error ?
        os.chmod(path, stat.S_IWUSR)
        func(path)
    else:
        raise


content_root = Path(__file__).parent
map_root = content_root / "maps"
map_folders = [ map_path for map_path in map_root.iterdir() if map_path.is_dir() ]
output_folder = content_root / "build_output"

if not output_folder.exists():
	output_folder.mkdir()

for map_folder in map_folders:
	folder_name = f"{mission_stem}.{map_folder.name}"
	source_folder = arma_missions_folder / folder_name
	target_folder = output_folder / folder_name

	if target_folder.exists():
		print(f"Removing existing folder: {target_folder}")
		shutil.rmtree(target_folder, onerror=set_permissions_if_delete_fails)
		
	print(f"Copying mission to {folder_name}")
	shutil.copytree(source_folder, target_folder)
	
	print("Trimming fat...")
	to_delete = [ target_folder / folder for folder in blacklisted_folders ]
	for path_to_delete in to_delete:
		print(f"Removing {path_to_delete}")
		if path_to_delete.exists():
			shutil.rmtree(path_to_delete, onerror=set_permissions_if_delete_fails)
	

input("Press any key to exit...")
exit(0)

