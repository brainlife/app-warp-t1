<h1 align="center">Warp T1 and tensor</h1>

<p align="center">
  A T1-weighted image and its FA, MD, RD and AD tensor maps moved into a new space with a previously computed non-linear warp and affine, using ANTs.
</p>

<p align="center">
  <a href="https://github.com/brainlife/abcd-spec"><img src="https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg" alt="ABCD Spec v1.1"></a>
  <a href="https://doi.org/10.25663/brainlife.app.448"><img src="https://img.shields.io/badge/Brainlife-brainlife.app.448-blue.svg" alt="Run on brainlife.io"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="MIT license"></a>
</p>

## 🧠 At a glance

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

> **Applies a given non-linear warp and affine to a T1-weighted image and to FA, MD, RD and AD tensor maps with ANTs WarpImageMultiTransform.**

Warps the T1 and the FA, MD, RD and AD maps with ANTs WarpImageMultiTransform using the provided warp.nii.gz and affine.txt (nearest-neighbour interpolation). Use it to bring a subject's T1 and tensor maps into the space defined by a previously computed non-linear registration. The transform input must contain both the warp and the affine.

| | |
|---|---|
| 📥 **Inputs** | `neuro/anat/t1w` · `neuro/tensor` · `neuro/transform/nifti` |
| 📤 **Outputs** | `neuro/anat/t1w` · `neuro/tensor` |
| 🐳 **Container** | `brainlife/ants:2.2.0` |
| ⚙️ **Resources** | 4 CPUs · 0.33 h walltime |
| 🔗 **Run it** | [doi.org/10.25663/brainlife.app.448](https://doi.org/10.25663/brainlife.app.448) |

#### 📥 Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `0` | `neuro/anat/t1w` | yes | T1 image to warp |
| `1` | `neuro/tensor` | yes | tensor images to warp |
| `2` | `neuro/transform/nifti` (!linear) | yes | non-linear warp to use for warping. affine.txt must be present; the App exits otherwise. |

#### 📤 Outputs

| Output | Datatype | Description |
|---|---|---|
| `t1_aligned` | `neuro/anat/t1w` | warped T1 |
| `tensor_aligned` | `neuro/tensor` | warped tensor |

<!-- brainlife-app:end -->

## 🔬 How it works

The App applies a given non-linear warp (`warp.nii.gz`) and affine (`affine.txt`) to the T1 image and to the diffusion tensor scalar maps with ANTs `WarpImageMultiTransform`, using nearest-neighbour interpolation. Use it to bring a subject's T1 and tensor maps into the space of a non-linear registration computed earlier, for example by a registration App on brainlife.io.

The supported scalars are FA (fractional anisotropy), MD (mean diffusivity), RD (radial diffusivity) and AD (axial diffusivity).

> **Warning:** the T1 and the tensor maps must be in the same anatomical space, the one the warp was computed from.

## 🚀 Running the App

### ☁️ On brainlife.io

Open the App at [doi.org/10.25663/brainlife.app.448](https://doi.org/10.25663/brainlife.app.448), choose a T1-weighted image (`neuro/anat/t1w`), its tensor maps (`neuro/tensor`) and a non-linear transform (`neuro/transform/nifti`, not tagged `linear`) that contains both the warp and the affine, and press **Execute**. The warped T1 (`neuro/anat/t1w`) and tensor maps (`neuro/tensor`) are archived to your project.

### 💻 Locally

You need [Singularity/Apptainer](https://apptainer.org/) and [`jq`](https://jqlang.github.io/jq/). `main` runs the warping in the `brainlife/ants:2.2.0` container; without Singularity you need [ANTs](https://github.com/ANTsX/ANTs) 2 or later.

1. Clone this repository and check out the App's branch: `git checkout 1.0`.
2. Create `config.json` with the paths to your inputs:

   ```json
   {
       "t1": "./t1.nii.gz",
       "fa": "./tensor/fa.nii.gz",
       "md": "./tensor/md.nii.gz",
       "rd": "./tensor/rd.nii.gz",
       "ad": "./tensor/ad.nii.gz",
       "warp": "./transform/warp.nii.gz",
       "affine": "./transform/affine.txt"
   }
   ```

3. Run the App:

   ```bash
   ./main
   ```

## 📦 Outputs

```text
t1_aligned/
└── t1.nii.gz        the warped T1
tensor_aligned/
├── fa.nii.gz        the warped tensor maps
├── md.nii.gz
├── rd.nii.gz
└── ad.nii.gz
```

## 🩺 Troubleshooting

- **`ERROR: affine.txt not found, but has to be provided. Process terminated.`**: provide a transform dataset that includes `affine.txt`.
- **`T1 warping failed.`** or **`Tensor warping failed.`**: check the log for `WarpImageMultiTransform` errors.

## 📚 Citing

> [!TIP]
> If you use this App in your work, please cite the App, the software it builds on and brainlife.io (below). GitHub's **Cite this repository** button gives the App citation in APA and BibTeX.

- Avants BB, Epstein CL, Grossman M, Gee JC. Symmetric diffeomorphic image registration with cross-correlation: evaluating automated labeling of elderly and neurodegenerative brain. *Medical Image Analysis* 12(1):26–41 (2008). [doi:10.1016/j.media.2007.06.004](https://doi.org/10.1016/j.media.2007.06.004)
- Warp T1 and tensor. brainlife.io App. [doi:10.25663/brainlife.app.448](https://doi.org/10.25663/brainlife.app.448)
- Avants et al. A reproducible evaluation of ANTs similarity metric performance in brain image registration. *NeuroImage* 54:2033-2044 (2011). [doi:10.1016/j.neuroimage.2010.09.025](https://doi.org/10.1016/j.neuroimage.2010.09.025)
- Hayashi S, Caron BA, Heinsfeld AS, et al. brainlife.io: a decentralized and open-source cloud platform to support neuroscience research. *Nature Methods* 21:809–813 (2024). [doi:10.1038/s41592-024-02237-2](https://doi.org/10.1038/s41592-024-02237-2)
- Avesani P, McPherson B, Hayashi S, et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. *Scientific Data* 6:69 (2019). [doi:10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)

## 👥 Authors

- Giulia Bertò

**Contributors:** Paolo Avesani

## 💰 Funding

[![Wellcome-226486/Z/22/Z](https://img.shields.io/badge/Wellcome-226486%2FZ%2F22%2FZ-purple.svg)](https://wellcome.org/)
[![NIH-NINDS-U24NS140384](https://img.shields.io/badge/NIH_NINDS-U24NS140384-green.svg)](https://reporter.nih.gov/project-details/11261037)
[![NIH-NINDS-UM1NS132207](https://img.shields.io/badge/NIH_NINDS-UM1NS132207-green.svg)](https://reporter.nih.gov/project-details/11411328)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://reporter.nih.gov/project-details/10262925)
[![NIH-NIBIB-R01EB030896](https://img.shields.io/badge/NIH_NIBIB-R01EB030896-green.svg)](https://reporter.nih.gov/project-details/10428625)
[![NIH-NIMH-R01MH126699](https://img.shields.io/badge/NIH_NIMH-R01MH126699-green.svg)](https://reporter.nih.gov/project-details/10460628)
[![NIH-NIDCD-R01DC020088](https://img.shields.io/badge/NIH_NIDCD-R01DC020088-green.svg)](https://reporter.nih.gov/project-details/11140284)
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-2203524](https://img.shields.io/badge/NSF_BCS-2203524-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2203524)
[![NSF-IIS-1636893](https://img.shields.io/badge/NSF_IIS-1636893-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-OAC-2148729](https://img.shields.io/badge/NSF_OAC-2148729-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148729)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NSF-IIS-2148700](https://img.shields.io/badge/NSF_IIS-2148700-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148700)
[![NSF-OAC-1916518](https://img.shields.io/badge/NSF_OAC-1916518-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1916518)

<sub>brainlife.io is publicly funded, and acknowledging that support helps keep it running. This App was developed with support from Wellcome, the U.S. National Institutes of Health (including the BRAIN Initiative BRAIN CONNECTS program: The Axonal Projectome EXchange, U24NS140384, and the Center for Mesoscale Connectomics, UM1NS132207) and the U.S. National Science Foundation.</sub>

## ⚖️ License

[MIT](LICENSE), Copyright (c) 2020 brainlife.io, The University of Texas at Austin and Indiana University. ANTs is distributed under its own license.
