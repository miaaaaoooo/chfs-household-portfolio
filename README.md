# House-Price Changes and Household Risky-Asset Allocation (CHFS)

Code for my undergraduate honors thesis (School of Economics, Shandong University, 2024; graded *Excellent*):
**"The Impact of House-Price Changes on Household Risky Financial Asset Allocation under a Housing-Market Downturn."**

The analysis builds a four-wave household-year panel of ~22,885 observations from the raw
China Household Finance Survey (CHFS) files (2015, 2017, 2019, 2021; household and individual files)
and estimates the effect of house-price changes on households' allocation to risky financial assets.

## Pipeline (run in order)

| File | What it does |
|------|--------------|
| `01_clean.do` | Clean a single CHFS wave: build asset holdings and portfolio shares, demographics, insurance and financial-literacy proxies, and the dependent / mechanism variables. |
| `02_merge_within.do` | Within a wave, merge the individual, master-individual, household, and master-household files; build household-structure and elderly-count variables. |
| `03_merge_panel.do` | Stack the four cleaned waves into a panel; add region dummies, log variables, asset groups, and a Sharpe-ratio measure. |
| `04_regression_main.do` | Construct the key regressor (house-price change rate), set the panel, and run two-way fixed-effects, by-wave Probit / left-censored Tobit, heterogeneity (age, urban/rural), mechanism, and robustness specifications; export tables via `esttab`. |

A Python re-implementation (independent replication, including a left-censored Tobit MLE coded from scratch) is included in `/python`. <!-- 删掉这行，如果你没有传 Python 脚本 -->

## Methods
Two-way fixed-effects panel models · Probit · left-censored Tobit · heterogeneity and mechanism analysis · robustness checks.

## Notes on the data
The CHFS microdata are subject to a data-use license and are **not** included in this repository — only the analysis code is provided.
Local file paths in the scripts have been replaced with the placeholder `<DATA_DIR>`; point it to your own copy of the CHFS files to run the pipeline.

Author: Ruixin (Mia) Sun
