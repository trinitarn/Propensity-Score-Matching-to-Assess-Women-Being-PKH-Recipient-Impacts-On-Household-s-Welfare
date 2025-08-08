set more off
clear
cd "C:\Users\nitar\Documents\sekripsi\dua per tiga\compiled do file SO FAR\trial 2"

use "b1_ksr1_4.dta", clear

* Keep only relevant variables
keep hhid07 ksr17

keep if ksr17 == 1
save "b1_ksr1_4_pkh.dta", replace

//
use "b1_ksr1_4_pkh.dta", clear
duplicates report hhid07
duplicates drop hhid07, force
save "b1_ksr1_clean.dta", replace
//
use "pca_index.dta", clear
duplicates report hhid07
duplicates drop hhid07, force
save "pca_index_clean.dta", replace

* Merge with PCA index dataset
merge 1:1 hhid07 using "pca_index_clean.dta"

* Keep only matched households
keep if _merge == 3
drop _merge

* Save the final merged dataset
save "pca_merged.dta", replace


* Plot histogram
histogram pca_rescaled, density normal title("Density Plot of Scaled PCA Index (PKH Recipients)") color(blue)

// bikin sampel //

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

* Generate treatment variable
gen TREAT = (TREAT_4 == 0 & TREAT_5 == 1)
tab TREAT

* Save the updated merged dataset
save "sampel_psm_merged.dta", replace

// bikin excel yg merge semuanya //

use "sampel_psm_merged.dta", clear
keep TREAT hhid07
save "sampel_psm_pkh.dta", replace

///////////////////////////// skrg lg disini belom dimasukin pkhnya rupanya bejir

* education

use hhid07 ar17 using "bk_ar1_4.dta", clear
duplicates drop hhid07, force
save temp_ar17.dta, replace
use "sampel_psm_pkh.dta", clear
merge 1:1 hhid07 using temp_ar17.dta

tab _merge
drop _merge
save "sampel_psm_pkh.dta", replace

* age hh members

use hhid07 ar09 using "bk_ar1_4.dta", clear
duplicates drop hhid07, force
save temp_ar09.dta, replace
use "sampel_psm_pkh.dta", clear
merge 1:1 hhid07 using temp_ar09.dta

tab _merge
drop _merge
save "sampel_psm_pkh.dta", replace

* location

use hhid07 sc010099 using "htrack_4.dta", clear
duplicates drop hhid07, force
save temp_loc.dta, replace
use "sampel_psm_pkh.dta", clear
merge 1:1 hhid07 using temp_loc.dta

tab _merge
drop _merge
save "sampel_psm_pkh.dta", replace

* hh members

use hhid07 hhsize using "bk_ar0_4.dta", clear
duplicates drop hhid07, force
save temp_hhsize.dta, replace
use "sampel_psm_pkh.dta", clear
merge 1:1 hhid07 using temp_hhsize.dta

tab _merge
drop _merge
save "sampel_psm_pkh.dta", replace

* marriage status

use hhid07 ar13 using "bk_ar1_4.dta", clear
duplicates drop hhid07, force
save temp_ar13.dta, replace
use "sampel_psm_pkh.dta", clear
merge 1:1 hhid07 using temp_ar13.dta

tab _merge
drop _merge
save "sampel_psm_pkh.dta", replace

* housing status

use hhid07 kr03 using "b2_kr_4.dta", clear
duplicates drop hhid07, force
save temp_kr03.dta, replace
use "sampel_psm_pkh.dta", clear
merge 1:1 hhid07 using temp_kr03.dta

tab _merge
drop _merge
save "sampel_psm_pkh.dta", replace

* employment status

use hhid07 tk01 using "b3a_tk1_4.dta", clear
duplicates drop hhid07, force
save temp_tk01.dta, replace
use "sampel_psm_pkh.dta", clear
merge 1:1 hhid07 using temp_tk01.dta

tab _merge
drop _merge
save "sampel_psm_pkh.dta", replace

* expenditure
use "b1_ks1_4.dta", clear

* Step 2: Summarize (total) ks02 by hhid07
collapse (sum) ks02, by(hhid07)
save "b1_ks1_4.dta", replace

* merge to the main dataset
use hhid07 ks02 using "b1_ks1_4.dta", clear
duplicates drop hhid07, force
save temp_ks02.dta, replace
use "sampel_psm_pkh.dta", clear
merge 1:1 hhid07 using temp_ks02.dta

tab _merge
drop _merge
save "sampel_psm_pkh.dta", replace

// buat liat aja sampelnya masih 63 ga

use "sampel_psm_pkh.dta", clear
tab TREAT

// belom masuk pkh bejir

//use b1_ksr1_4.dta, clear
//rename ksr17 ksr17_1
//rename hhid07 hhid14
//merge 1:1 hhid14 using b1_ksr1_5.dta
//rename ksr17 ksr17_2
//gen pkh = (ksr17_1 == 1 & ksr17_2 == 1)
//tab pkh

//gen TREAT_PKH = (TREAT == 1 & pkh == 1)
//save "sampel_psm_PKH.dta", clear

// HMMM coba ke new dataset deh

use hhid07 ksr17 using b1_ksr1_4.dta, clear
rename ksr17 ksr17_4
rename hhid07 hhid14
tempfile book4
save `book4'

use hhid14 ksr17 using b1_ksr1_5.dta, clear
rename ksr17 ksr17_5

merge m:m hhid14 using `book4'

* WARNING: m:m merges can be risky. Check for duplicates:
duplicates report hhid14

