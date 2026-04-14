#!/usr/bin/env bash
# Launches LeGUI v1.2 with MATLAB Runtime R2021b (v9.11).
# Requires a graphical session (X11, Wayland) or SSH X11 forwarding.

set -euo pipefail
SCRIPT="${BASH_SOURCE[0]:-$0}"
HERE="$(cd "$(dirname "$SCRIPT")" && pwd -P)"
MCR_ROOT="${LEGUI_MCR_ROOT:-${HERE}/MATLAB_Runtime/v911}"

if [[ ! -d "$MCR_ROOT/runtime/glnxa64" ]]; then
  echo "ERROR: MATLAB Runtime not found at: $MCR_ROOT" >&2
  echo "Set LEGUI_MCR_ROOT to the v911 root, or install MCR under: ${HERE}/MATLAB_Runtime" >&2
  exit 1
fi

LG_BIN="${HERE}/LeGUI_Linux_v1.2/run_LeGUI_Linux.sh"
if [[ ! -x "$LG_BIN" ]]; then
  echo "ERROR: LeGUI launcher missing or not executable: $LG_BIN" >&2
  exit 1
fi

if [[ -z "${DISPLAY:-}" && -z "${WAYLAND_DISPLAY:-}" ]]; then
  echo "WARNING: DISPLAY and WAYLAND_DISPLAY are unset. LeGUI is a GUI and usually needs:" >&2
  echo "  - a desktop session, or" >&2
  echo "  - ssh -Y user@host  (X11 forwarding), or" >&2
  echo "  - a VNC or browser-based remote desktop on your cluster." >&2
fi

exec "$LG_BIN" "$MCR_ROOT" "$@"
