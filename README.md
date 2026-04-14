# LeGUI — local install

This directory contains a **full LeGUI v1.2 deployment** using the **MATLAB Runtime R2021b** (v9.11): compiled app, runtime, launcher, and a git clone of the [upstream repo](https://github.com/Rolston-Lab/LeGUI).

## CLI (recommended)

```bash
cd ~/Documents/LeGUI    # or the full path to this directory
./LeGUI help
./LeGUI install         # permissions, logs dir, verification
./LeGUI checks          # same as verify_legui_setup.sh
./LeGUI start           # foreground GUI
./LeGUI start --background   # optional; logs -> logs/legui.log
./LeGUI logs            # tail recent log
./LeGUI logs -f         # follow log
./LeGUI stop            # stop background instance (pid in .legui.pid)
```

`./LeGUI install --silent-mcr` runs the MATLAB Runtime silent installer from `mcr_R2021b_unzip/` only if `MATLAB_Runtime/v911` is missing (can take a long time).

You need a **graphical environment** (desktop, VNC/OnDemand, or `ssh -Y`) for the GUI. See `hpc/example_interactive_session.sh` for cluster notes.

## Quick start (without CLI)

```bash
./verify_legui_setup.sh
./run_LeGUI.sh
```

## What is here

| Path | Purpose |
|------|---------|
| `LeGUI` | **CLI**: `install`, `start`, `logs`, `stop`, `checks` |
| `run_LeGUI.sh` | Starts LeGUI with local `MATLAB_Runtime/v911` |
| `verify_legui_setup.sh` | Checks runtime, binary, atlases, `ldd` |
| `env_legui.sh` | `source` to set `LEGUI_HOME` / `LEGUI_MCR_ROOT` |
| `MATLAB_Runtime/v911/` | MATLAB Runtime R2021b |
| `LeGUI_Linux_v1.2/` | Compiled app + `atlases/` |
| `legui-repo/` | Source + SPM bundle + PDF manuals |
| `INSTALL.txt` | Detailed install notes |
| `LeGUI.md` | Short summary of the *Frontiers* paper |

Override the runtime location if needed:

```bash
export LEGUI_MCR_ROOT=/path/to/MATLAB_Runtime/v911
./run_LeGUI.sh
```

## Free disk space (optional)

After `verify_legui_setup.sh` passes:

```bash
./post_install_cleanup.sh --yes
```

Removes `mcr_R2021b_glnxa64.zip` (~3.7 GB) and `mcr_R2021b_unzip/`; **does not** remove `MATLAB_Runtime/`.

## Documentation

- Paper: [10.3389/fnins.2021.769872](https://doi.org/10.3389/fnins.2021.769872)
- Upstream manuals: `legui-repo/LeGUI_InstallationGuide.pdf`, `legui-repo/LeGUI_UserManual.pdf`
