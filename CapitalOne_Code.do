use exhibit_all, clear

* (1) checking all possible interactions for BK 190 and BK 210 groups from historical data
logistic sale i.apr##i.fixvar i.apr##i.fee i.fee##i.fixvar i.bkscore if bkscore!=255 [fw=people]

* (2) checking all possible interactions for BK 255 group from historical data
logistic sale i.apr##i.fixvar i.apr##i.fee i.fee##i.fixvar if bkscore==255 [fw=people]

* From (1) above, we found that only the interaction between APR and annual fee is meaningful
logistic sale i.apr##i.fee i.fixvar i.bkscore if bkscore!=255 [fw=people]

* make predictions for only BK 190 and BK 210 groups, not BK 255 group
predict prob_pred if bkscore!=255

* From (2) above, we found that any interactions are not reasonable -> do not use any interactions
logistic sale i.apr i.fee i.fixvar if bkscore==255 [fw=people]

* make predictions for BK 255 group
predict temp if bkscore==255
replace prob_pred=temp if bkscore==255
drop temp

* Using test_result file:

replace people = 4921 in 1
replace people = 79 in 2
replace people = 4941 in 3
replace people = 59 in 4
replace people = 4804 in 5
replace people = 196 in 6
replace people = 4926 in 13
replace people = 74 in 14
replace people = 4928 in 21
replace people = 72 in 22
replace people = 4878 in 25
replace people = 122 in 26
replace people = 4763 in 29
replace people = 237 in 30
replace people = 4791 in 31
replace people = 209 in 32
replace people = 4894 in 37
replace people = 106 in 38
replace people = 4936 in 45
replace people = 64 in 46
replace people = 4878 in 49
replace people = 122 in 50
replace people = 4912 in 51
replace people = 88 in 52
replace people = 4886 in 63
replace people = 114 in 64
replace people = 4975 in 65
replace people = 25 in 66
replace people = 4917 in 69
replace people = 83 in 70
replace people = 4928 in 71
replace people = 72 in 72

logistic sale i.apr i.fee i.fixvar if bkscore==150 [fw=people]
predict prob_pred if bkscore==150

logistic sale i.apr i.fee i.fixvar if bkscore==200 [fw=people]
predict temp if bkscore==200
replace prob_pred=temp if bkscore==200
drop temp

logistic sale i.apr i.fee i.fixvar if bkscore==250 [fw=people]
predict temp if bkscore==250
replace prob_pred=temp if bkscore==250
drop temp

gen pred_profit=ltv*prob_pred
