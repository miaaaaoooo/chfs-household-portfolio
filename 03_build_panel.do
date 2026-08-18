*==============================================================================*
*  03 — PANEL CONSTRUCTION: 2015-2021
*  Requires chfs2015_clean.dta ... chfs2021_clean.dta in $work.
*  Paths ($raw, $work, $out) are defined in 00_run_all.do.
*==============================================================================*

use "$work/chfs2015_clean.dta", clear
foreach y of numlist 2017 2019 2021 {
    append using "$work/chfs`y'_clean.dta"
}

* --- log transformations ------------------------------------------------------
foreach v of varlist total_asset total_income total_debt total_consump house_val {
    replace `v' = 0 if missing(`v')
    gen ln_`v' = ln(1 + `v')
}
rename (ln_total_asset ln_total_income ln_total_debt ln_total_consump ln_house_val) ///
       (ln_asset ln_income ln_debt ln_consume ln_house)

* --- wealth terciles ----------------------------------------------------------
xtile asset_grp = total_asset, nq(3)
label define grp3 1 "Low" 2 "Middle" 3 "High"
label values asset_grp grp3
label var asset_grp "Asset tercile"

* --- province crosswalk and regional dummies ----------------------------------
preserve
clear
input str24 prov_name int prov_code
"北京市"           11
"天津市"           12
"河北省"           13
"山西省"           14
"内蒙古自治区"     15
"辽宁省"           21
"吉林省"           22
"黑龙江省"         23
"上海市"           31
"江苏省"           32
"浙江省"           33
"安徽省"           34
"福建省"           35
"江西省"           36
"山东省"           37
"河南省"           41
"湖北省"           42
"湖南省"           43
"广东省"           44
"广西壮族自治区"   45
"海南省"           46
"重庆市"           50
"四川省"           51
"贵州省"           52
"云南省"           53
"西藏自治区"       54
"陕西省"           61
"甘肃省"           62
"青海省"           63
"宁夏回族自治区"   64
"新疆维吾尔自治区" 65
end
save "$work/province_code.dta", replace
restore

rename prov prov_name
merge m:1 prov_name using "$work/province_code.dta", keep(match master) nogen
gen byte east      = inlist(prov_code, 11, 12, 13, 31, 32, 33, 35, 37, 44, 46)
gen byte central   = inlist(prov_code, 14, 34, 36, 41, 42, 43)
gen byte west      = inlist(prov_code, 15, 45, 50, 51, 52, 53, 54, 61, 62, 63, 64, 65)
gen byte northeast = inlist(prov_code, 21, 22, 23)

* --- standardized asset-diversity index (financial-literacy proxy) ------------
local holds hold_bond hold_bank hold_ifin hold_fund hold_stock hold_deriv ///
            hold_forex hold_gold hold_house
foreach v of local holds {
    quietly summarize `v'
    gen z_`v' = (`v' - r(mean)) / r(sd)
}
egen fin_index = rowtotal(z_*)
drop z_*
label var fin_index "Standardized asset-diversity index"

* --- expected portfolio Sharpe ratio, using year-specific asset-class returns -
gen sharpe = .
replace sharpe = 0.2238*w1 + 0.0959*w_equitytype + 0.1409*w_bondtype + 0.1691*w5 if year == 2015
replace sharpe = 0.2105*w1 + 0.0802*w_equitytype + 0.1193*w_bondtype + 0.1583*w5 if year == 2017
replace sharpe = 0.2004*w1 + 0.0697*w_equitytype + 0.1812*w_bondtype + 0.1477*w5 if year == 2019
replace sharpe = 0.1926*w1 + 0.0808*w_equitytype + 0.1985*w_bondtype + 0.1475*w5 if year == 2021
label var sharpe "Expected portfolio Sharpe ratio"

order hhid year
save "$work/chfs_panel_2015_2021.dta", replace
