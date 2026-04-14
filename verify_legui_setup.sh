#!/usr/bin/env bash
# Validates LeGUI + MATLAB Runtime layout on this machine. Exits 0 if OK.

set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
ERR=0

check_dir() {
  local label="$1" path="$2"
  if [[ -d "$path" ]]; then
    echo "OK $label -> $path"
  else
    echo "MISSING $label -> $path" >&2
    ERR=1
  fi
}

check_file() {
  local label="$1" path="$2"
  if [[ -f "$path" ]]; then
    echo "OK  $label -> $path"
  else
    echo "MISSING $label -> $path" >&2
    ERR=1
  fi
}

echo "=== LeGUI layout ==="
check_dir "MATLAB Runtime (v911)" "${HERE}/MATLAB_Runtime/v911"
check_dir "MCR runtime libs" "${HERE}/MATLAB_Runtime/v911/runtime/glnxa64"
check_file "LeGUI binary" "${HERE}/LeGUI_Linux_v1.2/LeGUI_Linux"
check_file "LeGUI run script" "${HERE}/LeGUI_Linux_v1.2/run_LeGUI_Linux.sh"
check_dir "atlases/" "${HERE}/LeGUI_Linux_v1.2/atlases"

if [[ -d "${HERE}/LeGUI_Linux_v1.2/atlases" ]] && [[ -z "$(find "${HERE}/LeGUI_Linux_v1.2/atlases" -mindepth 1 -print -quit 2>/dev/null)" ]]; then
  echo "WARN atlases/ appears empty" >&2
  ERR=1
fi

echo ""
echo "=== MCR install log (last success line) ==="
if [[ -f "${HERE}/mcr_install.log" ]]; then
  if grep -q "End - Successful" "${HERE}/mcr_install.log"; then
    echo "OK  mcr_install.log reports success"
  else
    echo "WARN mcr_install.log does not contain 'End - Successful'" >&2
    ERR=1
  fi
else
  echo "WARN no mcr_install.log" >&2
fi

echo ""
echo "=== Dynamic linker (LeGUI vs MCR) ==="
MCR="${HERE}/MATLAB_Runtime/v911"
export LD_LIBRARY_PATH=.:${MCR}/runtime/glnxa64:${MCR}/bin/glnxa64:${MCR}/sys/os/glnxa64:${MCR}/sys/opengl/lib/glnxa64
missing="$(ldd "${HERE}/LeGUI_Linux_v1.2/LeGUI_Linux" 2>&1 | grep 'not found' || true)"
if [[ -n "$missing" ]]; then
  echo "$missing" >&2
  ERR=1
else
  echo "OK  no missing shared libraries in ldd output"
fi

echo ""
echo "=== Source tree (optional) ==="
check_dir "git clone legui-repo" "${HERE}/legui-repo/LeGUI"

if [[ "$ERR" -ne 0 ]]; then
  echo ""
  echo "Verification FAILED (see above)." >&2
  exit 1
fi
echo ""
echo "All checks passed. Run: ${HERE}/run_LeGUI.sh"
exit 0
