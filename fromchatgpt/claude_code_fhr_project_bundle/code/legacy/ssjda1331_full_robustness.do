*******************************************************
* SSJDA 1331: welfare credit, public pawnshops, and
* low-income household finance in Kanagawa, 1961
* Comprehensive descriptive/robustness analysis
*******************************************************
clear all
set more off
version 18

use "1331(2).dta", clear

*-----------------------------
* 1. Outcomes and covariates
*-----------------------------
gen welfare_any = q04_2==1 | q04_3==1 | q04_4==1 | q04_7==1
gen pawn_hist   = q04_8==1
gen protected_hist = q04_1==1
gen both = welfare_any & pawn_hist
gen choice = 0 if !welfare_any & !pawn_hist
replace choice = 1 if welfare_any & !pawn_hist
replace choice = 2 if !welfare_any & pawn_hist
replace choice = 3 if welfare_any & pawn_hist
label define choice 0 "Neither" 1 "Welfare only" 2 "Pawn only" 3 "Both"
label values choice choice

* Alternative welfare-credit definitions
gen welfare_nonmedical = q04_2==1 | q04_3==1 | q04_4==1
gen welfare_rehab_med  = q04_3==1 | q04_7==1
gen welfare_allmeasures = q04_2==1 | q04_3==1 | q04_4==1 | q04_5==1 | q04_6==1 | q04_7==1

* Clean categorical nonresponse
replace q03 = . if q03==9
replace q07 = . if q07==99
replace q08 = . if q08==9

* Household head and household structure
gen head_age = q01_01_3 if q01_01_3<99
gen head_age2 = head_age^2
gen female_head = q01_01_2==2 if inlist(q01_01_2,1,2)
gen hh_size = q12_1 if q12_1<99
gen n_child13 = q12_2 if q12_2<99
gen n_workers = q12_4 if q12_4<99
gen n_unemployed = q12_6 if q12_6<99

* Low-income factors
foreach v of varlist q02_01-q02_11 q02_21-q02_25 {
    replace `v' = . if `v'==99
}
egen n_shocks = rowtotal(q02_01-q02_11 q02_21-q02_25)

* Assets: eight movable household goods
foreach v of varlist q26_1-q26_8 {
    gen c_`v' = `v' if inlist(`v',0,1)
}
egen asset_count8 = rowtotal(c_q26_1-c_q26_8)
egen asset_missing = rowmiss(c_q26_1-c_q26_8)
replace asset_count8=. if asset_missing>0

gen real_estate = q26_9 if inlist(q26_9,0,1)

* Current coping outcomes
gen credit_purchase = q10_1==1
gen pawn_current = q10_2==1
gen employer_borrow = q10_3==1
gen friends_borrow = q10_4==1
gen sell_assets = q10_5==1
gen withdraw_savings = q10_6==1
gen food_cut = q10_8==1
gen pawn_any_histcurrent = pawn_hist | pawn_current

* Housing stress
gen arrears = q19>0 & q19<88888 if q19<99999
gen poor_housing = inlist(q20,3,4,5) if inlist(q20,1,2,3,4,5)
gen renter = inlist(q15,2,3,4,5,6,7,8,9) if q15<99

* Purpose-specific indicators
gen mother_hh = q03==2
gen longterm_hh = q03==4
gen need_business = q30_2==1
gen need_school = q30_4==1
gen need_medical = q30_7==1
gen school_material_hardship = q28_6==1
gen education_cost_hardship = q28_7==1
gen medical_need = inrange(q22,1,6)
gen medical_debt = inlist(q22_5,1,2)
gen medical_unpaid = inlist(q22_4,1,2)
gen medical_loan_current = inlist(q22_8,1,2)

