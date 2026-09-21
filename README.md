# <img src="docs/img/applemusic-icns_512x512x32.png" alt="Apple Music Alfred Workflow Icon" width="45" align="center"/> Music Volume | Alfred Workflow

Control the volume of the Music app straight from Alfred. Type a command, see exactly what will happen before you press Return, and get instant confirmation. Fast, clean and no third-party apps required.

## Download

- Download it directly [from GitHub here](https://github.com/vanstrouble/music-volume-alfred-workflow/releases/latest).

## Why this version?

This is a fork of [Music Volume by godbout](https://github.com/godbout/alfred-music-volume), rebuilt around a better user experience and a leaner codebase.

- **Live feedback.** Alfred shows the result of your command while you type, like "Volume Up" or "Set Volume to 35%", so you always know what you are about to run.
- **Validation before execution.** Out-of-range values (e.g. `150`) and unknown commands are flagged right in the results and can't be triggered by mistake.
- **Mute and unmute.** Dedicated commands to silence and restore the Music app without touching your volume level.
- **Short commands.** Every action has a one or two letter shortcut: `u`, `d`, `m`, `um`.
- **Optimized scripts.** Setting an exact level takes a single AppleScript call instead of two, and the action script only handles a fixed set of validated actions. No raw input is ever passed to AppleScript.
- **Safe limits.** The volume is always kept between 0 and 100.
- **Clear confirmations.** Every action ends with a short message: "Volume set to 60%.", "Muted." or "Unmuted."

## Usage

Start typing your action in Alfred using your configured keyword (default: `mv`).

<img src="docs/img/music-volume-mv.png" alt="Alfred Music Volume" width="550"/>

- **Keyword:** `mv [action or level]`

### Examples

| Command               | Description                            |
|-----------------------|----------------------------------------|
| `mv up` or `mv u`     | Increases the volume by 10%.           |
| `mv down` or `mv d`   | Decreases the volume by 10%.           |
| `mv 50`               | Sets the volume to 50%.                |
| `mv mute` or `mv m`   | Mutes the Music app.                   |
| `mv unmute` or `mv um`| Unmutes the Music app.                 |

Levels go from `0` to `100`. Anything outside that range is rejected before it runs.

### Compatibility

Works with the Music app on macOS. On macOS versions older than Catalina (10.15), it automatically controls iTunes instead.

### Customization

**Keyword**

The `mv` keyword can be changed in the workflow settings to better suit your needs.

## Credits

Based on [Music Volume](https://github.com/godbout/alfred-music-volume) by [godbout](https://github.com/godbout). Thanks for creating the original workflow.

I made this version to improve a few things that I personally consider important: the interface, the feedback and the performance of the scripts.
