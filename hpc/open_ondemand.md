# LeGUI via Open OnDemand (OOD)

LeGUI is a **desktop GUI**. On clusters, you use OOD’s **interactive desktop** in the browser; that session provides a real `DISPLAY`, so the compiled app + MATLAB Runtime work the same as on a physical Linux workstation.

## 1. Start a desktop session in OOD

1. Log into your center’s **Open OnDemand** portal (browser).
2. Open **Interactive Apps** (or **Apps**).
3. Choose a **Desktop**-style app (names vary by site), for example:
   - “Desktop”, “XFCE”, “GNOME”, “Linux Desktop”, “Interactive Desktop”, etc.
4. Request enough resources for **SPM segmentation / normalization** (LeGUI is memory-hungry here). If unsure, start with **≥16 GB RAM** and **≥2 CPUs**; increase if jobs exit or swap heavily.
5. Launch and wait until the **Connect** / **Launch Desktop** link opens a full Linux desktop **inside the browser tab**.

Your site’s docs take precedence if labels or limits differ.

## 2. Open a terminal inside that desktop

Use the desktop’s terminal emulator (e.g. “Terminal”, “Xfce Terminal”).  
**Do not** rely on a non-interactive batch job or a plain SSH shell without a desktop—there is usually **no `DISPLAY`**, so the GUI will not start.

Check (optional):

```bash
echo "$DISPLAY" # should be non-empty, e.g. :1.0
```

## 3. Run LeGUI from your install directory

Adjust the path to match where you cloned or copied **LeGUI_implement** (NFS home is typical):

```bash
export LEGUI_ROOT="$HOME/Documents/LeGUI" # or your path
cd "$LEGUI_ROOT"

# One-time per machine: fetch binary + install MCR under ./MATLAB_Runtime/v911 (see README)
./LeGUI checks
./LeGUI start
```

Or:

```bash
./run_LeGUI.sh
```

You need **`LeGUI_Linux_v1.2/`** and **`MATLAB_Runtime/v911/`** present next to these scripts (not on GitHub; local only).

## 4. If the window is slow or tiny

- Use OOD’s **full-screen** or **resize** options for the desktop viewer.
- Prefer running the desktop session on a **compute node** with the resources you requested, not an overloaded login node (depends on site configuration).

## 5. Common failures

| Symptom | What to check |
|--------|----------------|
| `DISPLAY` unset / cannot open display | You are not inside the OOD **desktop** session; start Interactive Desktop and use its terminal. |
| Missing libraries / MCR errors | `MATLAB_Runtime` must be **R2021b** and match **LeGUI v1.2**; run `./LeGUI checks`. |
| App starts then dies during “big” steps | Request **more RAM** for the desktop job; SPM steps are heavy. |
| Very laggy | Normal over VNC; close extra apps; use local resolution scaling; run on a closer cluster if available. |

## 6. MATLAB license

For the **compiled** Linux app + **MATLAB Runtime**, you do **not** need a full MATLAB license—only the **Runtime** install on the shared filesystem (or in your home).

---

*Site-specific: queue names, partition, module commands, and desktop app names come from your HPC documentation.*
