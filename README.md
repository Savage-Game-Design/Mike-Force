# README


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



