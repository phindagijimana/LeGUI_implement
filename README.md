# LeGUI_implement — run LeGUI on **this machine** (Option 1)

Use this repo to **operate LeGUI v1.2 locally**: scripts stay in git; the **Linux app** and **MATLAB Runtime** live next to them on disk only (see `.gitignore`).

---

## Option 1 — checklist (run here only)

Do these **in the same directory** as `LeGUI` / `run_LeGUI.sh` (e.g. after `git clone`).

### 1) Get the compiled Linux app

Either:

```bash
./LeGUI fetch              # downloads v1.2 from Rolston-Lab releases → ./LeGUI_Linux_v1.2/
# or: ./LeGUI fetch --force to replace
```

Or [download **`LeGUI_Linux_v1.2.zip` manually](https://github.com/Rolston-Lab/LeGUI/releases/tag/v1.2) and unzip so you have:

`./LeGUI_Linux_v1.2/LeGUI_Linux` and `./LeGUI_Linux_v1.2/run_LeGUI_Linux.sh`.

### 2) Install MATLAB Runtime **R2021b** (v9.11)

LeGUI v1.2 requires this runtime. Install so the tree includes:

`./MATLAB_Runtime/v911/runtime/glnxa64/`

See **[INSTALL.txt](INSTALL.txt)** and [MATLAB Runtime download](https://www.mathworks.com/products/compiler/matlab-runtime.html).  
If you already have an unpacked installer in `./mcr_R2021b_unzip/`, you can run:

```bash
./LeGUI install --silent-mcr
```

(long run; installs into `./MATLAB_Runtime/`).

### 3) Prepare, verify, launch

Use a **graphical session** (desktop, VNC/OnDemand, or `ssh -Y`).

```bash
./LeGUI install    # permissions, logs dir
./LeGUI checks     # layout + ldd
./LeGUI start      # GUI
```

---

## CLI reference

| Command | Purpose |
|---------|---------|
| `./LeGUI fetch` | Download + unpack Linux v1.2 bundle |
| `./LeGUI install` | Local prep + verification |
| `./LeGUI install --silent-mcr` | Silent MCR install (if unzip dir present) |
| `./LeGUI checks` | Full checks |
| `./LeGUI start` | Foreground GUI (`--background` optional) |
| `./LeGUI logs` / `stop` | Background run helpers |
| `./LeGUI help` | Usage |

```bash
export LEGUI_MCR_ROOT=/path/to/MATLAB_Runtime/v911   # if non-default
./run_LeGUI.sh
```

Cluster notes: `hpc/example_interactive_session.sh`.  
**Open OnDemand:** use an interactive **Desktop** session in the browser, then run `./LeGUI start` in a terminal *inside that desktop* — see **`hpc/open_ondemand.md`**.

---

## What this repo contains (in git)

| Path | Purpose |
|------|---------|
| `LeGUI` | CLI above |
| `fetch_linux_bundle.sh` | Used by `./LeGUI fetch` |
| `run_LeGUI.sh` | Launch app with local MCR |
| `verify_legui_setup.sh` | Validate layout + `ldd` |
| `post_install_cleanup.sh` | Remove local MCR zip/unzip after install |
| `env_legui.sh` | `source` for paths |
| `hpc/` | Example session |
| `INSTALL.txt` | Detailed install |
| `LeGUI.md` | Paper summary |
| `LeGUI_br.md` | Builder Review |

**Optional locally (not in git):** `legui-repo/` (MATLAB source), `LeGUI.pdf`, extra docs.

---

## Documentation

- Paper: [10.3389/fnins.2021.769872](https://doi.org/10.3389/fnins.2021.769872)
- Manuals: [Installation guide (PDF)](https://github.com/Rolston-Lab/LeGUI/blob/main/LeGUI_InstallationGuide.pdf), [User manual (PDF)](https://github.com/Rolston-Lab/LeGUI/blob/main/LeGUI_UserManual.pdf)
