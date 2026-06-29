use "C:\微观数据\CHFS数据库合集\CHFS2021\CHFS2021年调查数据-stata14版本\CHFS2021年调查数据-stata14版本\chfs2021_ind_pub_v0_20260131.dta" ,clear
merge 1:1 hhid  pline using"C:\微观数据\CHFS数据库合集\CHFS2021\CHFS2021年调查数据-stata14版本\CHFS2021年调查数据-stata14版本\chfs2021_master_ind_pub_v0_20260131.dta"
destring hhid pline ,replace
format hhid pline %14.2g
bys hhid: g size=_N
label variable size "家庭规模"
gen homeson = 0
replace homeson = 1 if a2001 == 6
gen marri = 0
replace  marri =1 if inlist(a2024, 2, 3, 4)
label variable marri "是否结婚1是0否"
gen marrison = homeson * marri
label variable marrison "是否已婚子女"
gen nonmarri=0
replace nonmarri = 0
replace nonmarri = 1 if !inlist(a2024, 2, 3, 4)
gen nonmarrison = homeson * nonmarri
label variable nonmarrison "是否未婚子女"
label variable homeson "是否子代"
label variable nonmarri "是否未婚"
gen nf=0 
label variable nf "是否核心家庭,包含未婚子女与配偶"
replace nf=1 if a2001== 2|nonmarrison ==1
gen tf=0
label variable tf "是否直系家庭 包含已婚子女与配偶"
replace tf=1 if a2001== 2|marrison==1|a2001== 3
gen sf=0
replace sf=1 if a2001== 1 & size == 1
label variable sf "是否独居家庭，单人家庭"
gen mf=0
replace mf=1 if a2001 == 2 & size == 2
label variable mf "是否夫妻家庭，家庭只有两人且是配偶"
sort hhid
gen temp = (a2001 == 10)
by hhid: egen sister = total(temp)
drop temp
label variable sister "户主兄弟姐妹的数量"
gen age = 2022 - a2005
gen old1 = (age > 65)
gen old2 = (age > 70)
bysort hhid: egen family_old1_count = sum(old1)
bysort hhid: egen family_old2_count = sum(old2)
bysort hhid: egen family_size = max(size)
label variable family_old1_count "65岁以上老年人口数"
label variable family_old2_count "70岁以上老年人口数"
gen old1_ratio = family_old1_count / family_size
gen old2_ratio = family_old2_count / family_size
label variable old1_ratio "65岁以上老年人口数占家庭人数比"
label variable old2_ratio "70岁以上老年人口数占家庭人数比"
keep if hhead==1
drop _merge
save "C:\微观数据\CHFS数据库合集\CHFS2021\CHFS2021年调查数据-stata14版本\CHFS2021年调查数据-stata14版本\2021\2021ind.dta",replace
use "C:\微观数据\CHFS数据库合集\CHFS2021\CHFS2021年调查数据-stata14版本\CHFS2021年调查数据-stata14版本\chfs2021_master_hh_pub_v0_20260131.dta" ,clear
destring hhid  ,replace
format hhid  %14.2g
save "C:\微观数据\CHFS数据库合集\CHFS2021\CHFS2021年调查数据-stata14版本\CHFS2021年调查数据-stata14版本\2021\2021master.dta",replace
 use "C:\微观数据\CHFS数据库合集\CHFS2021\CHFS2021年调查数据-stata14版本\CHFS2021年调查数据-stata14版本\chfs2021_hh_pub_v0_20260131.dta"
destring hhid  ,replace
format hhid  %14.2g
merge 1:1 hhid using "C:\微观数据\CHFS数据库合集\CHFS2021\CHFS2021年调查数据-stata14版本\CHFS2021年调查数据-stata14版本\2021\2021ind.dta"
keep if _merge==3
drop _merge
save "C:\微观数据\CHFS数据库合集\CHFS2021\CHFS2021年调查数据-stata14版本\CHFS2021年调查数据-stata14版本\2021\2021hh.dta",replace
merge 1:1 hhid using "C:\微观数据\CHFS数据库合集\CHFS2021\CHFS2021年调查数据-stata14版本\CHFS2021年调查数据-stata14版本\2021\2021master.dta"
keep if _merge==3
drop _merge
destring prov,replace
gen year =2021
save "C:\微观数据\CHFS数据库合集\CHFS2021\CHFS2021年调查数据-stata14版本\CHFS2021年调查数据-stata14版本\2021\2021hh.dta",replace
