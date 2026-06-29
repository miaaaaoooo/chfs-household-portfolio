use"C:\微观数据\CHFS数据库合集\CHFS2021\CHFS2021年调查数据-stata14版本\CHFS2021年调查数据-stata14版本\2021\2021hh.dta" ,clear
gen pay_inter =0
replace pay_inter = 1 if g1009a ==1
label var  pay_inter "使用移动支付"
gen retir = 0
replace retir =1 if a3131a ==3
label var  retir "是否退休"
egen gift_income = rowtotal(h1004a_1 h1004a_2), missing
label variable gift_income "礼物收入"
egen gift_pay = rowtotal(g2004a_1 g2004a_2), missing
label variable gift_pay "礼物支出"
gen housing=1 if c2001==1
replace housing=0 if housing!=1
label variable housing "拥有自有住房=1"
gen housing_more=1 if c2002>1
replace housing_more=0 if housing_more!=1
label variable housing_more "拥有2套或以上自有住房=1"
gen inter=1 if c8001ab_6_mc ==1
replace inter=0 if inter!=1
label variable inter "使用互联网=1"
rename f6704_2_mc trust
label variable trust "对不认识的人信任度/数越低越信任"
gen political_sta=1 if a2015==1
replace political_sta=0 if political_sta!=1
label variable political_sta "=1则为党员"
gen is_parent = (age > 28) & (a2024 == 2 | a2024 == 7)
gen parents_education = .
replace parents_education = a2012 if is_parent == 1
summarize parents_education, meanonly
local mean_education = r(mean)
gen edu_dummy = 0
replace edu_dummy = 1 if parents_education > `mean_education' &!missing(parents_education)
label variable age "受访者年龄"
label variable is_parent "是否为父母（28岁以上已婚）"
label variable parents_education "父母的受教育程度"
label variable edu_dummy "父母受教育程度是否超过均值的虚拟变量"
rename parents_education parents_edu
gen encon = 0
replace encon = 1 if h3116a == 1 | h3116a == 2
label variable encon "接受过金融知识教育"
gen age2=age^2/100
rename a2012 degree
replace degree = 1 if degree < 1 | degree > 9 | missing(degree)
label var degree "学历，错误值和缺失值已赋值为 1（没上过学）"
rename a2025b health
label variable health "健康程度1好-5不好"
gen marriage=0
replace marriage=1 if a2024==2
replace marriage=1 if a2024==3
replace marriage=1 if a2024==4
gen gender=1
replace gender=0 if a2003==2
rename c1015a house_asset
label variable house_asset "房屋资产总价值"
gen business=0
replace business=1 if b2000b==1
label variable business "从事工商业生产从事1不从事0"
gen Financial_practitioners=0
replace Financial_practitioners=1 if a3132f==9
label variable Financial_practitioners "家中有金融行业从业者"
encode prov, gen(prov_)
gen Endowment_insurance=1
replace Endowment_insurance=0 if f1001a==7777
label variable Endowment_insurance "养老保险参与情况参与1未参与0"
gen Medical_Insurance=1
replace Medical_Insurance=0 if  f2001a==7788
label variable Medical_Insurance "医疗保险参与情况参与1未参与0"
gen Unemployment_Insurance=f3001
replace Unemployment_Insurance=0 if f3001==2
label variable Unemployment_Insurance "失业保险参与情况参与1未参与0"
gen Commercial_Insurance=1
replace Commercial_Insurance=0 if f6001a_7788_mc==1
label variable Commercial_Insurance "商业保险参与情况参与1未参与0"
gen Insurance=0
replace Insurance=1 if Endowment_insurance==1|Medical_Insurance==1|Unemployment_Insurance==1|Commercial_Insurance==1
label variable Insurance "保险参与情况参与1未参与0"
gen Risk_appetite=0 if h3104==3|h3104==4|h3104==5
replace Risk_appetite=1 if h3104==1|h3104==2
label variable Risk_appetite "风险偏好"
drop if h3104==6
generate hold0 = k1101
destring hold0, replace force
replace hold0 = 0 if missing(hold0)
label variable hold0 "持有现金金额"
gen hold1=1
replace hold1=0 if d2104 <1
replace hold1 = 0 if missing(d2104)
label variable hold1 "是否持有定期存款"
gen fixed=d2104
replace fixed=0 if fixed==.
label variable fixed  "定期存款金额"
egen bond = rowtotal(d4103_7777 d4103_3 d4103_2 d4103_1),missing
label variable bond "债券金额"
gen hold2=1
replace hold2 =0 if missing(bond)
label variable hold2 "是否持有债券"
gen hold3=d7109
replace hold3=0 if hold3==2
replace hold3=1 if d7109==1
replace hold3=0 if d7109 == .d
label variable hold3 "是否持有金融理财产品"
gen bank=d7110a
label variable bank "金融理财产品总金额"
gen hold4=1
replace hold4 = 0 if d7106d == "6"
label variable hold4 "是否持有互联网理财产品"
gen internet=d7106h
replace internet=0 if internet==.
label variable internet "互联网理财产品金额"
egen fund = rowtotal(d5107_1 d5107_2 d5107_3 d5107_4 d5107_5 d5107_6 d5107_7 d5107_7777),missing
label variable fund "基金金额"
replace fund=0 if fund==.
gen hold5=0
replace hold5=1 if  fund >1
label variable hold5 "是否持有基金"
gen hold6=1
replace hold6=0 if d3101==.
replace hold6=0 if d3101==2
replace hold6=1 if d3113==1
label variable hold6 "是否持有股票"
egen stock= rowtotal(d3109 d3116),missing
replace stock=0 if stock==.
label variable stock "股票金额"
gen hold7=d7113_2_mc
label variable hold7 "是否持有衍生品"
gen derivative=d6100a
replace derivative=0 if derivative==.
label variable derivative "衍生品金额"
gen hold8=d7113_4_mc
label variable hold8 "是否持有非人民币资产"
gen foreign=d8104_imp
replace foreign=0 if foreign==.
label variable foreign "非人民币资产价值"
gen hold9=d7113_3_mc
label variable hold9 "是否持有贵金属"
gen gold=d9103_imp
replace gold=0 if gold==.
label variable gold "贵金属价值"
replace hous_asset=0 if hous_asset==.
gen hold10=1
replace hold10=0 if hous_asset==0
label variable hold10 "是否持有房产"
label  variable hous_asset "房产价值"
replace hold1=0 if hold1==.
replace hold2=0 if hold2==.
replace hold3=0 if hold3==.
replace hold4=0 if hold4==.
replace hold5=0 if hold5==.
replace hold6=0 if hold6==.
replace hold7=0 if hold7==.
replace hold8=0 if hold8==.
replace hold9=0 if hold9==.
replace hold10=0 if hold10==.
replace fixed=0 if fixed==.
replace bond=0 if bond==.
replace bank=0 if bank==.
replace internet=0 if internet==.
replace fund=0 if fund==.
replace stock=0 if stock==.
replace derivativ=0 if derivativ==.
replace foreign=0 if foreign==.
replace gold=0 if gold==.
egen Financial_assets= rowtotal(fixed bond bank internet fund stock derivative foreign gold hous_asset),missing
label variable Financial_assets "金融资产加总额"
gen w1=fixed/Financial_assets
replace w1=0 if w1==.
label variable w1  "定期存款占比"
gen w2=bond/Financial_assets
replace w2=0 if w2==.
label variable w2  "债券占比"
gen w3=bank/Financial_assets
replace w3=0 if w3==.
label variable w3  "银行理财产品占比"
gen w4=internet/Financial_assets
replace w4=0 if w4==.
label variable w4  "互联网理财产品占比"
gen w5=fund/Financial_assets
replace w5=0 if w5==.
label variable w5  "基金占比"
gen w6=stock/Financial_assets
replace w6=0 if w6==.
label variable w6  "股票占比"
gen w7=derivative/Financial_assets
replace w7=0 if w7==.
label variable w7  "衍生品占比"
gen w8=foreign/Financial_assets
replace w8=0 if w8==.
label variable w8  "非人民币资产占比"
gen w9=gold/Financial_assets
replace w9=0 if w9==.
label variable w9  "贵金属资产占比"
gen w10=hous_asset/Financial_assets
label variable w10  "房产占比"
gen w债券类=w2+w3+w4
label variable w债券类 "债券类加总占比"
gen w股票类=w6+w7+w8+w9
label variable w股票类 "股票类加总占比"
gen Div_index=.
replace Div_index=1-w1^2-w2^2-w3^2-w4^2-w5^2-w6^2-w7^2-w8^2-w9^2-w10^2 if w1~=0|w2~=0|w3~=0|w4~=0|w5~=0|w6~=0|w7~=0|w8~=0|w9~=0|w10~=0
label variable  Div_index "投资多样性"
gen information_attention=h3101
replace information_attention=1 if h3101==1|h3101==2
replace information_attention=0 if h3101==3|h3101==4|h3101==5
label variable information_attention "金融信息关注度"
gen Extreme_venture_capital=1 if w1==1|w股票类==1
replace Extreme_venture_capital=0 if w债券类==1|w5==1|Div_index >0
replace Extreme_venture_capital=. if Div_index
label variable Extreme_venture_capital "极端风险投资"
gen Extremely_high_risk=1 if w股票类==1
replace Extremely_high_risk=0 if Div_index~=. & w股票类~=1
label variable Extremely_high_risk "极端高风险投资"
gen Extremely_low_risk=1 if w1==1
replace Extremely_low_risk=0 if Div_index~=. & w1~=1
label variable Extremely_low_risk "极端低风险投资"
gen Creditcard=0
replace Creditcard=1  if e2002aa >0
replace Creditcard = 0 if  e2002aa == .d
label variable Creditcard "拥有信用卡"
gen information_technology=0
replace information_technology=1 if c8001ab_1_mc==1|c8001ab_6_mc==1
label variable information_technology "信息技术的使用"
gen w核心资产占比=w1+w2+w3+w5+w6+w7+w9+w8
gen w核心资产虚拟 = 0
replace w核心资产虚拟 = 1 if w核心资产占比 != 0
gen w风险资产占比 = w2+w3+w6+w5+w7+w8+w9
gen w风险资产虚拟 = 0
replace w风险资产虚拟 = 1 if w风险资产占比 != 0
save "C:\微观数据\CHFS数据库合集\CHFS2021\CHFS2021年调查数据-stata14版本\CHFS2021年调查数据-stata14版本\2021\com_chfs2021hh.dta",replace
use "C:\微观数据\CHFS数据库合集\CHFS2021\CHFS2021年调查数据-stata14版本\CHFS2021年调查数据-stata14版本\2021\com_chfs2021hh.dta" ,clear
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
use "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2021_keep" ,clear
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
save "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2021_keep",replace
label variable hhid "家庭编码"
label variable year "年份"
label variable age "年龄"
label variable age2 "年龄平方除以100"
label variable marriage "婚姻状况已婚1未婚0"
label variable gender "性别男1女0"
label variable g_asset "资产分组"
save "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2021_keep",replace
use "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2021_keep"
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
use "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2021_keep", clear
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
save "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2021_keep",replace
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
save "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2021_keep",replace
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
order hhid year,first
save "C:\微观数据\CHFS重新处理\26.2.24重新处理存放\2015-2021合并\chfs2021_keep",replace
