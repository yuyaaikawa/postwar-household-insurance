*******************************************************
* SSJDA 1331: welfare credit and public pawnshops
* Descriptive LPMs with heteroskedasticity-robust SEs
*******************************************************
clear all
set more off

use "1331(2).dta", clear

* Outcomes
gen any_welfare_loan = q04_2==1 | q04_3==1 | q04_4==1 | q04_7==1
label var any_welfare_loan "Any welfare loan"
label var q04_8 "Public pawnshop use"

* Clean categorical nonresponse
replace q03 = . if q03==9
replace q07 = . if q07==99
replace q08 = . if q08==9

* Household-head and household characteristics
gen head_age = q01_01_3 if q01_01_3<99
gen head_age2 = head_age^2
gen female_head = q01_01_2==2 if inlist(q01_01_2,1,2)
gen hh_size = q12_1
gen workers = q12_4 if q12_4<99
gen unemployed = q12_6 if q12_6<99
gen public_assist = q04_1==1

* Low-income factors: 99 = nonresponse
foreach v of varlist q02_01-q02_11 q02_21-q02_25 {
    replace `v' = . if `v'==99
}

* Asset count, complete information on eight movable assets
foreach v of varlist q26_1-q26_8 {
    gen c_`v' = `v' if inlist(`v',0,1)
}
egen asset_count = rowtotal(c_q26_1-c_q26_8)
egen n_asset_missing = rowmiss(c_q26_1-c_q26_8)
replace asset_count = . if n_asset_missing>0
label var asset_count "Number of household assets"

local shocks q02_01-q02_11 q02_21-q02_25
local controls i.city i.q03 i.q08 c.head_age c.head_age2 female_head ///
    hh_size workers unemployed public_assist asset_count

* Main table: parsimonious and full specifications
reg any_welfare_loan i.q07 `shocks', vce(robust)
estimates store loan1
reg any_welfare_loan i.q07 `shocks' `controls', vce(robust)
estimates store loan2
reg q04_8 i.q07 `shocks', vce(robust)
estimates store pawn1
reg q04_8 i.q07 `shocks' `controls', vce(robust)
estimates store pawn2

* Adjusted predictions by household-income bracket
margins q07, post
estimates store margins_loan
estimates restore pawn2
margins q07

* Institution-specific regressions
foreach y in q04_2 q04_3 q04_4 q04_7 q04_8 {
    reg `y' i.q07 `shocks' `controls', vce(robust)
    estimates store m_`y'
}

* Optional table export (requires estout)
* ssc install estout, replace
* esttab loan1 loan2 pawn1 pawn2 using "table_main.rtf", replace ///
*     b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
*     keep(q02_01 q02_04 q02_05 q02_07 q02_10 q02_22 q02_24 q02_25 ///
*          public_assist asset_count) ///
*     stats(N r2, fmt(0 3) labels("Observations" "R-squared")) ///
*     mtitles("Welfare loan" "Welfare loan" "Public pawnshop" "Public pawnshop")

*******************************************************
* Interpretation: descriptive partial associations only.
* q04 variables record a history of use; timing and loan amounts are unavailable.
*******************************************************
