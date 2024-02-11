# FS Build - The Archive Manager For Farming Simulator 22 Mods

Automizes the process of creating zip archives for your mod with QoL features as automatic version bump, running TestRunner tool and more. This is for most part a "set and forget" tool that you config once and then you don't need to think much about it.

**Main features:**
* Automatically create zip archive (support blacklist of files) according to ModHub standard
* Automatically execute TestRunner tool and display the results
* Automatically start Farming Simulator 22 with a specific savegame
* Manages version increments (both fully automatic and with user interaction)
* Supports having "[DEV]" and "[TEST]" prefix in mod title to distinguish between versions
* Copy zip archive to a second mod folder (e.g. a network share) for multiplayer testing


## Version auto-increment

```json
"versionBump": {
    "increaseOnBuild": "always",
    "increaseOnRelease": "ask"
},
```

The `increaseOnBuild` option has the possible values `never` and `always`. Value `always` will incremement the build number (i.e. +0.0.0.1). 

Option `increaseOnRelease` has the following possible values:
* `never` No automatic increase
* `major` Increases major version (i.e. `+1.0.0.0`) - typically for breaking changes
* `minor` Increases minor version (i.e. `+0.1.0.0`) - typically for regular changes
* `patch` Increases patch version (i.e. `+0.0.1.0`) - typically for hotfixes and patches
* `ask` Ask the user what do to (possible actions are "no increment", "major", "minor" and "patch")

`N.B.: build version is always 0 on release builds, e.g "1.0.0.2" becomes "1.0.0.0" on release`



## License
Below you find the legal stuff. This is there to protect the creations made by Open Modding Alliance to make sure no one claims this as their protected property or used for commercial purposes, and with that out of the way, we want to empahize that we encourage you to (directly or indirectly) [contribute](TBD) to our openly shared assets.

You are **allowed to fork** the repo and **make changes** for personal use, and if you do improvements, please send us a **pull request** and we will try to incorporate your changes in the official repo (and you will of course be attributed/credited).

> **FS Build is licensed under CC BY-NC-ND 4.0 (Creative Commons Attribution-NonCommercial-ShareAlike).**
> 
> TL;DR: You are **ALLOWED TO SHARE** (copy and redistribute) the material in any medium or format as long as you **ATTRIBUTE** (give appropriate credit to) the original author, do **NOT MAKE ANY DERIVATIVES** (i.e. do not modify and re-publish this as your own work) and as long as it is **NOT USED FOR COMMERCIAL PURPOSES**.
> 
> _DISCLAIMER: THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND,  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR  OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR  THE USE OR OTHER DEALINGS IN THE SOFTWARE._