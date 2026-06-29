use "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015\com_2015chfs2015_hh.dta"  ,clear
keep hhid year prov prov_ Div_index hhead total_asset total_income total_debt total_consump  house_asset size age age2 marriage gender degree health rural business Endowment_insurance Medical_Insurance Unemployment_Insurance Commercial_Insurance Insurance Financial_practitioners hold1 fixed hold2 bond hold3 bank hold4 internet hold5 fund hold6 stock hold7 derivative hold8 foreign hold9 gold Financial_assets hold10 w1 w2 w3 w4 w5 w6 w7 w8 w9 w10 w债券类 w股票类  information_attention Extreme_venture_capital Extremely_high_risk Extremely_low_risk Creditcard information_technology Risk_appetite w核心资产占比 w核心资产虚拟  w风险资产占比 w风险资产虚拟 sf mf nf tf marrison nonmarrison inter edu_dummy parents_edu encon  political_sta trust housing_more housing nonmarri hold0 sister gift_pay  gift_income old1 old2 family_old1_count family_old2_count old1_ratio old2_ratio
label variable marrison "是否已婚子女"
label variable nonmarrison "是否未婚子女"
label variable nf "是否核心家庭,包含未婚子女与配偶"
label variable tf "是否直系家庭 包含已婚子女与配偶"
label variable sf "是否独居家庭，单人家庭"
label variable mf "是否夫妻家庭，家庭只有两人且是配偶"
label variable marriage "是否结婚，1是0否"
label variable gender "性别，1男0女"
label variable w核心资产占比 "家庭金融资产占比：现金和储蓄存款、社保账户余额、债券、债权类基金、股票、除债权类基金以外的基金、理财、非人民币资产、衍生品、黄金"
label variable hold0 "持有现金金额"
save "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2015_keep",replace
use "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2017\com_chfs2017年hh.dta" ,clear
keep hhid year prov prov_ Div_index hhead total_asset total_income total_debt total_consump  house_asset size age age2 marriage gender degree health rural business Endowment_insurance Medical_Insurance Unemployment_Insurance Commercial_Insurance Insurance Financial_practitioners hold1 fixed hold2 bond hold3 bank hold4 internet hold5 fund hold6 stock hold7 derivative hold8 foreign hold9 gold Financial_assets hold10 w1 w2 w3 w4 w5 w6 w7 w8 w9 w10 w债券类 w股票类  information_attention Extreme_venture_capital Extremely_high_risk Extremely_low_risk Creditcard information_technology Risk_appetite w核心资产占比 w核心资产虚拟  w风险资产占比 w风险资产虚拟 sf mf nf tf marrison nonmarrison inter edu_dummy parents_edu encon  political_sta trust housing_more housing  nonmarri hold0 sister gift_pay  gift_income old1 old2 family_old1_count family_old2_count old1_ratio old2_ratio
label variable marrison "是否已婚子女"
label variable nonmarrison "是否未婚子女"
label variable nf "是否核心家庭,包含未婚子女与配偶"
label variable tf "是否直系家庭 包含已婚子女与配偶"
label variable sf "是否独居家庭，单人家庭"
label variable mf "是否夫妻家庭，家庭只有两人且是配偶"
label variable marriage "是否结婚，1是0否"
label variable gender "性别，1男0女"
label variable w核心资产占比 "家庭金融资产占比：现金和储蓄存款、社保账户余额、债券、债权类基金、股票、除债权类基金以外的基金、理财、非人民币资产、衍生品、黄金"
label variable hold0 "持有现金金额"
save "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2017_keep",replace
use "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2019\com_chfs2019hh.dta" ,clear
keep hhid year prov prov_ Div_index hhead total_asset total_income total_debt total_consump  house_asset size age age2 marriage gender degree health rural business Endowment_insurance Medical_Insurance Unemployment_Insurance Commercial_Insurance Insurance Financial_practitioners hold1 fixed hold2 bond hold3 bank hold4 internet hold5 fund hold6 stock hold7 derivative hold8 foreign hold9 gold Financial_assets hold10 w1 w2 w3 w4 w5 w6 w7 w8 w9 w10 w债券类 w股票类  information_attention Extreme_venture_capital Extremely_high_risk Extremely_low_risk Creditcard information_technology Risk_appetite w核心资产占比 w核心资产虚拟  w风险资产占比 w风险资产虚拟 sf mf nf tf marrison nonmarrison inter edu_dummy parents_edu encon  political_sta trust housing_more housing  nonmarri hold0 sister gift_pay  gift_income old1 old2 family_old1_count family_old2_count old1_ratio old2_ratio
label variable marrison "是否已婚子女"
label variable nonmarrison "是否未婚子女"
label variable nf "是否核心家庭,包含未婚子女与配偶"
label variable tf "是否直系家庭 包含已婚子女与配偶"
label variable sf "是否独居家庭，单人家庭"
label variable mf "是否夫妻家庭，家庭只有两人且是配偶"
label variable marriage "是否结婚，1是0否"
label variable gender "性别，1男0女"
label variable w核心资产占比 "家庭金融资产占比：现金和储蓄存款、社保账户余额、债券、债权类基金、股票、除债权类基金以外的基金、理财、非人民币资产、衍生品、黄金"
label variable hold0 "持有现金金额"
save "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2019_keep",replace
use "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2021\com_chfs2021hh.dta" ,clear
keep hhid year prov prov_ Div_index hhead total_asset total_income total_debt total_consump  house_asset size age age2 marriage gender degree health rural business Endowment_insurance Medical_Insurance Unemployment_Insurance Commercial_Insurance Insurance Financial_practitioners hold1 fixed hold2 bond hold3 bank hold4 internet hold5 fund hold6 stock hold7 derivative hold8 foreign hold9 gold Financial_assets hold10 w1 w2 w3 w4 w5 w6 w7 w8 w9 w10 w债券类 w股票类  information_attention Extreme_venture_capital Extremely_high_risk Extremely_low_risk Creditcard information_technology Risk_appetite w核心资产占比 w核心资产虚拟  w风险资产占比 w风险资产虚拟 sf mf nf tf marrison nonmarrison inter edu_dummy parents_edu encon  political_sta trust housing_more housing  nonmarri hold0 sister gift_pay  gift_income old1 old2 family_old1_count family_old2_count old1_ratio old2_ratio
label variable marrison "是否已婚子女"
label variable nonmarrison "是否未婚子女"
label variable nf "是否核心家庭,包含未婚子女与配偶"
label variable tf "是否直系家庭 包含已婚子女与配偶"
label variable sf "是否独居家庭，单人家庭"
label variable mf "是否夫妻家庭，家庭只有两人且是配偶"
label variable marriage "是否结婚，1是0否"
label variable gender "性别，1男0女"
label variable w核心资产占比 "家庭金融资产占比：现金和储蓄存款、社保账户余额、债券、债权类基金、股票、除债权类基金以外的基金、理财、非人民币资产、衍生品、黄金"
label variable hold0 "持有现金金额"
save "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2021_keep",replace
use "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2015_keep"
append using "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2017_keep"
append using "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2019_keep"
append using "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2021_keep"
save "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2015-2021_keep",replace
use "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2015-2021_keep" ,clear
replace total_asset=0 if total_asset==.
replace total_income=0 if total_income==.
replace total_debt=0 if total_debt==.
replace house_asset=0 if house_asset==.
gen ln_asset=ln(1+total_asset)
gen ln_income=ln(1+total_income)
gen ln_debt=ln(1+total_debt)
gen ln_house=ln(1+house_asset)
gen ln_consume=ln(1+total_consump)
label variable ln_asset "总资产取对数"
label variable ln_income "总收入取对数"
label variable ln_debt "总债务取对数"
label variable ln_house"房产取对数"
label variable ln_consume"总消费取对数"
sort total_asset
gen g_asset=group(3)
gen high_asset=0
replace high_asset=1 if g_asset==3
gen middle_asset=0
replace middle_asset=1 if g_asset==2
gen low_asset=0
replace low_asset=1 if g_asset==1
label variable high_asset "高资产组"
label variable middle_asset "中资产组"
label variable low_asset "低资产组"
save "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2015-2021_keep",replace
label variable hhid "家庭编码"
label variable year "年份"
label variable age "年龄"
label variable age2 "年龄平方除以100"
label variable marriage "婚姻状况已婚1未婚0"
label variable gender "性别男1女0"
label variable g_asset "资产分组"
save "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2015-2021_keep",replace
use "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2015-2021_keep"
clear
input str24 prov_ int code
"北京市"                11
"天津市"                12
"河北省"                13
"山西省"                14
"内蒙古自治区"          15
"辽宁省"                21
"吉林省"                22
"黑龙江省"              23
"上海市"                31
"江苏省"                32
"浙江省"                33
"安徽省"                34
"福建省"                35
"江西省"                36
"山东省"                37
"河南省"                41
"湖北省"                42
"湖南省"                43
"广东省"                44
"广西壮族自治区"        45
"海南省"                46
"重庆市"                50
"四川省"                51
"贵州省"                52
"云南省"                53
"西藏自治区"            54
"陕西省"                61
"甘肃省"                62
"青海省"                63
"宁夏回族自治区"        64
"新疆维吾尔自治区"      65
end
save "province_code.dta", replace
use "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2015-2021_keep", clear
decode prov_, gen(prov_name)
drop prov_
rename prov_name prov_
merge m:1 prov_ using "province_code.dta", keep(match master) nogen
gen east_temp1 = inlist(prov_, "北京市", "天津市", "河北省", "上海市", "江苏省")
gen east_temp2 = inlist(prov_, "浙江省", "福建省", "山东省", "广东省", "海南省")
gen east = east_temp1 | east_temp2
drop east_temp1 east_temp2
gen central = inlist(prov_, "山西省", "安徽省", "江西省", "河南省", ///
                    "湖北省", "湖南省")
