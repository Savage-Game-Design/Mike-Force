# README

## IMPORTANT LICENSING INFORMATION

<a rel="license" href="https://www.bohemia.net/community/licenses/arma-public-license-share-alike" target="_blank" ><img src="https://data.bistudio.com/images/license/APL-SA.png" ><br>This work is licensed under the Public License Share Alike</a>

## IMPORTANT BUILD INFORMATION

We're in the process of updating our build tools for Mike Force. They're in their final review phase, but we didn't want to prematurely push out buggy build tools.
For now, the old tools should still work on Windows - see `setup_dev_environment.py` and `build.py`.

## Issue Reporting

Report issues using the "Issues" section above. Please be sure to follow the template, and include as much detail as possible to help us figure out the best solution! 

## Downloading
*Mike Force* is hosted on the [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2477873447). It's strongly advised to use Steam Workshop to manage the gamemode, and regularly check for updates, in case you're missing out on fixes or features!
* Download link: <https://steamcommunity.com/sharedfiles/filedetails/?id=2477873447>

## Running

The gamemode is a self-contained mission file. Simply download the mission from Steam Workshop into your server's mpmissions folder, and select it from the in-game mission list. 


## installation for development

Clone repo to local location of your choice and then symlink the `vn_mf.cam_lao_nam` folder into your Arma 3 missions folder.

Something like this:

```shell
C:\Users\USERNAME\Documents\Arma 3\missions
```

Windows symlinks are handled with the `mklink` command.

```shell
mklink /j "C:\Users\USERNAME\Documents\Arma 3\missions\vn_mf.cam_lao_nam" SGD_mikeforce\HAM\vn_mf.cam_lao_nam
```

**note** Use the standard windows commandline for this, bash on windows makes a mess of the paths.


The SGD_Paradigm folder is also required to by symlinked in to be the `vn_mf.cam_lao_nam\paradigm` folder.


```shell
mklink /j "C:\Users\USERNAME\Documents\Arma 3\missions\vn_mf.cam_lao_nam\paradigm" SGD_paradigm
```

## generated doc file

Started a simple documentation generator : <https://github.com/ryantownshend/sqf_tools>

The file `mikeforce_api.html` is a super crude parse of the header comments from within the project.

This can be fleshed out as we go, but it does provide a single place to view all the function file headers.



