#!/usr/bin/env bash
# Frees ~3.7 GB+ by removing the MCR installer zip and unpacked archives
# after MATLAB_Runtime/v911 is verified. Use --yes to confirm.

set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

if [[ "${1:-}" != "--yes" ]]; then
  echo "This removes: ${HERE}/mcr_R2021b_glnxa64.zip and ${HERE}/mcr_R2021b_unzip/"
  echo "Only run after MATLAB_Runtime/v911 works. Re-run with: $0 --yes"
  exit 2
fi

"${HERE}/verify_legui_setup.sh"
rm -f "${HERE}/mcr_R2021b_glnxa64.zip"
rm -rf "${HERE}/mcr_R2021b_unzip"
echo "Removed MCR installer artifacts. MATLAB_Runtime/v911 kept."