gen any_selfemp=0
forvalues j=1/6 {
    replace any_selfemp=1 if !inlist(q05_`j'_05code,980,990)
}

local shocks q02_01-q02_11 q02_21-q02_25
local controls i.city i.q03 i.q08 c.head_age c.head_age2 female_head ///
    hh_size n_workers n_unemployed protected_hist asset_count8

*-----------------------------
* 2. Main results
*-----------------------------
reg welfare_any i.q07 `shocks', vce(hc3)
est store welfare_pars
reg welfare_any i.q07 `shocks' `controls', vce(hc3)
est store welfare_full
reg pawn_hist i.q07 `shocks', vce(hc3)
est store pawn_pars
reg pawn_hist i.q07 `shocks' `controls', vce(hc3)
est store pawn_full

* Nonlinear links and average marginal effects
logit welfare_any i.q07 `shocks' `controls', vce(robust)
margins, dydx(*) post
est store welfare_logit_ame
probit welfare_any i.q07 `shocks' `controls', vce(robust)
margins, dydx(*) post
est store welfare_probit_ame
logit pawn_hist i.q07 `shocks' `controls', vce(robust)
margins, dydx(*) post
est store pawn_logit_ame
probit pawn_hist i.q07 `shocks' `controls', vce(robust)
margins, dydx(*) post
est store pawn_probit_ame

*-----------------------------
* 3. Alternative outcomes
*-----------------------------
foreach y in welfare_nonmedical welfare_rehab_med welfare_allmeasures q04_3 pawn_current pawn_any_histcurrent {
    reg `y' i.q07 `shocks' `controls', vce(hc3)
    est store alt_`y'
}

*-----------------------------
* 4. Sample restrictions
*-----------------------------
foreach y in welfare_any pawn_hist {
    reg `y' i.q07 `shocks' `controls' if protected_hist==0, vce(hc3)
    est store `y'_noprotect
    reg `y' i.q07 `shocks' `controls' if inrange(head_age,20,64), vce(hc3)
    est store `y'_workingage
    reg `y' i.q07 `shocks' `controls' if inlist(city,1,2,3), vce(hc3)
    est store `y'_largecity
    reg `y' i.q07 `shocks' `controls' if n_shocks<=2, vce(hc3)
    est store `y'_max2shock
    reg `y' i.q07 `shocks' `controls' if n_shocks==1, vce(hc3)
    est store `y'_oneshock
}

* Leave one city out
levelsof city, local(cities)
foreach y in welfare_any pawn_hist {
    foreach c of local cities {
        quietly reg `y' i.q07 `shocks' `controls' if city!=`c', vce(hc3)
        estimates store `y'_drop`c'
    }
}

*-----------------------------
* 5. Direct institution choice
*-----------------------------
preserve
keep if inlist(choice,1,2)
gen choose_welfare = choice==1
reg choose_welfare i.q07 `shocks' `controls', vce(hc3)
est store choice_lpm
logit choose_welfare i.q07 `shocks' `controls', vce(robust)
margins, dydx(*) post
est store choice_logit_ame
probit choose_welfare i.q07 `shocks' `controls', vce(robust)
margins, dydx(*) post
est store choice_probit_ame
restore

* Overlap/complementarity of historical use
reg pawn_hist welfare_any i.q07 `shocks' `controls', vce(hc3)
est store overlap_lpm
logit pawn_hist welfare_any i.q07 `shocks' `controls', vce(robust)
est store overlap_logit

*-----------------------------
* 6. Institution-specific targeting
*-----------------------------
foreach y in q04_2 q04_3 q04_4 q04_7 q04_8 {
    reg `y' i.q07 `shocks' `controls', vce(hc3)
    est store inst_`y'
}

* Purpose validation; q03 omitted where the relevant HH type is explicit
local purposecontrols i.q07 i.city i.q08 c.head_age c.head_age2 female_head ///
    hh_size n_workers n_unemployed protected_hist asset_count8 `shocks'
reg q04_2 mother_hh `purposecontrols', vce(hc3)
est store target_mother
reg q04_3 need_business any_selfemp `purposecontrols', vce(hc3)
est store target_rehab
reg q04_4 need_school school_material_hardship education_cost_hardship n_child13 ///
    `purposecontrols', vce(hc3)
est store target_school
reg q04_7 longterm_hh medical_need need_medical medical_debt medical_unpaid ///
    `purposecontrols', vce(hc3)
est store target_medical

*-----------------------------
* 7. Current coping / credit stacking
*-----------------------------
foreach y in credit_purchase pawn_current employer_borrow friends_borrow sell_assets withdraw_savings food_cut {
    reg `y' welfare_any pawn_hist i.q07 `shocks' `controls', vce(hc3)
    est store coping_`y'
}

* Historical-current consistency
reg pawn_current pawn_hist i.q07 `shocks' `controls', vce(hc3)
est store pawn_persistence
reg medical_loan_current q04_7 i.q07 `shocks' `controls' if medical_need==1, vce(hc3)
est store medical_persistence

*-----------------------------
* 8. Heterogeneity: exploratory only
*-----------------------------
gen income_group = 1 if inlist(q07,1,2)
replace income_group = 2 if inrange(q07,3,5)
replace income_group = 3 if inrange(q07,6,8)
label define incgrp 1 "Low" 2 "Middle" 3 "Upper"
label values income_group incgrp

reg welfare_any i.q07 `shocks' `controls' c.q02_05#i.income_group, vce(hc3)
testparm c.q02_05#i.income_group
reg pawn_hist i.q07 `shocks' `controls' c.q02_04#i.income_group, vce(hc3)
testparm c.q02_04#i.income_group

*******************************************************
* IMPORTANT: q04 records histories, without dates, amounts,
* approval/rejection, repayment, or default. Results are
* descriptive partial associations, not causal effects.
*******************************************************
