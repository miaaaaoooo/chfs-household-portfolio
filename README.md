# House-Price Changes and Household Risky-Asset Allocation (CHFS)

Replication package for my undergraduate honors thesis: **"The Impact of House-Price Changes on Household Risky Financial Asset Allocation under a Housing-Market Downturn."**

The thesis builds a household-year panel of **22,885 observations from three waves** of the China Household Finance Survey (CHFS) in Stata and estimates the effect of house-price changes on households' allocation to risky financial assets, using two-way (household × year) fixed effects with clustered standard errors, by-wave Probit (participation) and left-censored Tobit (share) specifications, plus heterogeneity, mechanism, and robustness analyses. This repository additionally **extends the pipeline to four waves (2015, 2017, 2019, 2021)** as an independent coding exercise; the results reported in the thesis are based on the three-wave panel.

## Pipeline (run `00_run_all.do`)

| File | What it does |
| --- | --- |
| `00_run_all.do` | Master script: sets paths and packages, runs 01–05 in order, writes `code_sample.log`. |
| `01_merge_raw_2021.do` | Merge the individual, master-individual, household, and master-household raw files; build household-structure, age-structure, and demographic variables. 2021 wave shown as the exemplar. |
| `02_clean_2021.do` | Clean the merged 2021 wave: asset holdings and portfolio shares, participation dummies, a Herfindahl-type diversification index, insurance, risk-attitude and financial-literacy proxies; save a harmonized wave file. |
| `03_build_panel.do` | Stack the four cleaned waves into a panel; log transformations, wealth terciles, province crosswalk and regional dummies, a standardized asset-diversity index, and an expected portfolio Sharpe ratio. |
| `04_regressions.do` | Construct the key regressor (house-price change rate); household-FE, wave-by-wave Probit/Tobit, heterogeneity (age, urban/rural), and robustness specifications; export Tables 1–6 via `esttab`. |
| `05_figures.do` | Publication-style figures (trends across waves, coefficient plot by age group, diversification densities). Run in the same session as `04` (uses its stored estimates). |

The 2015/2017/2019 waves are cleaned by scripts analogous to `01`–`02` with wave-specific item codes, each producing a harmonized `chfs<year>_clean.dta`.

A Python re-implementation of the core analyses (independent replication, including a left-censored Tobit MLE coded from scratch) is in `/python`.

## Requirements

Stata 16+; user-written packages `estout` and `coefplot` (installed automatically by `00_run_all.do`). Set the `$raw`, `$work`, and `$out` globals at the top of `00_run_all.do` to your local directories.

## Notes on the data

The CHFS microdata are subject to a data-use license and are **not** included in this repository — only the analysis code is provided. Point `$raw` to your own copy of the CHFS release files to run the pipeline. Raw CHFS province identifiers are Chinese strings; the crosswalk in `03_build_panel.do` maps them to standard province codes.

Author: Ruixin (Mia) Sun 
