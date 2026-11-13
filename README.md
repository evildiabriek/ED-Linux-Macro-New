# ED Linux Macro (new version)

Remake of my old C macro for sols, now in zig.
Windows version soon

## How compile

---

```bash
zig build run-macro
```

IMPORTANT: you NEED to go in `ED-Linux-Macro-New` folder (or at least have the  
Python file in a 'python' folder right below it)

## Configuration

---

Configuration is in the file: `~/.edlinuxmacro/config.cfg`  
How setup your config:  

```txt
[rld]>FILEPATH<[rld]
[p]>PRIVATE_SERVER_LINK<[p]
[w]>WEBHOOK<[w]
```

rld: Is the MOST important parameter, is OBLIGATORY for macro;  
It's the Roblox Log Dir (or Sober)  

p: private server link

w: webhook for send macro. And its the only one you can put infinite link  
For add one webhook, just add a line with `[w]>WEBHOOK<[w]`

## Starting

---

Just run the `.zig_out/bin/EDmacro`

## NDT

---

If the macro immediatly shutdown after starting, quit and restart your server  
Its because the auto rejoin dont write to log your ingame  
(for the macro, you quit and dont rejoin)
