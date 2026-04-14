# LeGUI — Paper summary

**Full title:** LeGUI: A Fast and Accurate Graphical User Interface for Automated Detection and Anatomical Localization of Intracranial Electrodes  

**Authors:** Davis TS, Caston RM, Philip B, Charlebois CM, Anderson DN, Weaver KE, Smith EH, Rolston JD  

**Journal:** *Frontiers in Neuroscience* (2021), Volume 15, Article 769872  

**DOI:** [10.3389/fnins.2021.769872](https://doi.org/10.3389/fnins.2021.769872)  

**Code:** [https://github.com/Rolston-Lab/LeGUI](https://github.com/Rolston-Lab/LeGUI)  

---

## What the paper is about

Accurate placement of intracranial electrodes in anatomical space matters for epilepsy surgery (seizure focus) and for interpreting cognitive neuroscience studies that use intracranial EEG (ECoG, SEEG). The usual workflow is: coregister post-implant CT to pre-implant MRI, find electrode locations on CT, then map those locations to brain anatomy using the MRI (often with an atlas in standard space).

Many existing tools chain separate programs or rely on the command line, are hard to install, take a long time to run, require heavy manual electrode clicking, or only support part of the pipeline (e.g., ECoG but not SEEG).

**LeGUI** (“Locate electrodes Graphical User Interface”) is presented as a single MATLAB-based GUI that runs the full pipeline—CT–MRI coregistration, MRI normalization to MNI, automated detection for multiple electrode types, correction/projection of contacts, labeling, and atlas-based anatomical naming—with SPM12 for core image processing and standalone executables (Windows, Mac, Linux) plus GPL v3 open source.

---

## Main technical workflow (high level)

1. **Inputs:** Pre-implant T1 MRI and post-implant CT (DICOM → NIfTI; ideally ≤1 mm slice thickness). RAS orientation; optional manual90° fixes.
2. **MRI prep:** Crop/rotate toward AC–PC space; resample to 0.4 mm isotropic voxels for consistent rendering.
3. **Coregistration:** Rigid 6-DOF CT→MRI via SPM (`spm_coreg`), normalized mutual information; CT resliced to match MRI.
4. **Segmentation & normalization:** SPM “unified segmentation” (tissue classes, bias correction, nonlinear warp to MNI). Deformation fields `y_MR.nii` / `iy_MR.nii` saved for atlas warping.
5. **Surfaces:** Brain surface and a more smoothed “projection” surface (for brain-shift correction) from gray/white masks; small islands removed with DBSCAN.
6. **Electrode detection:** Automated search over many CT intensity thresholds; connected components inside the projection surface with size constraints; stable-threshold selection; cleanup; manual add/delete supported. Default cap of 250 contacts (configurable in code).
7. **Post-processing:** ECoG projection to surface (Hermes-style grid normals or manual vectors); SEEG spacing/alignment correction along labeled columns using known inter-contact spacing.
8. **Labeling:** UI links 3D contacts to alphanumeric labels and recording channels; **inline projection** rotates slices so an entire SEEG shaft appears in one 2D plane.
9. **Anatomy:** Warp electrode voxels to MNI; label via mode of atlas voxels in a sphere. Default atlases: Neuromorphometrics (NMM, with SPM) and SPM Anatomy toolbox; custom MNI atlases via an `atlases` folder. Gray vs. white: Wilcoxon test on SPM gray/white probability maps inside each electrode sphere (*p* < 0.001), else default gray; “Unknown” if both means < 0.1.
10. **Outputs:** `Registered/` folder with NIfTIs, surfaces, warped atlases (`lw*.nii`), `Electrodes.mat`, `ChannelMap.mat` (preferred for analysis—rows match channel order), and `ReadMe.txt`.

---

## Validation (what they measured)

- **Cohort:** 51 datasets—48 from University of Utah (2015–2021), 3 from University of Washington (different scanners/protocols/vendors). ~5089 contacts total (mostly Utah). IRB-approved.
- **End-to-end time:** ~1 hour per dataset (paper abstract); image-processing median ~31.7 min (21.9–40.3 min) including ~5–10 min user time for DICOM pick + AC/PC/midsagittal; automatic detection ~15.6 s median; assignment median ~9.8 min (ECoG labeling slower per contact than SEEG).
- **Automatic detection:** 4362 / 4695 true positives, 71 false positives (~93% sensitivity). Best on Ad-Tech SEEG; ECoG and Dixi SEEG harder (smaller contacts, overlap, slice-plane effects). Optimal HU thresholds were dataset-specific and bimodal—argues against a single fixed global threshold.
- **ECoG projection:** Grid vs. manual normal-based projection: similar median shift distances (~4 mm); slight inter-contact expansion after projection.
- **SEEG alignment:** Small median correction ~0.23 mm (often sub-voxel rounding).
- **Gray/white:** Resting LFP standard deviation higher in gray than white (1066 contacts, 17 patients), consistent with physiology literature.
- **Anatomy vs. expert:** For 482 contacts in temporal/medial temporal regions, single-label match (1.3 mm sphere) **73%**; using ranked labels in a **1 cm** sphere (≥5% volume), **94%** match to hand labels from an experienced neuroanatomist. Some regions (e.g., STG vs. MTG at gyral borders) explain mismatches at fine resolution.
- **Functional sanity check:** CCEPs after stimulation aligned with SPM Anatomy labels (IFL ↔ IPL example).

They explicitly note that coregistration quality, segmentation quality, and subjective ease-of-use were **not** fully quantified; LeGUI is **not** FDA-evaluated.

---

## Discussion takeaway

LeGUI is positioned as an **all-in-one, cross-platform** tool that keeps dependency weight lower than many FreeSurfer-heavy stacks, runs SPM-based normalization in ~tens of minutes rather than multi-hour FreeSurfer runs, and unifies detection, shift correction, labeling, and atlas naming in **one** interface with linked 2D/3D views. The authors argue this supports standardized, reproducible localization for intracranial electrophysiology research.

---

## Keywords (from the paper)

MATLAB; anatomical localization; GUI; ECoG; software; SEEG; intracranial electrode localization.

---

*Summary prepared from the published paper; for exact wording, figures, and supplementary material, see the [open-access article](https://www.frontiersin.org/articles/10.3389/fnins.2021.769872/full). A local PDF copy is optional.*

---

## This workspace

For **Option 1** (run on this machine only: `./LeGUI fetch`, MCR R2021b, `./LeGUI start`), see [README.md](README.md).
