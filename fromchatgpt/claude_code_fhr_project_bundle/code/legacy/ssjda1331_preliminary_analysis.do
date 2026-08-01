*******************************************************
* SSJDA 1331 preliminary analysis
* Credit at the Edge of Poverty
*******************************************************
clear all
set more off

* Change the path if necessary.
use "1331(2).dta", clear

* Public welfare credit and pawnshops.
gen any_pub_loan = q04_2==1 | q04_3==1 | q04_4==1 | q04_7==1
label var any_pub_loan "Any welfare loan (maternal/rehabilitation/scholarship/medical)"
gen any_pub_finance = any_pub_loan==1 | q04_8==1
label var any_pub_finance "Any welfare loan or public pawnshop"

* Household shortfall coping.
egen n_coping = rowtotal(q10_1-q10_8)
gen any_coping = n_coping>0
gen any_borrow = q10_1==1 | q10_2==1 | q10_3==1 | q10_4==1
label var any_borrow "Any trade credit/pawning/employer/community borrowing"

* Head and household characteristics.
gen head_age = q01_01_3 if q01_01_3<99
gen female_head = q01_01_2==2 if inlist(q01_01_2,1,2)
gen workers = q12_4 if q12_4<9
gen unemployed = q12_6 if q12_6<9

* Asset index: current ownership of eight movable household assets.
foreach v of varlist q26_1-q26_8 {
    clonevar c_`v' = `v'
    replace c_`v' = . if c_`v'==9
}
egen asset_count = rowtotal(c_q26_1-c_q26_8), missing
label var asset_count "Number of movable household assets owned"

* Other indicators.
gen income_decline = q08==3 if q08<9
gen rent_arrears = q19>0 & q19<999 if !missing(q19)

* Replace non-response in the low-income-cause items.
foreach v of varlist q02_01-q02_11 q02_21-q02_25 {
    replace `v' = . if `v'==99
}

*******************************************************
* Table 1: prevalence
*******************************************************
tabstat q04_2 q04_3 q04_4 q04_7 q04_8 any_pub_loan any_pub_finance, stat(n mean)
tabstat q10_1-q10_8 any_coping any_borrow, stat(n mean)

*******************************************************
* Table 2: targeting and financial hierarchy
*******************************************************
tab q03 q04_2, row
tab q03 q04_3, row
tab q03 q04_4, row
tab q03 q04_7, row
tab q03 q04_8, row

tab q07 any_pub_loan, row
tab q07 q04_8, row
tab q04_1 any_pub_loan, row
tab q04_1 q04_8, row

*******************************************************
* Table 3: partial associations with public finance use
* These are descriptive LPMs, not causal estimates.
*******************************************************
local X i.city i.q03 i.q07 i.q08 c.head_age##c.head_age female_head ///
    q12_1 workers unemployed q04_1 asset_count ///
    q02_01-q02_11 q02_21-q02_25

reg any_pub_loan `X', vce(robust)
reg q04_2 `X', vce(robust)
reg q04_3 `X', vce(robust)
reg q04_4 `X', vce(robust)
reg q04_7 `X', vce(robust)
reg q04_8 `X', vce(robust)

*******************************************************
* Table 4: household shortfall coping
*******************************************************
local XC i.city i.q03 i.q07 i.q08 c.head_age##c.head_age female_head ///
    q12_1 workers unemployed q04_1 any_pub_loan q04_8 asset_count ///
    q02_01-q02_11 q02_21-q02_25

foreach y of varlist q10_1-q10_8 {
    reg `y' `XC', vce(robust)
}

*******************************************************
* Useful cross-tabs for the public pawnshop mechanism
*******************************************************
tab q04_8 q10_2, row
tab q04_8 q10_3, row
tab q04_8 q10_4, row
tab q04_8 rent_arrears, row

*******************************************************
* End
*******************************************************
