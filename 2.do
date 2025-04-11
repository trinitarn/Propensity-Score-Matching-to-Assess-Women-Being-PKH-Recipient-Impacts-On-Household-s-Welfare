set more off
clear
cd "C:\Users\nitar\Documents\sekripsi\dua per tiga\psm\sample\trial 3 (final)"

* Load the dataset with decision-making variables
use "bk_ar1_5.dta", clear

gen adult_woman_5 = (ar09 >= 18 & ar07 == 3)

* Identify households with at least one adult woman
bysort hhid14_9 (adult_woman_5): replace adult_woman_5 = adult_woman_5[_N]

* Generate treatment variable (1 = no adult women, 0 = at least one adult woman)
gen TREAT_5 = (adult_woman_5 == 0)

save "bk_ar1_5.dta", replace

// .... ini perlu ga ya

//keep necessary variables
keep hhid14_9 TREAT_5
save "sample_5.dta", replace

// bikin yang 4

use "bk_ar1_4.dta", clear

gen adult_woman_4 = (ar09 >= 18 & ar07 == 3)

* Identify households with at least one adult woman
bysort hhid07_9 (adult_woman_4): replace adult_woman_4 = adult_woman_4[_N]

* Generate treatment variable (1 = no adult women, 0 = at least one adult woman)
gen TREAT_4 = (adult_woman_4 == 0)

save "bk_ar1_4.dta", replace
//

use "bk_ar1_5.dta", clear
rename hhid14_9 hhid07_9
duplicates report hhid07_9
duplicates drop hhid07_9, force
save "bk_ar1_5.dta", replace
//
use "bk_ar1_4.dta", clear
duplicates report hhid07_9
duplicates drop hhid07_9, force
save "bk_ar1_4.dta", replace

* Load the dataset containing TREAT_5
use "bk_ar1_5.dta", clear

* Keep only relevant variables
keep hhid07_9 TREAT_5

* Save as a temporary dataset
save "treat_data.dta", replace

* Load your PSM merged dataset
use "bk_ar1_4.dta", clear

* Merge with the TREAT_5 dataset
merge 1:1 hhid07_9 using "treat_data.dta"

* Keep only matched observations
keep if _merge == 3
drop _merge

* Save the updated merged dataset
save "sampel_psm_merged.dta", replace

* Generate treatment variable
gen TREAT = (TREAT_4 == 0 & TREAT_5 == 1)
tab TREAT