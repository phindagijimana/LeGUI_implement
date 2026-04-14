# LeGUI_implement — deployment toolkit (minimal GitHub footprint)

This repository holds **scripts and documentation** to run [LeGUI v1.2](https://github.com/Rolston-Lab/LeGUI/releases) with **MATLAB Runtime R2021b** (v9.11). Large or upstream artifacts stay **local** (see `.gitignore`).

## What you need locally (not in this repo)

| Item | How to obtain |
|------|----------------|
| **LeGUI Linux app** | Download **`LeGUI_Linux_v1.2.zip`** from [LeGUI releases](https://github.com/Rolston-Lab/LeGUI/releases/latest), unzip to **`LeGUI_Linux_v1.2/`** next to these scripts. |
| **MATLAB Runtime R2021b** | [MATLAB Runtime R2021b](https://www.mathworks.com/products/compiler/matlab-runtime.html) → install to **`MATLAB_Runtime/v911/`** (see `INSTALL.txt`). |
| **Upstream source (optional)** | `git clone https://github.com/Rolston-Lab/LeGUI.git legui-repo` if you want MATLAB source + bundled SPM + PDF manuals. |

## CLI

```bash
./LeGUI help
./LeGUI install         # permissions, logs dir; run after binary + MCR are in place
./LeGUI checks
./LeGUI start
```

Use a **graphical session** (desktop, VNC/OnDemand, or `ssh -Y`). See `hpc/example_interactive_session.sh`.

`./LeGUI install --silent-mcr` only applies if you have unpacked the MCR installer under `mcr_R2021b_unzip/` (local).

## Files tracked here

| Path | Purpose |
|------|---------|
| `LeGUI` | CLI: `install`, `start`, `logs`, `stop`, `checks` |
| `run_LeGUI.sh` | Launch compiled app with local MCR |
| `verify_legui_setup.sh` | Validate layout + `ldd` |
| `post_install_cleanup.sh` | Remove local MCR zip/unzip after install |
| `env_legui.sh` | `source` for `LEGUI_HOME` / `LEGUI_MCR_ROOT` |
| `hpc/` | Cluster session example |
| `INSTALL.txt` | Detailed install |
| `LeGUI.md` | Paper summary |
| `LeGUI_br.md` | Builder Review |

```bash
export LEGUI_MCR_ROOT=/path/to/MATLAB_Runtime/v911
./run_LeGUI.sh
```

## Documentation

- Paper: [10.3389/fnins.2021.769872](https://doi.org/10.3389/fnins.2021.769872)
- Upstream manuals (in cloned repo or release): [Installation guide (PDF)](https://github.com/Rolston-Lab/LeGUI/blob/main/LeGUI_InstallationGuide.pdf), [User manual (PDF)](https://github.com/Rolston-Lab/LeGUI/blob/main/LeGUI_UserManual.pdf)
