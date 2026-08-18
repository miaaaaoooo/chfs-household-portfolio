*==============================================================================*
*  05 — FIGURES
*  Run in the same session as 04_regressions.do: Figure 2 uses the stored
*  estimates age1-age3. Paths ($raw, $work, $out) are defined in 00_run_all.do.
*==============================================================================*

* --- Figure 1: participation and average risky share across waves -------------
preserve
collapse (mean) IfR RR, by(year)
twoway (connected IfR year, msymbol(O))                          ///
       (connected RR  year, msymbol(T) yaxis(2)),                ///
    xlabel(2015(2)2021) xtitle("Survey wave")                    ///
    ytitle("Participation rate") ytitle("Mean risky share", axis(2)) ///
    legend(order(1 "Risky-market participation" 2 "Mean risky share")) ///
    title("Risky-asset holdings across CHFS waves")
graph export "$out/fig1_trends.png", replace width(2400)
restore

* --- Figure 2: effect of housing price changes by age group -------------------
coefplot (age1, label("19-30")) (age2, label("31-50")) (age3, label(">50")), ///
    keep(Hou_V) vertical yline(0, lpattern(dash))                            ///
    ytitle("Coefficient on housing price change")                            ///
    title("Heterogeneous effects by age group")                              ///
    note("Household-FE estimates; 95% confidence intervals, clustered by household.")
graph export "$out/fig2_age_coef.png", replace width(2400)

* --- Figure 3: portfolio diversification by hukou status ----------------------
twoway (kdensity div_index if urban == 1) (kdensity div_index if urban == 0), ///
    legend(order(1 "Urban" 2 "Rural"))                                        ///
    xtitle("Diversification index (1 - Herfindahl)") ytitle("Density")        ///
    title("Distribution of portfolio diversification")
graph export "$out/fig3_divindex.png", replace width(2400)
