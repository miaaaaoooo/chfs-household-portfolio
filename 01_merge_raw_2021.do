*==============================================================================*
*  01 — MERGE RAW FILES: individual roster -> household-level demographics
*  2021 wave shown as the exemplar; other waves use analogous scripts.
*  Paths ($raw, $work, $out) are defined in 00_run_all.do.
*==============================================================================*

use "$raw/chfs2021_ind.dta", clear
merge 1:1 hhid pline using "$raw/chfs2021_master_ind.dta", keep(match) nogen
destring hhid pline, replace

bysort hhid: gen size = _N
label var size "Household size"

* --- relationship to the household head and marital status -------------------
gen byte child   = (a2001 == 6)                     // child of the head
gen byte married = inlist(a2024, 2, 3, 4)           // married (incl. remarried)
gen byte marr_child   = child * married
gen byte unmarr_child = child * (1 - married) if !missing(a2024)

* --- family-type flags: flagged on individual rows, then aggregated to the
* --- household level (max within hhid) so the information survives the
* --- restriction to one record per household below ----------------------------
gen byte nuclear = (a2001 == 2) | (unmarr_child == 1)   // spouse or unmarried child present
gen byte lineal  = inlist(a2001, 2, 3) | (marr_child == 1)
gen byte couple  = (a2001 == 2) & (size == 2)
gen byte single  = (a2001 == 1) & (size == 1)
foreach v in marr_child unmarr_child nuclear lineal couple {
    bysort hhid: egen `v'_hh = max(`v')
    drop `v'
    rename `v'_hh `v'
}

* --- age structure of the household ------------------------------------------
gen age = 2021 - a2005                              // survey year minus birth year
gen byte old65 = (age > 65) & !missing(age)
gen byte old70 = (age > 70) & !missing(age)
bysort hhid: egen n_old65 = total(old65)
bysort hhid: egen n_old70 = total(old70)
gen old65_ratio = n_old65 / size
gen old70_ratio = n_old70 / size
bysort hhid: egen n_sibling = total(a2001 == 10)    // head's co-resident siblings

keep if hhead == 1                                  // one record per household
save "$work/chfs2021_ind_clean.dta", replace

* --- attach the household questionnaire and the summary (master) file --------
use "$raw/chfs2021_hh.dta", clear
destring hhid, replace
merge 1:1 hhid using "$work/chfs2021_ind_clean.dta", keep(match) nogen
merge 1:1 hhid using "$raw/chfs2021_master_hh.dta",  keep(match) nogen
gen year = 2021
save "$work/chfs2021_merged.dta", replace
