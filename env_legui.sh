#!/usr/bin/env bash
# Source this file to set paths in your shell (e.g. for debugging):
#   source /path/to/LeGUI/env_legui.sh

LEGUI_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
export LEGUI_HOME
export LEGUI_MCR_ROOT="${LEGUI_MCR_ROOT:-${LEGUI_HOME}/MATLAB_Runtime/v911}"
export PATH="${LEGUI_HOME}:${PATH}"
