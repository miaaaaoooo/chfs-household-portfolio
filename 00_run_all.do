*==============================================================================*
*  CHFS HOUSEHOLD PORTFOLIO — MASTER SCRIPT
*  House-Price Changes and Household Risky-Asset Allocation (CHFS)
*  Author: Ruixin (Mia) Sun
*
*  Runs the full pipeline. Scripts 01-02 clean the 2021 wave (shown as the
*  exemplar; the 2015/2017/2019 waves are cleaned by analogous scripts with
*  wave-specific item codes, each producing chfs<year>_clean.dta).
*  Script 05 must run in the same session as 04 (it uses stored estimates).
*==============================================================================*

version 16
clear all
set more off
set scheme s1color
capture log close
log using "code_sample.log", replace text

* ---- project paths: adapt to the local environment --------------------------
global raw  "data/raw"          // original CHFS release files
global work "data/working"      // intermediate data sets
global out  "output"            // tables, figures, logs

* ---- user-written packages required below -----------------------------------
foreach pkg in estout coefplot {
    capture which `pkg'
    if _rc ssc install `pkg', replace
}

do "01_merge_raw_2021.do"       // merge raw files -> household demographics
do "02_clean_2021.do"           // cleaning & variable construction (2021 wave)
do "03_build_panel.do"          // stack waves -> 2015-2021 panel
do "04_regressions.do"          // Tables 1-6
do "05_figures.do"              // Figures 1-3 (needs 04's stored estimates)

log close
exit
