#!/usr/bin/env bash
export WINEPREFIX="@winePrefix@"

# Fix for AMD open source drivers and GUI apps
export PROTON_USE_WINED3D=1
export PROTON_NO_ESYNC=1
export PROTON_NO_FSYNC=1

cd "$WINEPREFIX/drive_c/Program Files/Black Tree Gaming Ltd/Vortex" || exit 1

# Check for -d or -i with no "nxm" in the following argument
if [[ ("$1" == "-d" || "$1" == "-i") && "$2" != *"nxm"* ]]; then
  echo "No url provided, ignoring $1"
  exec @umuLauncher@/bin/umu-run Vortex.exe
else
  export PROTON_VERB="runinprefix"
  exec @umuLauncher@/bin/umu-run Vortex.exe "$@"
fi
