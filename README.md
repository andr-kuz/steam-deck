This is NixOS implementation of

# pikdum's steam deck tools

More information at the [original repository](https://github.com/pikdum/steam-deck/)

## Installation

Just clone this repository in any path then `cd` to it and run:
```sh
nix-shell
./result/bin/vortex-install
```
wait for a while until script finishes all the downloads. Then run Vortex

```sh
./result/share/applications/vortex-wrapper.sh
```
or launch `Vortex` directly from your application manager (e.g., wofi, rofi, app. menu)

## TODO
- [x] passing `nxm://` arguments to Vortex
- [x] `Vortex.desktop` file deployment
- [ ] do not open new Vortex process every time
- [ ] game mods deployment
