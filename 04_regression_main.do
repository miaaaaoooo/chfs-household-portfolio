use "chfs2015-2021_keep.dta", clear
capture confirm variable house_cost
if _rc {
    capture rename house_cost_raw house_cost
}
gen double Hou_V = abs((house_asset - house_cost)/house_cost) if house_cost > 0 & !missing(house_cost)
replace Hou_V = 1 if Hou_V > 1 & !missing(Hou_V)
label var Hou_V "房价变动率=|(现市价-购房成本)/购房成本|"
rename w风险资产占比  RR
rename w风险资产虚拟  IfR
clonevar AR  = Risk_appetite
clonevar Edu = degree
clonevar Mar = marriage
clonevar Sex = gender
clonevar Inc = ln_income
clonevar Old = family_old1_count
gen byte urban = (rural == 0) if !missing(rural)
label var RR    "风险性金融资产比重"
label var IfR   "是否持有风险性金融资产"
label var AR    "风险偏好(高/略高=1)"
label var Edu   "受教育程度(1-9)"
label var Mar   "婚姻状况(已婚=1)"
label var Sex   "性别(男=1)"
label var Inc   "家庭总收入的对数"
label var Old   "家庭老年人总数"
label var urban "城市户口(=1)"
global X  Age Edu AR Mar Sex Inc Old urban
keep if age >= 19 & !missing(age)
drop if missing(RR) | missing(Hou_V)
foreach v in $X {
    drop if missing(`v')
}
capture confirm numeric variable year
gen wave = year
recode wave (2015=2016)(2017=2018)(2019=2020)(2021=2022), generate(wave_lbl)
label define wv 2016 "2016" 2018 "2018" 2020 "2020" 2022 "2022"
label values wave_lbl wv
xtset hhid wave_lbl
count
di as result "最终样本 N = " r(N) "  
estpost summarize RR Hou_V Age Edu AR Mar Sex Inc Old urban, detail
esttab using "T3_descriptives.rtf", replace ///
    cells("count mean(fmt(3)) sd(fmt(3)) min(fmt(3)) p50(fmt(3)) max(fmt(3))") ///
    noobs nonumber title("表3 主要变量的描述性统计")
pwcorr RR Hou_V, sig star(.05)
eststo clear
eststo T5: xtreg RR Hou_V $X i.wave_lbl, fe vce(cluster hhid)
esttab T5 using "T5_main_FE.rtf", replace booktabs label ///
    b(%9.4f) t(%9.2f) star(* 0.10 ** 0.05 *** 0.01) ///
    drop(*.wave_lbl) ///
    indicate("年份固定效应 = *.wave_lbl") ///
    stats(N, fmt(%9.0fc) labels("观测值")) ///
    title("表5 房价变动影响风险金融资产配置的回归结果(双向固定效应)") ///
    addnotes("个体固定由组内估计吸收；括号内为聚类到家庭的 t 值。")
eststo clear
foreach w in 2016 2018 2020 {
    eststo P`w': probit IfR Hou_V $X if wave_lbl == `w', vce(robust)
    eststo T`w': tobit  RR  Hou_V $X if wave_lbl == `w', ll(0) vce(robust)
}
esttab P2016 T2016 P2018 T2018 P2020 T2020 using "T6_by_wave.rtf", ///
    replace booktabs label b(%9.4f) se(%9.4f) star(* 0.10 ** 0.05 *** 0.01) ///
    mtitles("Probit16" "Tobit16" "Probit18" "Tobit18" "Probit20" "Tobit20") ///
    stats(N, fmt(%9.0fc) labels("观测值")) ///
    title("表6 分年度估计结果(Probit 参与 / Tobit 占比)")
gen byte agegrp = 1 if Age >= 19 & Age <= 30
replace  agegrp = 2 if Age >  30 & Age <= 50
replace  agegrp = 3 if Age >  50
eststo clear
forvalues g = 1/3 {
    eststo A`g': xtreg RR Hou_V $X i.wave_lbl if agegrp == `g', fe vce(cluster hhid)
}
esttab A1 A2 A3 using "T7_age.rtf", replace booktabs label ///
    b(%9.4f) t(%9.2f) star(* 0.10 ** 0.05 *** 0.01) keep(Hou_V) ///
    mtitles("19-30" "30-50" ">50") stats(N, fmt(%9.0fc) labels("观测值")) ///
    title("表7 异质性分析：年龄组(双向固定效应)")
eststo clear
eststo U1: xtreg RR Hou_V $X i.wave_lbl if urban == 1, fe vce(cluster hhid)
eststo U0: xtreg RR Hou_V $X i.wave_lbl if urban == 0, fe vce(cluster hhid)
esttab U1 U0 using "T8_urbanrural.rtf", replace booktabs label ///
    b(%9.4f) t(%9.2f) star(* 0.10 ** 0.05 *** 0.01) keep(Hou_V) ///
    mtitles("城市" "农村") stats(N, fmt(%9.0fc) labels("观测值")) ///
    title("表8 异质性分析：城乡(双向固定效应)")
capture confirm variable exp_return
if !_rc {
    eststo clear
    eststo M1: xtreg exp_return Hou_V $X i.wave_lbl, fe vce(cluster hhid)
    local Xnoar Age Edu Mar Sex Inc Old urban
    eststo M2: xtreg AR Hou_V `Xnoar' i.wave_lbl, fe vce(cluster hhid)
    esttab M1 M2 using "T9_mechanism.rtf", replace booktabs label ///
        b(%9.5f) t(%9.2f) star(* 0.10 ** 0.05 *** 0.01) keep(Hou_V) ///
        mtitles("预期收益率" "风险态度") stats(N, fmt(%9.0fc) labels("观测值")) ///
        title("表9 机制检验(双向固定效应)")
}
else {
    di as txt "[提示] 未找到 exp_return(预期金融资产收益率)变量，机制检验第1列已跳过。"
}
eststo clear
eststo R1: probit IfR Hou_V $X i.wave_lbl, vce(cluster hhid)
esttab R1 using "T11_robust_probit.rtf", replace booktabs label ///
    b(%9.4f) t(%9.2f) star(* 0.10 ** 0.05 *** 0.01) drop(*.wave_lbl) ///
    indicate("年份固定效应 = *.wave_lbl") ///
    stats(N, fmt(%9.0fc) labels("观测值")) ///
    title("表11 稳健性检验：替换被解释变量为参与(Probit)")
log close
di as result "完成"
exit
