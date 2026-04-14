#!/usr/bin/env bash
# Example: run LeGUI on a cluster after you have a graphical session.
#
# Typical patterns:
#   1) Open OnDemand / FastX / TurboVNC desktop -> open terminal -> ./run_LeGUI.sh
#   2) salloc/srun --x11 (site-specific) -> module load X11 apps -> ./run_LeGUI.sh
#   3) ssh -Y login.node (latency can be high for GUIs)
#
# This script only documents the local paths; adapt #SBATCH / salloc for your site.

LEGUI_ROOT="${LEGUI_ROOT:-$HOME/Documents/LeGUI}"
if [[ ! -x "${LEGUI_ROOT}/run_LeGUI.sh" ]]; then
  echo "Set LEGUI_ROOT to your install (contains run_LeGUI.sh). Now: ${LEGUI_ROOT}" >&2
  exit 1
fi

cd "$LEGUI_ROOT"
exec ./run_LeGUI.sh
