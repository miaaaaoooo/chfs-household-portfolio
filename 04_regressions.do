*==============================================================================*
*  04 — REGRESSION ANALYSIS: Tables 1-6
*  Paths ($raw, $work, $out) are defined in 00_run_all.do.
*==============================================================================*

use "$work/chfs_panel_2015_2021.dta", clear

* Household-specific housing price change:
* |current market value - purchase cost| / purchase cost, capped at 1.
capture confirm variable house_cost
if _rc {
    di as error "house_cost not found — construct it in the cleaning stage first"
    exit 111
}
gen double Hou_V = abs((house_val - house_cost)/house_cost) ///
    if house_cost > 0 & !missing(house_cost)
replace Hou_V = 1 if Hou_V > 1 & !missing(Hou_V)
label var Hou_V "Housing price change |Δp|/p0"

* --- analysis variables -------------------------------------------------------
clonevar RR  = w_risky
clonevar IfR = hold_risky
clonevar Age = age
clonevar Edu = degree
clonevar AR  = risk_lover
clonevar Mar = marriage
clonevar Sex = male
clonevar Inc = ln_income
clonevar Old = n_old65
gen byte urban = (rural == 0) if !missing(rural)
label var RR    "Risky asset share"
label var IfR   "Holds risky assets (=1)"
label var Age   "Age"
label var Edu   "Education (1-9)"
label var AR    "Risk lover (=1)"
label var Mar   "Married (=1)"
label var Sex   "Male (=1)"
label var Inc   "ln(household income)"
label var Old   "Members aged 65+"
label var urban "Urban hukou (=1)"
global X Age Edu AR Mar Sex Inc Old urban

* --- sample restrictions ------------------------------------------------------
keep if age >= 19 & !missing(age)
drop if missing(RR) | missing(Hou_V)
foreach v in $X {
    drop if missing(`v')
}
xtset hhid year, delta(2)                       // biennial household panel
count
di as result "Final sample N = " r(N)

* --- Table 1: descriptive statistics ------------------------------------------
estpost summarize RR Hou_V $X, detail
esttab using "$out/T1_descriptives.rtf", replace label noobs nonumber ///
    cells("count(fmt(%9.0fc)) mean(fmt(3)) sd(fmt(3)) min(fmt(3)) p50(fmt(3)) max(fmt(3))") ///
    title("Table 1. Descriptive statistics")

* --- Table 2: baseline household fixed-effects regression ---------------------
eststo clear
eststo main_fe: xtreg RR Hou_V $X i.year, fe vce(cluster hhid)
esttab main_fe using "$out/T2_main_FE.rtf", replace label ///
    b(%9.4f) t(%9.2f) star(* 0.10 ** 0.05 *** 0.01)      ///
    indicate("Year FE = *.year")                          ///
    stats(N r2_w, fmt(%9.0fc 3) labels("Observations" "Within R-sq.")) ///
    title("Table 2. Housing price changes and risky asset allocation (household FE)") ///
    addnotes("Household fixed effects absorbed; t statistics clustered at the household level.")

* --- Table 3: wave-by-wave Probit (participation) and Tobit (share) -----------
foreach w of numlist 2015 2017 2019 {
    eststo p`w': probit IfR Hou_V $X if year == `w', vce(robust)
    eststo t`w': tobit  RR  Hou_V $X if year == `w', ll(0) vce(robust)
}
esttab p2015 t2015 p2017 t2017 p2019 t2019 using "$out/T3_by_wave.rtf", ///
    replace label b(%9.4f) se(%9.4f) star(* 0.10 ** 0.05 *** 0.01)      ///
    mtitles("Probit 2015" "Tobit 2015" "Probit 2017" "Tobit 2017"       ///
            "Probit 2019" "Tobit 2019")                                 ///
    stats(N, fmt(%9.0fc) labels("Observations"))                        ///
    title("Table 3. Wave-by-wave estimates: participation (Probit) and share (Tobit)")

* --- Table 4: heterogeneity by age group --------------------------------------
gen byte agegrp = cond(Age <= 30, 1, cond(Age <= 50, 2, 3))
forvalues g = 1/3 {
    eststo age`g': xtreg RR Hou_V $X i.year if agegrp == `g', fe vce(cluster hhid)
}
esttab age1 age2 age3 using "$out/T4_age.rtf", replace label keep(Hou_V) ///
    b(%9.4f) t(%9.2f) star(* 0.10 ** 0.05 *** 0.01)                      ///
    mtitles("19-30" "31-50" ">50") stats(N, fmt(%9.0fc) labels("Observations")) ///
    title("Table 4. Heterogeneity by age group (household FE)")

* --- Table 5: heterogeneity by urban / rural hukou ----------------------------
eststo urb1: xtreg RR Hou_V $X i.year if urban == 1, fe vce(cluster hhid)
eststo urb0: xtreg RR Hou_V $X i.year if urban == 0, fe vce(cluster hhid)
esttab urb1 urb0 using "$out/T5_urban_rural.rtf", replace label keep(Hou_V) ///
    b(%9.4f) t(%9.2f) star(* 0.10 ** 0.05 *** 0.01)                         ///
    mtitles("Urban" "Rural") stats(N, fmt(%9.0fc) labels("Observations"))   ///
    title("Table 5. Heterogeneity by hukou status (household FE)")

* --- Table 6: robustness — participation margin with pooled Probit ------------
eststo rob: probit IfR Hou_V $X i.year, vce(cluster hhid)
esttab rob using "$out/T6_robust_probit.rtf", replace label ///
    b(%9.4f) t(%9.2f) star(* 0.10 ** 0.05 *** 0.01)         ///
    indicate("Year FE = *.year")                            ///
    stats(N, fmt(%9.0fc) labels("Observations"))            ///
    title("Table 6. Robustness: extensive margin (pooled Probit)")
