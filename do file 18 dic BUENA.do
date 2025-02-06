import excel "C:\Users\aulavirtual\Downloads\Copy of independent variables world bank.xlsx", sheet("Data") cellrange(A1:J11) firstrow case(lower)
describe
tsset year
gen post_bitcoin = year >= 2021
drop if year > 2023
destring accountownership, replace
list year accountownership if missing(accountownership)
ipolate accountownership year, gen(account_interp)
regress accountownership year if year <= 2021
predict account_extrapolated if year >= 2022
replace account_interp = account_extrapolated if missing(account_interp)
browse
replace accountownership = account_interp
drop account_interp
drop account_extrapolated
drop country
destring giniindex, replace
ssc install asdoc
asdoc describe, replace
asdoc summarize unemployment accountownership gdppercapita personalremittances inflation gdpgrowth bitcoinprices giniindex if post_bitcoin == 0
asdoc summarize unemployment accountownership gdppercapita personalremittances inflation gdpgrowth bitcoinprices giniindex if post_bitcoin == 1
asdoc graph twoway (line unemployment year), xline(2021)
asdoc graph twoway (line accountownership year), xline(2021)
asdoc graph twoway (line gdppercapita year), xline(2021)
asdoc graph twoway (line personalremittances year), xline(2021)
asdoc graph twoway (line inflation year), xline(2021)
asdoc graph twoway (line gdpgrowth year), xline(2021)
asdoc graph twoway (line bitcoinprices year), xline(2021)
asdoc graph twoway (line giniindex year), xline(2021)
