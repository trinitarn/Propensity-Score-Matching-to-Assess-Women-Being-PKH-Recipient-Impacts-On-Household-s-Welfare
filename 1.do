set more off 
clear
cd "C:\Users\nitar\Documents\sekripsi\dua per tiga\psm matching\trial 2"

use "sampel_psm_pkh.dta"

ssc install psmatch2, replace
psmatch2 TREAT ar17* ar09* sc010099* hhsize* ar13* kr03* tk01*, out (ks02) common

psgraph

pstest