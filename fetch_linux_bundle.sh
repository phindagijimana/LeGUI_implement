#!/usr/bin/env bash
# Download LeGUI v1.2 Linux binary bundle from Rolston-Lab releases into ./LeGUI_Linux_v1.2/
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
URL="https://github.com/Rolston-Lab/LeGUI/releases/download/v1.2/LeGUI_Linux_v1.2.zip"
ZIP="${ROOT}/LeGUI_Linux_v1.2.zip"
DEST="${ROOT}/LeGUI_Linux_v1.2"

usage() {
  echo "Usage: $(basename "$0") [--force]"
  echo "  Downloads LeGUI Linux v1.2 release and unpacks to: $DEST"
  echo "  --force Replace existing bundle"
}

force=0
for a in "$@"; do
  case "$a" in
    --force) force=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $a" >&2; usage >&2; exit 2 ;;
  esac
done

if [[ -f "${DEST}/LeGUI_Linux" ]] && [[ "$force" -ne 1 ]]; then
  echo "Already present: ${DEST}/LeGUI_Linux"
  echo "Use --force to re-download, or remove the folder first."
  exit 0
fi

mkdir -p "$DEST"
echo "Downloading: $URL"
curl -fL --progress-bar -o "$ZIP" "$URL"
echo "Unpacking to $DEST ..."
unzip -q -o "$ZIP" -d "$DEST"
chmod +x "${DEST}/LeGUI_Linux" "${DEST}/run_LeGUI_Linux.sh" 2>/dev/null || true
chmod -R u+rwX "${DEST}/atlases" 2>/dev/null || true
echo "Done. Next: install MATLAB Runtime R2021b to ${ROOT}/MATLAB_Runtime/v911 (see README / INSTALL.txt), then:"
echo "  ./LeGUI install && ./LeGUI checks && ./LeGUI start"
