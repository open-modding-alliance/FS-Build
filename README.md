# FS Build - The Archive Manager For Farming Simulator 22 Mods

Automizes the process of creating zip archives for your mod with QoL features as automatic version bump, running TestRunner tool and more. This is for most part a "set and forget" tool that you config once and then you don't need to think much about it.

**Main features:**
* Automatically create zip archive (support blacklist of files) according to ModHub standard
* Automatically execute TestRunner tool and display the results
* Automatically start Farming Simulator 22 with a specific savegame
* Manages version increments (both fully automatic and with user interaction)
* Supports having "[DEV]" and "[TEST]" prefix in mod title to distinguish between versions
* Copy zip archive to a second mod folder (e.g. a network share) for multiplayer testing

## INSTALLATION
Currently, this tool only works on _Windows 10_ and above. 

### Automatic Installation

TBD

### Manual Installation

1. Download latest release
2. Unzip the archive in the root folder for your mod project
3. Create the "fsproj.json" file using either of these options
   - Create a new file manually (see configuration section for details)
   - Automatically generate the file via the `fsbuild init` command
   - Copy the template `fsproj_template.json` from the `.\fsbuild\` folder

## HOW TO USE _FS BUILD_
When you have configured FS Build, see section below for details about configuration, you can start using the tool. 

How you execute the tool depends on which terminal you are using:
- **VS Code** (the integrated PowerShell terminal): `.\fsbuild init`
- **Windows PowerShell**: `PS> .\fsbuild init`
- **Command Prompt**: `fsbuild init`
- **Command Prompt** (alternative): `powershell .\fsbuild init`


**Main commands:**

- _(w.i.p)_ `run` Starts Farming Simulator and automatically loads a pre-defined savegame. 
- `build` Creates a simple zip archive using the general build settings. Can automatically bump the build revision number.
- _(w.i.p)_ `release` Creates a ModHub ready zip archive using both the general build settings as well as the release specific settings. The `release` command also executes TestRunner if installed and configured properly.

**Other commands:**
- _(w.i.p)_ `init` This command is used to setup the tool for a new project. You should only run this once.
- _(planned feature)_ `build mp` Creates a zip archive using specific settings for multiplayer testing. Otherwise works the same as the regular `build` command.
- _(planned feature)_ `update` Automatic update of the FS Build script.




## CONFIGURATION
To enable the `fsbuild` command you need a `fsproj.json` file in the root of your mod project folder. You can manually create this file or you can run the command `fsbuild init` to have it automatically generated.


### Version auto-increment

```json
"versionBump": {
    "increaseOnBuild": "always",
    "increaseOnRelease": "ask"
},
```

The `increaseOnBuild` option has the possible values `never` and `always`. Value `always` will incremement the build revision number (i.e. `+0.0.0.1`). 

Option `increaseOnRelease` has the following possible values:
* `never` No automatic increase
* `major` Increases major version (i.e. `+1.0.0.0`) - typically for breaking changes
* `minor` Increases minor version (i.e. `+0.1.0.0`) - typically for regular changes
* `patch` Increases patch version (i.e. `+0.0.1.0`) - typically for hotfixes and patches
* `ask` Ask the user what do to (possible actions are "no increment", "major", "minor" and "patch")

> N.B.: build revision number is always 0 on release builds, e.g "1.0.0.2" becomes "1.0.0.0" on release.


### Minimal recommended "fsproj.json" config file

```json
{
    "version": {
        "increaseOnBuild": "build",
        "increaseOnRelease": "ask"
    },
    "buildBlacklist": [
    ],
    "releaseBlacklist": [
        "scripts/scriptLibrary/utils/DebugHelper.lua",
        "scriptLibrary/utils/DebugHelper.lua"
    ],
}
```


## License
Below you find the legal stuff. This is there to protect the creations made by Open Modding Alliance to make sure no one claims this as their protected property or used for commercial purposes, and with that out of the way, we want to empahize that we encourage you to (directly or indirectly) [contribute](TBD) to our openly shared assets.

You are **allowed to fork** the repo and **make changes** for personal use, and if you do improvements, please send us a **pull request** and we will try to incorporate your changes in the official repo (and you will of course be attributed/credited).

> **FS Build is licensed under CC BY-NC-ND 4.0 (Creative Commons Attribution-NonCommercial-ShareAlike).**
> 
> TL;DR: You are **ALLOWED TO SHARE** (copy and redistribute) the material in any medium or format as long as you **ATTRIBUTE** (give appropriate credit to) the original author, do **NOT MAKE ANY DERIVATIVES** (i.e. do not modify and re-publish this as your own work) and as long as it is **NOT USED FOR COMMERCIAL PURPOSES**.
> 
> _DISCLAIMER: THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND,  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR  OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR  THE USE OR OTHER DEALINGS IN THE SOFTWARE._