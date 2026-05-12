#!/usr/bin/env bash
export WINEPREFIX="@winePrefix@"

VORTEX_DIR="$WINEPREFIX/drive_c/Program Files/Black Tree Gaming Ltd/Vortex"
cd "$VORTEX_DIR" || exit 1

URL=""
for arg in "$@"; do
  if [[ "$arg" == *"nxm://"* ]]; then URL="$arg"; break; fi
done

if pgrep -f "[V]ortex.exe" > /dev/null; then
  if [[ -n "$URL" ]]; then
    echo "Vortex is already running. Forwarding link via headless Wine..."
    
    # Находим активный Wine
    WINESERVER_PATH=$(pgrep -f "wineserver" -a | head -n 1 | awk '{print $2}')
    WINE_BIN=$(echo "$WINESERVER_PATH" | sed 's/wineserver/wine/')

    if [[ -f "$WINE_BIN" ]]; then
      # Запускаем Vortex в виртуальном X-сервере. 
      # Окно отрисуется в памяти, отправит сигнал первому процессу и закроется.
      @xvfbRun@ -a @steamRun@/bin/steam-run "$WINE_BIN" Vortex.exe -d "$URL"
    else
      # Если не нашли активный wine, пробуем через umu, но это создаст окно
      @umuLauncher@/bin/umu-run Vortex.exe -d "$URL"
    fi
    exit 0
  else
    echo "Vortex is already running."
    exit 0
  fi
else
  # Первый запуск (нормальный графический интерфейс)
  export PROTON_USE_WINED3D=1
  export GAMEID="umu-vortex"
  if [[ -n "$URL" ]]; then
    exec @umuLauncher@/bin/umu-run Vortex.exe -d "$URL"
  else
    exec @umuLauncher@/bin/umu-run Vortex.exe
  fi
fi
