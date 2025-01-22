### Startup Launcher Commands for Linux Mint Startup Applications

```bash
# Launch Chrome in first workspace
sh -c 'google-chrome-stable %U & sleep 5 && wmctrl -x -r google-chrome.Google-chrome -t 0'

# Launch Terminator in second workspace
sh -c 'terminator & sleep 5 && wmctrl -x -r terminator.Terminator -t 1'

# Launch Discord in the last workspace
sh -c '/usr/share/discord/Discord & sleep 5 && total_ws=$(wmctrl -d | wc -l) && last_ws=$((total_ws - 1)) && wmctrl -x -r discord.Discord -t "$last_ws"'
