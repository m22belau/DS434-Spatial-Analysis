# 🌺 GEOSAM on TACC – A Cute & Friendly How-To 🌺

This guide provides instructions for running **GEOSAM** on **TACC (Lonestar 6)** using a clean, containerized setup. It is reproducible and suitable for users new to HPC environments.

Think of this as: **Mac → Container → TACC → Fast results** 🚀

---

## 🧭 Big-Picture Workflow

1. ✍️ Get accounts + tokens
2. 📦 Set up R & Python (the picky part)
3. 🐳 Containerize everything (so it behaves)
4. ☁️ Move to TACC (Lonestar 6)
5. ⚡ Run GEOSAM in parallel
6. 🗺️ Decide how to slice up Oʻahu

---

## 🔐 1. Accounts & Prerequisites

### You’ll Need
- 🐙 **GitHub** (to clone GEOSAM)
- 🖥️ **TACC account** with access to **Lonestar 6**
- 🤗 **Hugging Face account** (for model access)

### Hugging Face Token (Very Important ✨)

1. Go to **Hugging Face → Settings → Access Tokens**
2. Create a **Read** token
3. Copy it somewhere safe (you’ll export it later)

---

## 📚 2. Required Software Versions & R Packages

### 🧪 R Setup

GEOSAM is picky (but reasonable):

- **R ≥ 4.5.2**

### Installing R Packages (`sf`, `terra`, `geosam`)

1. Open R (or RStudio) inside your container or on TACC.
2. Install the packages step by step:

```r
# Install 'sf' for spatial data handling
install.packages("sf", repos = "https://cloud.r-project.org")

# Install 'terra' for raster data handling
install.packages("terra", repos = "https://cloud.r-project.org")

# Install 'geosam' from walkerke's r-universe
install.packages(
  "geosam",
  repos = c("https://walkerke.r-universe.dev", "https://cloud.r-project.org")
)
```

> 💡 Tip: `sf` and `terra` may require system libraries. Using a container avoids headaches.

---

## 🐍 3. Python Environment

GEOSAM uses Python behind the scenes for models.

Recommended setup:
- 🐍 **Python 3.10**
- Common dependencies:
  - `torch`
  - `transformers`
  - `huggingface_hub`
  - `numpy`, `pandas`

We’ll freeze *all* of this inside a container so nothing breaks later.

---

## 📦 4. Containerization (Apptainer-Friendly)

TACC uses **Apptainer** (formerly Singularity). Containers = peace of mind 😌

### Why Containers Are Your Friend

- ✅ Same environment everywhere
- ✅ No fighting with `sf` installs
- ✅ Works on Mac *and* Lonestar 6

### Base Image (R + Geospatial Goodies)

```Dockerfile
FROM rocker/geospatial:4.5.2
```

This already includes:
- R 4.5.2
- GDAL / GEOS / PROJ
- `sf` + `terra`

### Add Python

```Dockerfile
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3.10-venv \
    python3-pip
```

### Install Python Packages

```Dockerfile
RUN pip install torch transformers huggingface_hub pandas numpy
```

### Install GEOSAM & R Packages

```Dockerfile
RUN R -e "install.packages('sf', repos='https://cloud.r-project.org')"
RUN R -e "install.packages('terra', repos='https://cloud.r-project.org')"
RUN R -e "install.packages('geosam', repos=c('https://walkerke.r-universe.dev','https://cloud.r-project.org'))"
```

### Build & Convert ✨

```bash
docker build -t geosam-tacc .
apptainer build geosam.sif docker-daemon://geosam-tacc:latest
```

---

## ☁️ 5. Moving to TACC

Upload your container + data:

```bash
scp geosam.sif username@ls6.tacc.utexas.edu:/work/yourdir/
```

Suggested folder layout (clean = happy):

```
/work/yourdir/
├── geosam.sif
├── data/
│   ├── census_tracts.geojson
│   └── renewable_zones.geojson
├── scripts/
│   ├── run_geosam.R
│   └── run_geosam.py
```

---

## 🗺️ 6. How Do We Break Up Oʻahu?

### ⭐ Recommended: Census Tracts

Why they’re great:
- 🧍 Population-aware
- 📊 Census-friendly
- 🔁 Easy to reproduce

### 🌱 Optional Filters

You *can* limit analysis to:
- Renewable Energy Zones only
- Exclude prohibited areas (conservation, military, wetlands)

Do this *before* GEOSAM using `sf::st_intersection()`.

---

## ⚡ 7. Running on Lonestar 6

### Example SLURM Script

```bash
#!/bin/bash
#SBATCH -J geosam
#SBATCH -N 1
#SBATCH -n 48
#SBATCH -t 00:10:00
#SBATCH -A your_allocation

module load apptainer

export HF_TOKEN=your_huggingface_token

apptainer exec \
  --env HF_TOKEN=$HF_TOKEN \
  geosam.sif \
  Rscript scripts/run_geosam.R
```

⏱️ **Good news:** Oʻahu-scale jobs usually finish in **minutes**, not hours.

---

## 🧵 8. Parallel Processing Notes

- 🖥️ **Lonestar 6**: use lots of cores (`-n 48` or more)
- In R, use:
  - `future`
  - `parallel`
  - `terraOptions(cores = ...)`

### 🍎 On macOS

- Parallel processing works, but:
  - Fewer cores
  - Slower I/O
- Mac = testing 🧪, TACC = real runs 💪

---

## 🎀 9. Summary

- Containers make everything calm and reproducible
- Census tracts are the cleanest Oʻahu units
- Zoning filters = optional but defensible
- Lonestar 6 = fast, parallel, reliable
- This workflow plays nicely with teaching & research

---



💬 Let’s make HPC fun and cute! 🌈