gen pkh = (ksr17_4 == 1 & ksr17_5 == 1)
tab pkh
drop if pkh == 0
rename hhid14 hhid07
save merged_ksr17.dta, replace

use sampel_psm_PKH.dta, clear 
cap drop _merge
save sampel_psm_PKH.dta, replace

use merged_ksr17.dta, clear
cap drop _merge
duplicates report hhid07
duplicates drop hhid07, force
save merged_ksr17.dta, replace

use sampel_psm_PKH, clear
duplicates report hhid07
duplicates drop hhid07, force

merge 1:1 hhid07 using merged_ksr17.dta

* Propensity score matching using psmatch2 package

* Install psmatch2 package
ssc install psmatch2

use sampel_psm_PKH.dta, clear

* Propensity score matching common support
psmatch2 TREAT ar17* ar09* sc010099* hhsize* ar13* kr03* tk01* ks02*, out(ks02) common 

* Nearest neighbor matching - neighbor(number of neighbors
psmatch2 TREAT ar17* ar09* sc010099* hhsize* ar13* kr03* tk01* ks02*, out(ks02) common neighbor(1)

* Radius matching - caliper(distance)
psmatch2 TREAT ar17* ar09* sc010099* hhsize* ar13* kr03* tk01* ks02*, out(ks02) common radius caliper(0.1)

*Kernel Matching
psmatch2 TREAT ar17* ar09* sc010099* hhsize* ar13* kr03* tk01* ks02*, out(ks02) common kernel

*Logit
psmatch2 TREAT ar17* ar09* sc010099* hhsize* ar13* kr03* tk01* ks02*, out(ks02) logit

*Ini yang paling bagus logit deh... mksdnya apa ya? terus yang signifikan cuma yg matching si hhsizenya

* Propensity score matching common support
psmatch2 TREAT ar17* sc010099* ar13* hhsize*, out(ks02) common 

*var matching, pseudo r2, sample
*hhsize aja 0.0591, 23
*hhsize ar17 0.0634, 21
*hhsize ar17 (ar09) 0.0645, 21 
*hhsize ar17 sc010099 0.0700, 21
*hhsize  ar17 sc010099 ar13 0.0773, 21
*hhsize  ar17 sc010099 ar13 (kr03), 0.0733, 21
*hhsize  ar17 sc010099 ar13 (tk01), 0.0733, 20

*sekarang cari different matching strategies

* Propensity score matching common support
psmatch2 TREAT ar17* sc010099* ar13* hhsize*, out(ks02) common 

psmatch2 TREAT ar17* sc010099* ar13* hhsize*, out(ks02) common neighbor(1)

psmatch2 TREAT ar17* sc010099* ar13* hhsize*, out(ks02) common radius caliper(0.1)

psmatch2 TREAT ar17* sc010099* ar13* hhsize*, out(ks02) common kernel

psmatch2 TREAT ar17* sc010099* ar13* hhsize*, out(ks02) logit

*the best one is logit sih.... ini maksudnya apa ya. dari 0.0773 jadi 0.0802

gen matched = _weight > 0
keep if matched

save matched_sample.dta, replace

// buat ngecek sampelnya udah bener belum 21 tapi kok tiba tiba 58 bejir

use matched_sample.dta, clear
tab _treated, nolabel
gen treated = _treated
tab treated
gen control = (treated == 0)
tab control

save ready_DID.dta, replace

// ini buat bikin matched nya ke sampel ready did

* rename hhid dulu deh bejir
use b1_ksr1_5.dta, clear
rename hhid hhid07
save "b1_ksr1", replace

use b1_ks1_5.dta, clear
rename hhid14_9 hhid07
save "b1_ks1", replace

*PKH ini udah dibikin ga sih

//use ready_DID.dta, clear

//use hhid07 ksr17 using "b1_ksr1.dta", clear
//duplicates drop hhid07, force
//save temp_ksr17.dta, replace
//use "ready_DID", clear
//merge 1:1 hhid07 using temp_ksr17.dta

//tab _merge
//drop _merge
//save "ready_DID", replace

*KS02 consumption wave 5

use ready_DID.dta, clear

use hhid07 ks02 using "b1_ks1.dta", clear
duplicates drop hhid07, force
save temp_ks17.dta, replace
use "ready_DID", clear
merge 1:1 hhid07 using temp_ks17.dta

tab _merge
drop _merge
save "ready_DID", replace

rename ks02 ks02_5

*KS02 consumption wave 4

use ready_DID.dta, clear

use hhid07 ks02 using "b1_ks1_4.dta", clear
rename ks02 ks02_4
duplicates drop hhid07, force
save temp_ks17_4.dta, replace
use "ready_DID", clear
merge 1:1 hhid07 using temp_ks17_4.dta

tab _merge
drop _merge
save "ready_DID", replace

// stacking
use "ready_DID", clear

drop ar17 ar09 hhsize ar13 kr03 tk01 matched control treated _weight _ks02 _n1 _nn

drop if missing(hhid07, TREAT, sc010099, ks02, ks02_4, _treated)

//stacking in stata

ssc install renvars
renvars ks02_4 ks02, pref (cons)
reshape long cons, i(hhid07) j(post) str
order hhid07
sort post hhid07

gen post_num = .
replace post_num = 1 if post == "ks02"
replace post_num = 0 if post == "ks02_4"

drop post
rename post_num post

// done

save "ready_bgt.dta", replace
use ready_bgt.dta

// did bejir gini doang

reg cons TREAT##post