gen west_temp1 = inlist(prov_, "内蒙古自治区", "广西壮族自治区", "重庆市", "四川省", "贵州省")
gen west_temp2 = inlist(prov_, "云南省", "西藏自治区", "陕西省", "甘肃省", "青海省")
gen west_temp3 = inlist(prov_, "宁夏回族自治区", "新疆维吾尔自治区")
gen west = west_temp1 | west_temp2 | west_temp3
drop west_temp1 west_temp2 west_temp3
gen northeast = inlist(prov_, "辽宁省", "吉林省", "黑龙江省")
label variable east "东部"
label variable central "中部"
label variable west "西部"
label variable northeast "东北部"
rename code prov_code
label variable prov_code "省份编码"
save "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2015-2021_keep",replace
egen hold总= rowtotal(hold1 hold2 hold3 hold4 hold5 hold6 hold7 hold8 hold9 hold10),missing
gen Participate_financial=1
replace Participate_financial=0 if hold总==0
replace Participate_financial=. if hold总==.
label variable Participate_financial "是否参与金融市场"
label variable hold总 "储蓄存款、社保账户余额、债券、债权类基金、股票、除债权类基金以外的基金、理财、非人民币资产、衍生品、黄金、房产是否持有"
egen hold股票类= rowtotal(hold6 hold7 hold8 hold9),missing
gen Participate_stock=1
replace Participate_stock=0 if hold股票类==0
label variable hold股票类 "股票类市场"
label variable Participate_stock "是否参与股票市场"
save "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2015-2021_keep",replace
foreach var of varlist hold2-hold10 {
    sum `var'
    gen std_`var' = (`var' - r(mean))/r(sd)
}
egen fin_index = rowtotal(std_hold2-std_hold10)
label var fin_index "标准化金融多样性指数"
xtile fin_pctile = fin_index
rename fin_pctile FC2
label var FC2 "金融素养测算方式2，采用标准化金融多样性指数，参考文献见李伟，农村经济。测算方法见do文件"
drop std_*
gen FC1 = information_attention
label var FC1 "金融素养测算方式1，采用标准化金融信息关注度，参考文献见李伟，农村经济。测算方法见do文件"
gen Sharprate=0.223790322581*w1+0.095896853*w股票类+0.140864448*w债券类+0.169055062*w5 if year==2015
replace Sharprate=0.200431034483*w1+0.069709711*w股票类+0.181185454*w债券类+0.147720523*w5 if year==2019
replace Sharprate=0.210544692737*w1+0.080217515*w股票类+0.119281481*w债券类+0.158331987*w5 if year==2017
replace Sharprate = 0.192577433628 *w1 + 0.080762613 *w股票类 +  0.198518099*w债券类 + 0.147541824 *w5 if year==2021
label variable Sharprate "夏普比率，测算方法见do文件"
order hhid year,first
save "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2015-2021_keep",replace
