*==============================================================================*
*  02 — CLEANING AND VARIABLE CONSTRUCTION (2021 wave)
*  The 2015/2017/2019 waves are cleaned by analogous scripts (wave-specific
*  item codes), each producing a harmonized chfs<year>_clean.dta.
*  Paths ($raw, $work, $out) are defined in 00_run_all.do.
*==============================================================================*

use "$work/chfs2021_merged.dta", clear

* --- head demographics --------------------------------------------------------
gen age2 = age^2/100
gen byte male     = (a2003 == 1)
gen byte marriage = inlist(a2024, 2, 3, 4)
rename a2025b health                          // self-rated health, 1 (best) - 5 (worst)
rename a2012  degree                          // education level, 1-9
replace degree = 1 if degree < 1 | degree > 9 | missing(degree)   // invalid -> no schooling
gen byte party         = (a2015 == 1)
gen byte internet_user = (c8001ab_6_mc == 1)
rename f6704_2_mc trust                       // trust in strangers (lower = more trusting)

* --- housing ------------------------------------------------------------------
gen byte own_house   = (c2001 == 1)
gen byte multi_house = (c2002 > 1) & !missing(c2002)
rename c1015a house_val                       // market value of housing
replace house_val = 0 if missing(house_val)
* (the purchase cost of the primary residence, house_cost, is constructed from
*  the housing module in the same way and carried through scripts 02-03; the
*  item-by-item recoding is omitted here for brevity)

* --- insurance participation --------------------------------------------------
gen byte ins_pension    = (f1001a != 7777) if !missing(f1001a)
gen byte ins_medical    = (f2001a != 7788) if !missing(f2001a)
gen byte ins_unemploy   = (f3001 == 1)     if !missing(f3001)
gen byte ins_commercial = (f6001a_7788_mc != 1)
egen byte ins_any = rowmax(ins_pension ins_medical ins_unemploy ins_commercial)

* --- risk attitude and financial-literacy proxies -----------------------------
drop if h3104 == 6                                       // "never considered"
gen byte risk_lover    = (h3104 <= 2)     if inrange(h3104, 1, 5)
gen byte fin_attention = inrange(h3101, 1, 2) if inrange(h3101, 1, 5)
gen byte fin_educated  = inlist(h3116a, 1, 2)            // received financial education

* --- asset amounts: aggregate questionnaire items, recode missing to zero -----
capture confirm string variable k1101
if !_rc destring k1101, replace force
gen cash = k1101
replace cash = 0 if missing(cash)

gen  fixed = d2104                                                    // time deposits
egen bond  = rowtotal(d4103_1 d4103_2 d4103_3 d4103_7777), missing    // bonds
gen  bank  = d7110a                                                   // bank wealth-management products
gen  ifin  = d7106h                                                   // internet wealth-management products
egen fund  = rowtotal(d5107_1 d5107_2 d5107_3 d5107_4 d5107_5 d5107_6 d5107_7 d5107_7777), missing
egen stock = rowtotal(d3109 d3116), missing
gen  deriv = d6100a                                                   // derivatives
gen  forex = d8104_imp                                                // non-RMB assets
gen  gold  = d9103_imp                                                // precious metals

local assets fixed bond bank ifin fund stock deriv forex gold house_val
foreach a of local assets {
    replace `a' = 0 if missing(`a')
    gen byte hold_`a' = (`a' > 0)         // holding dummy from positive balance
}
rename hold_house_val hold_house

* --- portfolio shares and a Herfindahl-type diversification index -------------
egen total_port = rowtotal(fixed bond bank ifin fund stock deriv forex gold house_val)
label var total_port "Total portfolio value (financial assets + housing)"

local i = 0
foreach a of local assets {
    local ++i
    gen w`i' = cond(total_port > 0, `a'/total_port, 0)
}
gen w_bondtype   = w2 + w3 + w4               // bonds, bank & internet WMPs
gen w_equitytype = w6 + w7 + w8 + w9          // stock, derivatives, FX, gold
gen w_risky      = w2 + w3 + w5 + w6 + w7 + w8 + w9
gen byte hold_risky = (w_risky > 0)

gen div_index = 1                              // 1 - sum of squared shares
forvalues j = 1/10 {
    replace div_index = div_index - w`j'^2
}
replace div_index = . if total_port == 0
label var div_index "Portfolio diversification (1 - Herfindahl)"

* --- market participation -----------------------------------------------------
egen n_hold = rowtotal(hold_fixed hold_bond hold_bank hold_ifin hold_fund ///
                       hold_stock hold_deriv hold_forex hold_gold hold_house)
gen byte part_fin   = (n_hold > 0)
gen byte part_stock = (hold_stock == 1 | hold_deriv == 1 | hold_forex == 1 | hold_gold == 1)

* --- keep the harmonized variable set shared by all waves ---------------------
keep hhid year prov total_asset total_income total_debt total_consump rural   ///
     house_val size age age2 male marriage degree health trust party         ///
     internet_user own_house multi_house ins_* risk_lover fin_attention      ///
     fin_educated cash fixed bond bank ifin fund stock deriv forex gold      ///
     total_port w1-w10 w_bondtype w_equitytype w_risky hold_* n_hold         ///
     part_fin part_stock div_index marr_child unmarr_child nuclear lineal    ///
     single couple n_old65 n_old70 old65_ratio old70_ratio n_sibling
order hhid year
save "$work/chfs2021_clean.dta", replace
