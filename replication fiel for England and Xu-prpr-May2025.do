
gen minmonth_exactnew_oct=CV_CHILD_BIRTH_MONTH_01_2019-9 if orimax2==2 &orimax==2 
replace minmonth_exactnew_oct=CV_CHILD_BIRTH_MONTH_01_2019 -9 if orimax2==2 &orimax==1 
replace minmonth_exactnew_oct=CV_CHILD_BIRTH_MONTH_01_2019 -9  if orimax2==2 &orimax==3 

gen diff2_oct=1 if contimonth<=minmonth_exactnew_oct
replace diff2_oct=. if contimonth>minmonth_exactnew_oct

gen ori_cohab_birth_exact1_oct=ori_cohab_birth_exact1
replace  ori_cohab_birth_exact1_oct=2 if contimonth==minmonth_exactnew_oct & orimax2==2 &orimax==2
replace  ori_cohab_birth_exact1_oct=2 if contimonth==minmonth_exactnew_oct & orimax2==2 &orimax==1
replace  ori_cohab_birth_exact1_oct=2 if contimonth==minmonth_exactnew_oct & orimax2==2 &orimax==3




*****This do.file will replicate the annalysis for the paper
*****"US Women's First Family-Forming Transitions to Cohabitation or Birth:
*****Differences by Racial and Socioeconomic Disadvantage Challenge
*****the Theory of the Second Demographic Transition". You need to download the 
*****relevant variables from the NLSY website. Following is the link
*****

*****month analysis****************************************
gen abso_age=(minmonth_exactnew-birthday_conti)/12
tab abso_age
drop if abso_age<14


*table 1, who moves first_incar_month
*:conception 9*
tab orimax2 mlthw_edu ,m
*birth first
tab orimax mlthw_edu ,m

*life tables
order  ID contimonth  minmonth* abso_age eventage_yr1

*conception 9 months
tab  eventage_yr1  orimax2 if   mlthw_edu==0 
tab eventage_yr1  orimax2 if   mlthw_edu==1
tab eventage_yr1  orimax2 if   mlthw_edu==2

tab  eventage_yr1  orimax2 if  mlthw_edu==3
tab  eventage_yr1  orimax2 if  mlthw_edu==4
tab  eventage_yr1  orimax2 if  mlthw_edu==5

*birth first
tab  eventage_yr1  orimax if  mlthw_edu==0 
tab eventage_yr1  orimax if   mlthw_edu==1
tab eventage_yr1  orimax if   mlthw_edu==2

tab  eventage_yr1  orimax if   mlthw_edu==3
tab  eventage_yr1  orimax if   mlthw_edu==4
tab  eventage_yr1  orimax if   mlthw_edu==5 

****singele yr prob from life tables, cohab(no idenitfy shotgun), birth, marriage
egen eventage_yrsg= cut(abso_age), at(14,15,16,17,18,19,20,21,22,23,24,25, ///
26,27,28,29,30,31,32,33,34,35,36,37,38)
*conception 9 months
tab  eventage_yrsg orimax2 if    mlthw_edu==0 
tab  eventage_yrsg orimax2 if    mlthw_edu==1
tab  eventage_yrsg orimax2 if    mlthw_edu==2

tab   eventage_yrsg orimax2 if    mlthw_edu==3
tab  eventage_yrsg orimax2 if    mlthw_edu==4
tab   eventage_yrsg orimax2 if    mlthw_edu==5


***ave 
************try the conceptin first************************************************
mlogit ori_cohab_birth_exact1 i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2==1  , rrr cluster(ID)

outreg2 using mn18cohab_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post
estimates save ave18_11sg9
outreg2 using mnlsep18ave1sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/

*
mlogit ori_cohab_birth_exact1 i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 if  diff2==1  , rrr cluster(ID)

outreg2 using mn18cohab_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_21sg9
outreg2 using mnlsep18ave1sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/

*
mlogit ori_cohab_birth_exact1 i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
if  diff2==1  , rrr cluster(ID)

outreg2 using mn18cohab_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(1))  at(agedis18new =0) vsquish post 
estimates save ave18_31sg9
outreg2 using mnlsep18ave1sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append */

*
mlogit ori_cohab_birth_exact1 i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

outreg2 using mn18cohab_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_41sg9
outreg2 using mnlsep18ave1sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append */

*
mlogit ori_cohab_birth_exact1 ib1.biomomedu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2==1  , rrr cluster(ID)

outreg2 using mn18cohab_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_51sg9
outreg2 using mnlsep18ave1sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append */


 mlogit ori_cohab_birth_exact1  i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
 i.singlemom1 i.hhstru_allelse i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 if  diff2==1  , rrr cluster(ID) 

outreg2 using mn18cohab_d_women.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform



**at age 18 for birth 
*
mlogit ori_cohab_birth_exact1 i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2==1  , rrr cluster(ID)

outreg2 using mn18birth_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform


/*margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_12bsg91
outreg2 using mnlsep18ave1bsg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/

*
mlogit ori_cohab_birth_exact1 i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1  if  diff2==1  , rrr cluster(ID)

outreg2 using mn18birth_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post 
estimates save ave18_22bsg9
outreg2 using mnlsep18ave1bsg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/


*
mlogit ori_cohab_birth_exact1 i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
if  diff2==1  , rrr cluster(ID)

outreg2 using mn18birth_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(2)) at(agedis18new =0)  vsquish post
estimates save ave18_32bsg9
outreg2 using mnlsep18ave1bsg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/


*
mlogit ori_cohab_birth_exact1 i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin  if  diff2==1  , rrr cluster(ID)

outreg2 using mn18birth_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_42bsg9
outreg2 using mnlsep18ave1bsg9.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append*/

*
mlogit ori_cohab_birth_exact1 i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin  i.enrolled2 if  diff2==1  , rrr cluster(ID)

outreg2 using mn18birth_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_52bsg9
outreg2 using mnlsep18ave1bsg9.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append*/
 
*****at age 22 for cohab 
*
mlogit ori_cohab_birth_exact1 i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2==1  , rrr cluster(ID)

outreg2 using mn22cohab_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform


/*margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post
estimates save ave22_11sg9
outreg2 using mnlsep22ave1sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/

*
mlogit ori_cohab_birth_exact1 i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 if  diff2==1  , rrr cluster(ID)

outreg2 using mn22cohab_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform


/*margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_21sg9
outreg2 using mnlsep22ave1sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/

*
mlogit ori_cohab_birth_exact1 i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
if  diff2==1  , rrr cluster(ID)

outreg2 using mn22cohab_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(1))  at(agedis22new =0) vsquish post 
estimates save ave22_31sg9
outreg2 using mnlsep22ave1sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/

*
mlogit ori_cohab_birth_exact1 i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

outreg2 using mn22cohab_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_41sg9
outreg2 using mnlsep22ave1sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/

*
mlogit ori_cohab_birth_exact1 i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin  i.enrolled2  if  diff2==1  , rrr cluster(ID)

outreg2 using mn22cohab_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_51sg9
outreg2 using mnlsep22ave1sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/

*age 22 for birth
mlogit ori_cohab_birth_exact1 i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ////
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984   if  diff2_oct==1  , rrr cluster(ID)

outreg2 using mn22birth_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post
estimates save ave22_12sg9
outreg2 using mnlsep22ave1bsg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/

*
mlogit ori_cohab_birth_exact1 i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ////
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 if  diff2==1  , rrr cluster(ID)

outreg2 outreg2 using mn22cohab_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_22sg9
outreg2 using mnlsep22ave1bsg9.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append*/

*
mlogit ori_cohab_birth_exact1 i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
if  diff2==1  , rrr cluster(ID)

outreg2 using mn22birth_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(2))  at(agedis22new =0) vsquish post 
estimates save ave22_32sg9
outreg2 using mnlsep22ave1bsg9.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append*/


mlogit ori_cohab_birth_exact1 i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

outreg2 using mn22birth_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform


/*margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_42sg9
outreg2 using mnlsep22ave1bsg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/

*
mlogit ori_cohab_birth_exact1 i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.blthw_edu#c.agedis22new ///
ib0.blthw_edu#c.agedis22new#c.agedis22new ib0.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 if  diff2==1  , rrr cluster(ID)

outreg2 using mn22birth_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_52sg9
outreg2 using mnlsep22ave1bsg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/



***********imputation
use "/Users/mx2154/Desktop/Desktop - ADUAEI12760LPMX - 1/nlsy/for pub/mar_cohab_birth_bandw_imp.dta"
 
keep if diff2_oct==1
drop if blthw_edu==.

gen unprotected_new= unprotected1
replace  unprotected_new=.  if unprotected1>500

gen unprotect_0_im=1 if unprotected1 ==0
replace unprotect_0_im=0 if unprotect_0_im==. &  unprotected_new!=. 

gen unprotect_10_im=1 if unprotected1 >0 & unprotected1 <=10
replace unprotect_10_im=0 if unprotect_10_im==. &  unprotected_new!=. 

gen unprotect_above10_im=1 if unprotected1 >10  &  unprotected_new!=.
replace unprotect_above10_im=0 if unprotect_above10_im==. &  unprotected_new!=. 

gen new299_im=new299_1new

*
gen noactive=0 if new299_1new!=. |(unprotected_new >0 &  unprotected_new  !=.)  
replace noactive=1 if new299_1new==0 &  unprotected_new ==0

gen active_noun=0 if new299_1new!=. |(unprotected_new >0 &  unprotected_new !=.) 
replace active_noun=1 if new299_1new==1 & unprotected_new ==0

gen active_ls10=0 if new299_1new!=. |(unprotected_new >0 &  unprotected_new  !=.) 
replace active_ls10=1 if new299_1new==1 &  unprotected_new >0 & unprotected_new <=10

gen active_mt10=0 if new299_1new!=. |(unprotected_new >0 &  unprotected_new  !=.) 
replace active_mt10=1 if new299_1new==1 &  unprotected_new >10 & unprotected_new <=500

*
gen noactive_im=noactive
gen active_noun_im=active_noun
gen active_ls10_im=active_ls10
gen active_mt10_im=active_mt10

summ  ori_cohab_birth_exact1  blthw_edu mlthw_edu CENSUS_12 msa12 BDATE_Y_1997 ///
agedis18new agedis18_sqnew agedis18_cubicnew  bioandstep1 singlemom1 ///
singledad1 foster hhstruother1 incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing gpa23 gpa335 gpaabove35 gpamissin noactive_im active_noun_im active_ls10_im active_mt10_im

mdesc ori_cohab_birth_exact1  blthw_edu mlthw_edu  CENSUS_12 msa12 BDATE_Y_1997 ///
agedis18new agedis18_sqnew agedis18_cubicnew bioandstep1 singlemom1 ///
singledad1 foster hhstruother1 incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing gpa23 gpa335 gpaabove35 gpamissin noactive_im active_noun_im active_ls10_im active_mt10_im

mi set mlong

mi misstable summarize ori_cohab_birth_exact1 blthw_edu mlthw_edu CENSUS_12 msa12 BDATE_Y_1997 ///
agedis18new agedis18_sqnew agedis18_cubicnew bioandstep1 singlemom1 ///
singledad1 foster hhstruother1 incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing gpa23 gpa335 gpaabove35 gpamissin noactive_im active_noun_im active_ls10_im active_mt10_im, all

mi misstable patterns ori_cohab_birth_exact1  blthw_edu mlthw_edu CENSUS_12 msa12 BDATE_Y_1997 ///
agedis18new agedis18_sqnew agedis18_cubicnew bioandstep1 singlemom1 ///
singledad1 foster hhstruother1 incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing gpa23 gpa335 gpaabove35 gpamissin noactive_im active_noun_im active_ls10_im active_mt10_im



   Missing-value patterns
     (1 means complete)

              |   Pattern
    Percent   |  1  2  3
  ------------+-------------
       71%    |  1  1  1
              |
       11     |  1  0  0
       10     |  0  1  1
        7     |  0  0  0
  ------------+-------------
      100%    |


  Variables are  (1) new299_im  (2) unprotect_10_im  (3) unprotect_above10_im

/*https://stats.oarc.ucla.edu/stata/seminars/mi_in_stata_pt1_new/

bservations in the data set that share the same pattern of missing information. For example, row 1 represents the 81% of observations in the data that have complete information on all 1 variables of interest (times of unprotected sex). You can see that there are a total of 2 patterns for the specified variables. You will want to examine this table for any patterns and the appearance of any set of variables that appear to always be missing together. Moreover, depending on the nature of the data, you may also recognize patterns such as monotone missing which can be observed in longitudinal data when an individual drops out at a particular time point and therefore all data after that is subsequently missing. Additionally, you may identify skip patterns that were missed in your original review of the data that should then be dealt with before moving forward with the multiple imputation.

pwcorr ori_cohab_birth_exact1  blthw_edu CENSUS_12 urban12_1 urban12_unknown BDATE_Y_1997 ///
agedis18new agedis18_sqnew agedis18_cubicnew hhincqun bioandstep singlemom singledad ///
nobiopar hhstruother gpa23 gpa335 gpaabove35 gpamissin unprotected_new, obs

Third Step: If necessary, identify potential auxiliary variables

Auxiliary variables are variables in your data set that are either correlated with a missing variable(s) (the recommendation is r > 0.4) or are believed to be associated with missingness. These are factors that are not of particular interest in your analytic model , but they are added to the imputation model to increase power and/or to help make the assumption of MAR( Missing at random) more plausible. These variables have been found to improve the quality of imputed values generate from multiple imputation. Moreover, research has demonstrated their particular importance when imputing a dependent variable and/or when you have variables with a high proportion of missing information (Johnson and Young, 2011; Young and Johnson, 2010; Enders , 2010).*/

/*Good auxiliary variables can also be correlates or predictors of missingness. Let's create a set of missing data flags for each variable to be imputed.  We will then examine if our potential auxiliary variable socst also appears to predict missingness*

gen unprotect_miss_flag=1 if unprotected_new==.
replace unprotect_miss_flag=0 if unprotect_miss_flag==.

gen blthw_edu_flag=1 if blthw_edu==.
replace blthw_edu_flag=0 if blthw_edu_flag==.

ttest  singlemom , by(unprotect_miss_flag)
ttest  singlemom , by(blthw_edu_flag)

*Upon choosing to impute one or many variables, one of the first decisions you will make is the type of distribution under which you want to impute your variable(s). One available method uses Markov Chain Monte Carlo (MCMC) procedures which assume that all the variables in the imputation model have a joint multivariate normal distribution. This is probably the most common parametric approach for multiple imputation. The specific algorithm used is called the data augmentation (DA) algorithm, which belongs to the family of MCMC procedures. The algorithm fills in missing data by drawing from a conditional distribution, in this case a multivariate normal, of the missing data given the observed data. In most cases, simulation studies have shown that assuming a MVN distribution leads to reliable estimates even when the normality assumption is violated given a sufficient sample size (Demirtas et al., 2008; KJ Lee, 2010). However, biased estimates have been observed when the sample size is relatively small and the fraction of missing information is high.

Note: Since we are using a multivariate normal distribution for imputation, decimal and negative values are possible. These values are not a problem for estimation; however, we will need to create dummy variables for the nominal categorical variables so the parameter estimates for each level can be interpreted.*/


mi ptrace describe trace 
mi ptrace use trace, clear

mi register imputed noactive_im active_noun_im active_ls10_im active_mt10_im

mi impute mvn noactive_im active_noun_im active_ls10_im active_mt10_im = ori_cohab_birth_exact1  mlthw_edu  blthw_edu CENSUS_12 msa12 BDATE_Y_1997 ///
agedis18new agedis18_sqnew agedis18_cubicnew bioandstep1 singlemom1 ///
singledad1 foster hhstruother1 incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissing enrolled2, add(10) rseed (53421) saveptrace(trace,replace)


Multivariate imputation                     Imputations =       10
Multivariate normal regression                    added =       10
Imputed: m=1 through m=10                       updated =        0

Prior: uniform                               Iterations =     1000
burn-in =      100
between =      100


Observations per m             

Variable    Complete   Incomplete   Imputed      Total

unprotect_10~m      359110        79211     79211     438321
unprotect_ab~m      359110        79211     79211     438321
new299_im      360396        77925     77925     438321

(Complete + Incomplete = Total; Imputed is the minimum across m
of the number of filled-in observations.)

****************
Performing EM optimization:
note: hhinc_missing omitted because of collinearity.
note: 73117 observations omitted from EM estimation because of all imputation variables missing.
  observed log likelihood =  1302040.5 at iteration 1

Performing MCMC data augmentation ... 

Multivariate imputation                     Imputations =       20
Multivariate normal regression                    added =       10
Imputed: m=11 through m=20                      updated =        0

Prior: uniform                               Iterations =     1000
                                                burn-in =      100
                                                between =      100

------------------------------------------------------------------
                   |               Observations per m             
                   |----------------------------------------------
          Variable |   Complete   Incomplete   Imputed |     Total
-------------------+-----------------------------------+----------
       noactive_im |     365204        73117     73117 |    438321
    active_noun_im |     365204        73117     73117 |    438321
    active_ls10_im |     365204        73117     73117 |    438321
    active_mt10_im |     365204        73117     73117 |    438321
------------------------------------------------------------------
(Complete + Incomplete = Total; Imputed is the minimum across m
 of the number of filled-in observations.)

. 
*********************
mi estimate, post: mlogit ori_cohab_birth_exact1_oct i.mlthw_edu agedis18new ///
c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 bioandstep1 singlemom1 singledad1 foster hhstruother1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin enrolled2 active_noun_im active_ls10_im active_mt10_im  if  diff2==1  , rrr cluster(ID) 

outreg2 using mn18bim_cohab_d_onevar.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

mimrgns , dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_imp1_onevar
outreg2 using impuave_cohabـonevar.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

**
mi estimate, post: mlogit ori_cohab_birth_exact1  ib0.blthw_edu agedis18new ///
c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ib0.blthw_edu#c.agedis18new ///
ib0.blthw_edu#c.agedis18new#c.agedis18new ib0.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 bioandstep1 singlemom1 singledad1 foster hhstruother1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin enrolled2 active_noun_im active_ls10_im active_mt10_im  if  diff2==1, rrr cluster(ID) 
outreg2 using mn18bim_birth_d_onevar.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

mimrgns , dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post 
estimates save ave18_imp2_onrvar
outreg2 using impuave_birth_onevar.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

***********************
mi estimate, post: mlogit ori_cohab_birth_exact1  i.mlthw_edu agedis22new ///
c.agedis22new#c.agedis22new c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
bioandstep1 singlemom1 singledad1 foster hhstruother1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin active_noun_im active_ls10_im active_mt10_im enrolled2   if  diff2==1  , rrr cluster(ID) 

outreg2 using mn22bim_cohab_d_onrvar.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

mimrgns , dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_imp1_onrvar
outreg2 using impuave_cohab_onrvar.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*******
mi estimate, post: mlogit ori_cohab_birth_exact1  ib0.blthw_edu agedis22new c.agedis22new#c.agedis22new c.agedis22new#c.agedis22new#c.agedis22new ///
ib0.blthw_edu#c.agedis22new  ib0.blthw_edu#c.agedis22new#c.agedis22new ///
ib0.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
bioandstep1 singlemom1 singledad1 foster hhstruother1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin active_noun_im active_ls10_im active_mt10_im  enrolled2 if  diff2==1  , rrr cluster(ID)

outreg2 using mn22bim_birth_d_onrvar.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

mimrgns , dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_imp2_onrvar
outreg2 using impuave_birth_onrvar.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*******



*********************
mi estimate, post: mlogit ori_cohab_birth_exact1  i.mlthw_edu agedis18new ///
c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 bioandstep1 singlemom1 singledad1 foster hhstruother1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin new299_im enrolled2   if  diff2==1  , rrr cluster(ID) 

outreg2 using mn18bim_cohab_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

mimrgns , dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_imp1
outreg2 using impuave_cohab.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

**
mi estimate, post: mlogit ori_cohab_birth_exact1  i.blthw_edu agedis18new ///
c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
bioandstep1 singlemom1 singledad1 foster hhstruother1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin ///
unprotect_10_im unprotect_above10_im  enrolled2 if  diff2==1  , rrr cluster(ID)

outreg2 using mn18bim_birth_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

mimrgns , dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post 
estimates save ave18_imp2
outreg2 using impuave_birth.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

***********************
mi estimate, post: mlogit ori_cohab_birth_exact1  i.mlthw_edu agedis22new ///
c.agedis22new#c.agedis22new c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
bioandstep1 singlemom1 singledad1 foster hhstruother1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin new299_im enrolled2   if  diff2==1  , rrr cluster(ID) 

outreg2 using mn22bim_cohab_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

mimrgns , dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_imp1
outreg2 using impuave_cohab.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*******
mi estimate, post: mlogit ori_cohab_birth_exact1  ib0.blthw_edu agedis22new c.agedis22new#c.agedis22new c.agedis22new#c.agedis22new#c.agedis22new ///
ib0.blthw_edu#c.agedis22new  ib0.blthw_edu#c.agedis22new#c.agedis22new ///
ib0.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
bioandstep1 singlemom1 singledad1 foster hhstruother1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin unprotect_10_im unprotect_above10_im  enrolled2 if  diff2==1  , rrr cluster(ID)

outreg2 using mn22bim_birth_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

mimrgns , dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_imp2
outreg2 using impuave_birth.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*******
***********



****put excel**
forvalues i=0/4{
	
gen reli_ser_2000_`i'=0
replace reli_ser_2000_`i'=1 if  reli_ser_2000==`i'
}



putexcel set descallmonths.xls, replace

local abc  C D E F G H
local group  mlthw_edunew_0 mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5

local inde intact1 bioandstep1 singlemom1 singledad1 foster hhstruother1 gpalessthan2 ///
gpa23 gpa335 gpaabove35 gpamissin incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing enrolled2 ///
reli_ser_2000_0 reli_ser_2000_1 reli_ser_2000_2 reli_ser_2000_3 reli_ser_2000_4 

local j=4
local g=6

foreach  y in intact1 bioandstep1 singlemom1 singledad1 foster hhstruother1 gpalessthan2 ///
gpa23 gpa335 gpaabove35 gpamissin incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing  enrolled2 ///
reli_ser_2000_0 reli_ser_2000_1 reli_ser_2000_2 reli_ser_2000_3 reli_ser_2000_4 {
forvalue i=1/6 { 

local var: word `i' of `group'
local n: word `i' of `abc'

qui sum `y' if  `var'==1 & diff2==1

local mean: dis  `r(mean)' , %9.2f
local N: dis `r(N)', %9.2f

putexcel B`j'=("`y'") `n'`j'=("`mean'") `n'`g'=("`N'")  
 

 }

local j=`j'+3
local g=`g'+3
}
*****



****put excel**
putexcel set desc1allmonths_whole.xls, replace

local abc  C  
local group  diff2 

local inde intact1 bioandstep1 singlemom1 singledad1 foster hhstruother1 gpalessthan2 ///
gpa23 gpa335 gpaabove35 gpamissin incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing enrolled2 ///
reli_ser_2000_0 reli_ser_2000_1 reli_ser_2000_2 reli_ser_2000_3 reli_ser_2000_4

local j=4
local g=5

foreach  y in intact1 bioandstep1 singlemom1 singledad1 foster hhstruother1 gpalessthan2 ///
gpa23 gpa335 gpaabove35 gpamissin incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing  enrolled2 ///
reli_ser_2000_0 reli_ser_2000_1 reli_ser_2000_2 reli_ser_2000_3 reli_ser_2000_4 {
forvalue i=1/1{

local var: word `i' of `group'
local n: word `i' of `abc'

qui sum `y' if  `var' ==1  &  mlthw_edu!=.

local mean: dis  `r(mean)' , %9.2f
local N: dis `r(N)', %9.2f

putexcel B`j'=("`y'") `n'`j'=("`mean'") `n'`g'=("`N'")  
 
}

local j=`j'+2 
local g=`g'+2
}
*****



* Table ttest
	file open desc_table using "tteststats1new.csv", w replace
	file write desc_table "Trait, ref mean, com mean, p value" _n

	* Go through each variable on the table, find the mean, std dev., 25th and 75th percentile
	* Print all these to a new row for that variable
foreach subset in intact1 bioandstep1 singlemom1 singledad1 foster hhstruother1 gpalessthan2 ///
gpa23 gpa335 gpaabove35 gpamissin incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
 reli_ser_2000_0 reli_ser_2000_1 reli_ser_2000_2 reli_ser_2000_3 reli_ser_2000_4 enrolled2   {


		
		qui: ttest `subset' if  diff2==1, by(mlthw_edunew_1)
		local ref_mean = round(r(mu_1),0.0001)
		local com_mean = round(r(mu_2),0.0001)
		local p = round(r(p),0.001)

		
		file write desc_table "`subset',`ref_mean', `com_mean', `p'" _n
	}
file close desc_table 
*

	file open desc_table using "tteststats2new.csv", w replace
	file write desc_table "Trait, ref mean, com mean, p value" _n

	* Go through each variable on the table, find the mean, std dev., 25th and 75th percentile
	* Print all these to a new row for that variable
foreach subset in intact1 bioandstep1 singlemom1 singledad1 foster hhstruother1 gpalessthan2 ///
gpa23 gpa335 gpaabove35 gpamissin incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing  ///
reli_ser_2000_0 reli_ser_2000_1 reli_ser_2000_2 reli_ser_2000_3 reli_ser_2000_4 enrolled2    {


		
		qui: ttest `subset' if diff2==1, by(mlthw_edunew_2)
		local ref_mean = round(r(mu_1),0.0001)
		local com_mean = round(r(mu_2),0.0001)
		local p = round(r(p),0.001)

		
		file write desc_table "`subset',`ref_mean', `com_mean', `p'" _n
	}
file close desc_table 
*

	file open desc_table using "tteststats3new.csv", w replace
	file write desc_table "Trait, ref mean, com mean, p value" _n

	* Go through each variable on the table, find the mean, std dev., 25th and 75th percentile
	* Print all these to a new row for that variable
foreach subset in intact1 bioandstep1 singlemom1 singledad1 foster hhstruother1 gpalessthan2 ///
gpa23 gpa335 gpaabove35 gpamissin incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
 reli_ser_2000_0 reli_ser_2000_1 reli_ser_2000_2 reli_ser_2000_3 reli_ser_2000_4 enrolled2    {


		
		qui: ttest `subset' if  diff2==1, by(mlthw_edunew_3)
		local ref_mean = round(r(mu_1),0.0001)
		local com_mean = round(r(mu_2),0.0001)
		local p = round(r(p),0.001)

		
		file write desc_table "`subset',`ref_mean', `com_mean', `p'" _n
	}
file close desc_table 
*

	file open desc_table using "tteststats4new.csv", w replace
	file write desc_table "Trait, ref mean, com mean, p value" _n

	* Go through each variable on the table, find the mean, std dev., 25th and 75th percentile
	* Print all these to a new row for that variable
foreach subset in intact1 bioandstep1 singlemom1 singledad1 foster hhstruother1 gpalessthan2 ///
gpa23 gpa335 gpaabove35 gpamissin incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
 reli_ser_2000_0 reli_ser_2000_1 reli_ser_2000_2 reli_ser_2000_3 reli_ser_2000_4 enrolled2 {


		
		qui: ttest `subset' if  diff2==1, by(mlthw_edunew_4)
		local ref_mean = round(r(mu_1),0.0001)
		local com_mean = round(r(mu_2),0.0001)
		local p = round(r(p),0.001)

		
		file write desc_table "`subset',`ref_mean', `com_mean', `p'" _n
	}
file close desc_table 
*

	file open desc_table using "tteststats5new.csv", w replace
	file write desc_table "Trait, ref mean, com mean, p value" _n

	* Go through each variable on the table, find the mean, std dev., 25th and 75th percentile
	* Print all these to a new row for that variable
foreach subset in intact1 bioandstep1 singlemom1 singledad1 foster hhstruother1 gpalessthan2 ///
gpa23 gpa335 gpaabove35 gpamissin incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
 reli_ser_2000_0 reli_ser_2000_1 reli_ser_2000_2 reli_ser_2000_3 reli_ser_2000_4 enrolled2 {


		
		qui: ttest `subset' if  diff2==1, by(mlthw_edunew_5)
		local ref_mean = round(r(mu_1),0.0001)
		local com_mean = round(r(mu_2),0.0001)
		local p = round(r(p),0.001)

		
		file write desc_table "`subset',`ref_mean', `com_mean', `p'" _n
	}
file close desc_table 
*


**********
sum  enrolled2 if  diff2_oct==1 [aw=weight]  , d
sum  enrolled2 if agedis22new<0 & diff2_oct==1 [aw=weight] , d
sum  enrolled2 if agedis18new<0 & diff2_oct==1 [aw=weight] , d
*
foreach x in mlthw_edunew_0 mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5{ 
sum enrolled2 if `x'==1 &  diff2_oct==1 [aw=weight]  
}
*
foreach x in mlthw_edunew_0 mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5{ 
sum enrolled2 if `x'==1 & agedis18new<0 & diff2_oct==1  [aw=weight]  
}
*
foreach x in mlthw_edunew_0 mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5{ 
sum enrolled2 if `x'==1 & agedis22new<0 & diff2_oct==1  [aw=weight]  
}
*
**************************************************************************
/*sum  new299_im   if agedis18new<0 &  diff2==1  , d
foreach x in mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5{ 
	ttest new299_im  if agedis18new<0 & diff2==1  , by(`x')
}

sum  new299_im   if agedis22new<0  &  diff2==1  , d
foreach x in mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5{ 
	ttest new299_im  if agedis22new<0 & diff2==1  , by(`x')
}

sum  new299_im   if  diff2==1  , d
foreach x in mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5{ 
	ttest new299_im  if  diff2==1  , by(`x')
}
*/
***********
sum unprotect_0_im if agedis18new<0 &  diff2==1  , d
foreach x in mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5{ 
	ttest unprotect_0_im if agedis18new<0  & diff2==1  , by(`x')
}
*
sum unprotect_10_im if agedis18new<0 &  diff2==1  , d
foreach x in mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5{ 
	ttest unprotect_10_im if agedis18new<0 & diff2==1  , by(`x')
}
*
sum unprotect_above10_im if agedis18new<0 &  diff2==1  , d
foreach x in mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5{ 
	ttest unprotect_above10_im if agedis18new<0 & diff2==1  , by(`x')
}

*******************************
sum unprotect_0_im if agedis22new<0 & diff2==1 ,d
foreach x in mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5{ 
	ttest unprotect_0_im if agedis22new<0 & diff2==1    , by(`x')
}

sum unprotect_10_im if agedis22new<0 & diff2==1 ,d
foreach x in mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5{ 
	ttest unprotect_10_im if agedis22new<0 & diff2==1  , by(`x')
}

sum unprotect_above10_im  if agedis22new<0 & diff2==1 ,d
foreach x in mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5{ 
	ttest unprotect_above10_im if agedis22new<0 & diff2==1  , by(`x')
}


************************************************************************

sum unprotect_0_im if  diff2==1 ,d
foreach x in mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5{ 
	ttest unprotect_0_im if  diff2==1    , by(`x')
}

sum unprotect_10_im if diff2==1 ,d
foreach x in mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5{ 
	ttest unprotect_10_im if diff2==1  , by(`x')
}

sum unprotect_above10_im  if  diff2==1 ,d
foreach x in mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5{ 
	ttest unprotect_above10_im if   diff2==1  , by(`x')
}
*
************************************************************************
. order ID contimonth _mi_m _mi_id _mi_miss noactive noactive_im 
sort ID contimonth _mi_m
///
active_noun active_noun_im active_ls10 active_ls10_im active_mt10 active_mt10_im

ssc install misum
mi convert flong

********************************************************************
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 [aw=weight] ,d 
}
*
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 & mlthw_edu==0  [aw=weight] ,d 
}
*
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 & mlthw_edu==1  [aw=weight] ,d 
}
*
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 & mlthw_edu==2 [aw=weight]  ,d 
}
*
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 & mlthw_edu==3 [aw=weight] ,d 
}
*
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 & mlthw_edu==4 [aw=weight],d 
}
*
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 & mlthw_edu==5 [aw=weight] ,d 
}
*
**********

*******************************************************************
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 &  agedis18new<0 [aw=weight]  ,d 
}
*
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 & mlthw_edu==0  &  agedis18new<0 [aw=weight] ,d 
}
*
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 & mlthw_edu==1 &  agedis18new<0 [aw=weight]  ,d 
}
*
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 & mlthw_edu==2 &  agedis18new<0  [aw=weight]  ,d 
}
*
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 & mlthw_edu==3 &  agedis18new<0 [aw=weight],d 
}
*
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 & mlthw_edu==4 &  agedis18new<0  [aw=weight] ,d 
}
*
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 & mlthw_edu==5 &  agedis18new<0  [aw=weight]  ,d 
}
******

********************************************************************
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 &  agedis22new<0 [aw=weight] ,d 
}
*
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 & mlthw_edu==0  &  agedis22new<0 [aw=weight],d 
}
*
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 & mlthw_edu==1 &  agedis22new<0 [aw=weight] ,d 
}
*
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 & mlthw_edu==2 &  agedis22new<0 [aw=weight] ,d 
}
*
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 & mlthw_edu==3 &  agedis22new<0 [aw=weight] ,d 
}
*
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 & mlthw_edu==4 &  agedis22new<0 [aw=weight] ,d 
}
*
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 & mlthw_edu==5 &  agedis22new<0 [aw=weight] ,d 
}

*****************
foreach x in mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5{ 
	ttest noactive_im  if agedis22new<0 & diff2==1    , by(`x')
}

foreach x in mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5{ 
	ttest active_noun_im if agedis22new<0 & diff2==1  , by(`x')
}

foreach x in mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5{ 
	ttest active_ls10_im  if agedis22new<0 & diff2==1   , by(`x')
}

foreach x in mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5{ 
	ttest  active_mt10_im if agedis22new<0 & diff2==1   , by(`x')
}
*


*****************************
forvalues i=0/5 { 

gen mlthw_edunew_`i'=1 if mlthw_edu==`i' 
replace  mlthw_edunew_`i'=0 if mlthw_edunew_`i'==. & mlthw_edu==0
}
*
foreach x in mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5{ 
	gen `x'_b=`x' 
	replace `x'_b=. if `x'==0
	replace `x'_b=0 if  mlthw_edunew_3==1
}

rename mlthw_edunew_3_b mlthw_edunew_0_b
replace  mlthw_edunew_0_b=1 if  mlthw_edunew_0==1


* Table ttest2
	file open desc_table using "tteststats0bnew.csv", w replace
	file write desc_table "Trait, ref mean, com mean, p value" _n

	* Go through each variable on the table, find the mean, std dev., 25th and 75th percentile
	* Print all these to a new row for that variable
foreach subset in intact1 bioandstep1 singlemom1 singledad1 foster hhstruother1 gpalessthan2 ///
gpa23 gpa335 gpaabove35 gpamissin incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing  ///
 reli_ser_2000_0 reli_ser_2000_1 reli_ser_2000_2 reli_ser_2000_3 reli_ser_2000_4 enrolled2  {


		
		qui: ttest `subset' if diff2==1, by(mlthw_edunew_0_b)
		local ref_mean = round(r(mu_1),0.0001)
		local com_mean = round(r(mu_2),0.0001)
		local p = round(r(p),0.001)

		
		file write desc_table "`subset',`ref_mean', `com_mean', `p'" _n
	}
file close desc_table 
*


	file open desc_table using "tteststats1bnew.csv", w replace
	file write desc_table "Trait, ref mean, com mean, p value" _n

	* Go through each variable on the table, find the mean, std dev., 25th and 75th percentile
	* Print all these to a new row for that variable
foreach subset in intact1 bioandstep1 singlemom1 singledad1 foster hhstruother1 gpalessthan2 ///
gpa23 gpa335 gpaabove35 gpamissin incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
 reli_ser_2000_0 reli_ser_2000_1 reli_ser_2000_2 reli_ser_2000_3 reli_ser_2000_4 enrolled2  {


		
		qui: ttest `subset' if  diff2==1, by(mlthw_edunew_1_b)
		local ref_mean = round(r(mu_1),0.0001)
		local com_mean = round(r(mu_2),0.0001)
		local p = round(r(p),0.001)

		
		file write desc_table "`subset',`ref_mean', `com_mean', `p'" _n
	}
file close desc_table 
*

	file open desc_table using "tteststats2bnew.csv", w replace
	file write desc_table "Trait, ref mean, com mean, p value" _n

	* Go through each variable on the table, find the mean, std dev., 25th and 75th percentile
	* Print all these to a new row for that variable
foreach subset in intact1 bioandstep1 singlemom1 singledad1 foster hhstruother1 gpalessthan2 ///
gpa23 gpa335 gpaabove35 gpamissin incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
 reli_ser_2000_0 reli_ser_2000_1 reli_ser_2000_2 reli_ser_2000_3 reli_ser_2000_4 enrolled2  {


		
		qui: ttest `subset' if  diff2==1, by(mlthw_edunew_2_b)
		local ref_mean = round(r(mu_1),0.0001)
		local com_mean = round(r(mu_2),0.0001)
		local p = round(r(p),0.001)

		
		file write desc_table "`subset',`ref_mean', `com_mean', `p'" _n
	}
file close desc_table 
*

	file open desc_table using "tteststats4bnew.csv", w replace
	file write desc_table "Trait, ref mean, com mean, p value" _n

	* Go through each variable on the table, find the mean, std dev., 25th and 75th percentile
	* Print all these to a new row for that variable
foreach subset in intact1 bioandstep1 singlemom1 singledad1 foster hhstruother1 gpalessthan2 ///
gpa23 gpa335 gpaabove35 gpamissin incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
 reli_ser_2000_0 reli_ser_2000_1 reli_ser_2000_2 reli_ser_2000_3 reli_ser_2000_4 enrolled2  {


		
		qui: ttest `subset' if  diff2==1, by(mlthw_edunew_4_b)
		local ref_mean = round(r(mu_1),0.0001)
		local com_mean = round(r(mu_2),0.0001)
		local p = round(r(p),0.001)

		
		file write desc_table "`subset',`ref_mean', `com_mean', `p'" _n
	}
file close desc_table 
*

	file open desc_table using "tteststats5bnew.csv", w replace
	file write desc_table "Trait, ref mean, com mean, p value" _n

	* Go through each variable on the table, find the mean, std dev., 25th and 75th percentile
	* Print all these to a new row for that variable
foreach subset in intact1 bioandstep1 singlemom1 singledad1 foster hhstruother1 gpalessthan2 ///
gpa23 gpa335 gpaabove35 gpamissin incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
 reli_ser_2000_0 reli_ser_2000_1 reli_ser_2000_2 reli_ser_2000_3 reli_ser_2000_4 enrolled2  {


		
		qui: ttest `subset' if  diff2==1, by(mlthw_edunew_5_b)
		local ref_mean = round(r(mu_1),0.0001)
		local com_mean = round(r(mu_2),0.0001)
		local p = round(r(p),0.001)

		
		file write desc_table "`subset',`ref_mean', `com_mean', `p'" _n
	}
file close desc_table 
*



****************************
*
foreach x in mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest  enrolled2  if agedis18new<0 &  diff2==1 , by(`x')
}

foreach x in mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest  enrolled2  if agedis22new<0 &  diff2==1 , by(`x')
}


foreach x in mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest  new299_im  if  agedis18new<0 & diff2==1 , by(`x')
}
*
foreach x in mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest  new299_im  if  agedis22new<0 & diff2==1 , by(`x')
}
*
foreach x in mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest  new299_im  if  diff2==1 , by(`x')
}
*

************************************
foreach x in mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest  unprotect_0_im  if  agedis18new<0 & diff2==1 , by(`x')
}
*

foreach x in mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest  unprotect_10_im  if  agedis18new<0 & diff2==1 , by(`x')
}
*

foreach x in mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest  unprotect_above10_im if  agedis18new<0 & diff2==1  , by(`x')
}
*


**********************************************
foreach x in mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest  unprotect_0_im  if  agedis22new<0 & diff2==1 , by(`x')
}
*

foreach x in mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest  unprotect_10_im  if  agedis22new<0 & diff2==1 , by(`x')
}
*

foreach x in mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest  unprotect_above10_im if  agedis22new<0 & diff2==1 , by(`x')
}
*
*****************
foreach x in mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest  unprotect_0_im  if  diff2==1 , by(`x')
}
*

foreach x in mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest  unprotect_10_im  if  diff2==1 , by(`x')
}
*

foreach x in mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest  unprotect_above10_im if  diff2==1 , by(`x')
}
*
********************************************************************
**********
foreach x in mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest noactive_im if  diff2==1   , by(`x')
}

foreach x in mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest active_noun_im if diff2==1   , by(`x')
}

foreach x in mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest active_ls10_im  if   diff2==1, by(`x')
}

foreach x in mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest  active_mt10_im if   diff2==1 , by(`x')
}

*******************************************************************
foreach x in  mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest noactive_im  if agedis18new<0 & diff2==1    , by(`x')
}
*
foreach x in  mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest active_noun_im if agedis18new<0 & diff2==1  , by(`x')
}
*
foreach x in  mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest active_ls10_im  if agedis18new<0 & diff2==1   , by(`x')
}
*
foreach x in  mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest  active_mt10_im if agedis18new<0 & diff2==1   , by(`x')
}
********************************************************************
foreach x in mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest noactive_im  if agedis22new<0 & diff2==1    , by(`x')
}

foreach x in mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest active_noun_im if agedis22new<0 & diff2==1  , by(`x')
}

foreach x in mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest active_ls10_im  if agedis22new<0 & diff2==1   , by(`x')
}

foreach x in mlthw_edunew_0_b mlthw_edunew_1_b mlthw_edunew_2_b mlthw_edunew_4_b mlthw_edunew_5_b{ 
	ttest  active_mt10_im if agedis22new<0 & diff2==1   , by(`x')
}
*


*weighted analysis 
gen weight=SAMPLING_WEIGHT_CC
bysort ID: replace weight=weight[_n+1] if weight==. & year<=1997


bysort ID: replace weight=weight[_n-1] if weight==. & year==2012
bysort ID: replace weight=weight[_n-1] if weight==. & year==2014
bysort ID: replace weight=weight[_n-1] if weight==. & year==2016
bysort ID: replace weight=weight[_n-1] if weight==. & year==2018
bysort ID: replace weight=weight[_n-1] if weight==. & year==2020
*

order ID weight SAMPLING_WEIGHT_CC year ori_cohab_birth_exact1 


***black reg coef plot
*
mlogit ori_cohab_birth_exact1 i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2==1  [pw=weight] , rrr cluster(ID)

outreg2 using mn18birthw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_12bsg9w
outreg2 using mnlsep18ave1bsg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se) append */

*
mlogit ori_cohab_birth_exact1 i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1  if  diff2==1 [pw=weight]  , rrr cluster(ID)

outreg2 using mn18birthw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post 
estimates save ave18_22bsg9w
outreg2 using mnlsep18ave1bsg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/


*
mlogit ori_cohab_birth_exact1 i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
if  diff2==1 [pw=weight]  , rrr cluster(ID)

outreg2 using mn18birthw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(2)) at(agedis18new =0)  vsquish post
estimates save ave18_32bsg9w
outreg2 using mnlsep18ave1bsg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/


*
mlogit ori_cohab_birth_exact1 i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin  if  diff2==1 [pw=weight]  , rrr cluster(ID)

outreg2 using mn18birthw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_42bsg9w
outreg2 using mnlsep18ave1bsg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append*/

*
mlogit ori_cohab_birth_exact1 i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin  i.enrolled2 if  diff2==1 [pw=weight]  , rrr cluster(ID)

outreg2 using mn18birthw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_52bsg9w
outreg2 using mnlsep18ave1bsg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append*/


*
mlogit ori_cohab_birth_exact1 i.blthw_edu   agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin ///
i.unprotect_10 i.unprotect_above10  i.unprotect_miss i.enrolled2  if ///
diff2==1 [pw=weight]  , rrr cluster(ID)

outreg2 using mn18birthw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_62bsg9w
outreg2 using mnlsep18ave1bsg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append*/


***at age 22

*
mlogit ori_cohab_birth_exact1 i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ////
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2==1 [pw=weight]  , rrr cluster(ID)

outreg2 using mn22birthw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post
estimates save ave22_12sg9w
outreg2 using mnlsep22ave1bsg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/

*
mlogit ori_cohab_birth_exact1 i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ////
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 if  diff2==1 [pw=weight] , rrr cluster(ID)

outreg2 using mn22birthw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_22sg9w
outreg2 using mnlsep22ave1bsg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append*/

*
mlogit ori_cohab_birth_exact1 i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
if  diff2==1 [pw=weight] , rrr cluster(ID)

outreg2 using mn22birthw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(2))  at(agedis22new =0) vsquish post 
estimates save ave22_32sg9w
outreg2 using mnlsep22ave1bsg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append*/

*
mlogit ori_cohab_birth_exact1 i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin if  diff2==1 [pw=weight]  , rrr cluster(ID)

outreg2 using mn22birthw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_42sg9w
outreg2 using mnlsep22ave1bsg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/

*
mlogit ori_cohab_birth_exact1 i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.blthw_edu#c.agedis22new ///
ib0.blthw_edu#c.agedis22new#c.agedis22new ib0.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 if  diff2==1 [pw=weight]  , rrr cluster(ID)

outreg2 using mn22birthw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_52sg9w
outreg2 using mnlsep22ave1bsg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/

*
mlogit ori_cohab_birth_exact1 i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.blthw_edu#c.agedis22new ///
ib0.blthw_edu#c.agedis22new#c.agedis22new ib0.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin  gpamissin i.unprotect_10 i.unprotect_above10 ///
i.unprotect_miss  i.enrolled2 if  diff2==1 [pw=weight] , rrr cluster(ID)

outreg2 using mn22birthw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_62sg9w
outreg2 using mnlsep22ave1bsg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/


***************cohab
mlogit ori_cohab_birth_exact1 i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2==1 [pw=weight]  , rrr cluster(ID)

outreg2 using mn18cohabw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post
estimates save ave18_11sg9w
outreg2 using mnlsep18ave1sg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/

*
mlogit ori_cohab_birth_exact1 i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 if  diff2==1 [pw=weight]  , rrr cluster(ID)

outreg2 using mn18cohabw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform


/*margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_21sg9w
outreg2 using mnlsep18ave1sg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append*/


*
mlogit ori_cohab_birth_exact1 i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
if  diff2==1 [pw=weight]  , rrr cluster(ID)

outreg2 using mn18cohabw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(1))  at(agedis18new =0) vsquish post 
estimates save ave18_31sg9w
outreg2 using mnlsep18ave1sg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append*/

*
mlogit ori_cohab_birth_exact1 i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin if  diff2==1 [pw=weight] , rrr cluster(ID)

outreg2 using mn18cohabw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform


/*margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_41sg9w
outreg2 using mnlsep18ave1sg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append*/

*
mlogit ori_cohab_birth_exact1 i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 if  diff2==1 [pw=weight] , rrr cluster(ID)

outreg2 using mn18cohabw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform


/*margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_51sg9w
outreg2 using mnlsep18ave1sg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append*/ 

*
mlogit ori_cohab_birth_exact1 i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.new299_1new i.enrolled2 if  diff2==1  [pw=weight] , rrr cluster(ID)

outreg2 using mn18cohabw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform


/*margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_61sg9w
outreg2 using mnlsep18ave1sgw9.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append*/

*****at age 22
*
mlogit ori_cohab_birth_exact1 i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2==1 [pw=weight]  , rrr cluster(ID)

outreg2 using mn22cohabw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform


/*margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post
estimates save ave22_11sg9w
outreg2 using mnlsep22ave1sg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/

*
mlogit ori_cohab_birth_exact1 i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 if  diff2==1  [pw=weight]  , rrr cluster(ID)

outreg2 using mn22cohabw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_21sg9w
outreg2 using mnlsep22ave1sg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/

*
mlogit ori_cohab_birth_exact1 i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
if  diff2==1 [pw=weight]  , rrr cluster(ID)

outreg2 using mn22cohabw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(1))  at(agedis22new =0) vsquish post 
estimates save ave22_31sg9w
outreg2 using mnlsep22ave1sg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/

*
mlogit ori_cohab_birth_exact1 i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  [pw=weight] , rrr cluster(ID)

outreg2 using mn22cohabw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_41sg9w
outreg2 using mnlsep22ave1sg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/

*
mlogit ori_cohab_birth_exact1 i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin  i.enrolled2  if  diff2==1 [pw=weight]  , rrr cluster(ID)

outreg2 using mn22cohabw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_51sg9w
outreg2 using mnlsep22ave1sg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/

*
mlogit ori_cohab_birth_exact1 i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 i.new299_1new  if  diff2==1 [pw=weight]  , rrr cluster(ID)

outreg2 using mn22cohabw_d.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

/*margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_61sg9w
outreg2 using mnlsep22ave1sg9w.xls, excel dec(6) cttop (mnl1)  stat (coef se) append*/

****weighted imputation 
keep if diff2==1
drop if blthw_edu==.

gen unprotected_new= unprotected1
replace  unprotected_new=.  if unprotected1>500

gen unprotect_0_im=1 if unprotected1 ==0
replace unprotect_0_im=0 if unprotect_0_im==. &  unprotected_new!=. 

gen unprotect_10_im=1 if unprotected1 >0 & unprotected1 <=10
replace unprotect_10_im=0 if unprotect_10_im==. &  unprotected_new!=. 

gen unprotect_above10_im=1 if unprotected1 >10  &  unprotected_new!=.
replace unprotect_above10_im=0 if unprotect_above10_im==. &  unprotected_new!=. 

gen new299_im=new299_1new

*
gen noactive=0 if new299_1new!=. |(unprotected_new >0 &  unprotected_new  !=.)  
replace noactive=1 if new299_1new==0 &  unprotected_new ==0

gen active_noun=0 if new299_1new!=. |(unprotected_new >0 &  unprotected_new !=.) 
replace active_noun=1 if new299_1new==1 & unprotected_new ==0

gen active_ls10=0 if new299_1new!=. |(unprotected_new >0 &  unprotected_new  !=.) 
replace active_ls10=1 if new299_1new==1 &  unprotected_new >0 & unprotected_new <=10

gen active_mt10=0 if new299_1new!=. |(unprotected_new >0 &  unprotected_new  !=.) 
replace active_mt10=1 if new299_1new==1 &  unprotected_new >10 & unprotected_new <=500

*
gen noactive_im=noactive
gen active_noun_im=active_noun
gen active_ls10_im=active_ls10
gen active_mt10_im=active_mt10

summ  ori_cohab_birth_exact1  blthw_edu mlthw_edu CENSUS_12 msa12 BDATE_Y_1997 ///
agedis18new agedis18_sqnew agedis18_cubicnew  bioandstep1 singlemom1 ///
singledad1 foster hhstruother1 incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing gpa23 gpa335 gpaabove35 gpamissin noactive_im active_noun_im active_ls10_im active_mt10_im

mdesc ori_cohab_birth_exact1  blthw_edu mlthw_edu  CENSUS_12 msa12 BDATE_Y_1997 ///
agedis18new agedis18_sqnew agedis18_cubicnew bioandstep1 singlemom1 ///
singledad1 foster hhstruother1 incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing gpa23 gpa335 gpaabove35 gpamissin noactive_im active_noun_im active_ls10_im active_mt10_im

mi set mlong

mi misstable summarize ori_cohab_birth_exact1 blthw_edu mlthw_edu CENSUS_12 msa12 BDATE_Y_1997 ///
agedis18new agedis18_sqnew agedis18_cubicnew bioandstep1 singlemom1 ///
singledad1 foster hhstruother1 incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing gpa23 gpa335 gpaabove35 gpamissin noactive_im active_noun_im active_ls10_im active_mt10_im, all

mi misstable patterns ori_cohab_birth_exact1  blthw_edu mlthw_edu CENSUS_12 msa12 BDATE_Y_1997 ///
agedis18new agedis18_sqnew agedis18_cubicnew bioandstep1 singlemom1 ///
singledad1 foster hhstruother1 incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing gpa23 gpa335 gpaabove35 gpamissin noactive_im active_noun_im active_ls10_im active_mt10_im


mi register imputed noactive_im active_noun_im active_ls10_im active_mt10_im

mi impute chained (mlogit) noactive_im active_noun_im active_ls10_im active_mt10_im = ori_cohab_birth_exact1  mlthw_edu  blthw_edu CENSUS_12 msa12 BDATE_Y_1997 ///
agedis18new agedis18_sqnew agedis18_cubicnew bioandstep1 singlemom1 ///
singledad1 foster hhstruother1 incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissing enrolled2 [pw=weight] , add(10) rseed (53421) augment

Conditional models (monotone):
       noactive_im: mlogit noactive_im ori_cohab_birth_exact1 mlthw_edu blthw_edu CENSUS_12 msa12 BDATE_Y_1997
                     agedis18new agedis18_sqnew agedis18_cubicnew bioandstep1 singlemom1 singledad1 foster
                     hhstruother1 incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing gpa23 gpa335
                     gpaabove35 gpamissing enrolled2 [pweight = weight], augment
    active_noun_im: mlogit active_noun_im i.noactive_im ori_cohab_birth_exact1 mlthw_edu blthw_edu CENSUS_12
                     msa12 BDATE_Y_1997 agedis18new agedis18_sqnew agedis18_cubicnew bioandstep1 singlemom1
                     singledad1 foster hhstruother1 incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing
                     gpa23 gpa335 gpaabove35 gpamissing enrolled2 [pweight = weight], augment
    active_ls10_im: mlogit active_ls10_im i.active_noun_im i.noactive_im ori_cohab_birth_exact1 mlthw_edu
                     blthw_edu CENSUS_12 msa12 BDATE_Y_1997 agedis18new agedis18_sqnew agedis18_cubicnew
                     bioandstep1 singlemom1 singledad1 foster hhstruother1 incquar_1 incquar_2 incquar_3
                     incquar_4 hhinc_missing gpa23 gpa335 gpaabove35 gpamissing enrolled2 [pweight = weight],
                     augment
    active_mt10_im: mlogit active_mt10_im i.active_ls10_im i.active_noun_im i.noactive_im
                     ori_cohab_birth_exact1 mlthw_edu blthw_edu CENSUS_12 msa12 BDATE_Y_1997 agedis18new
                     agedis18_sqnew agedis18_cubicnew bioandstep1 singlemom1 singledad1 foster hhstruother1
                     incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing gpa23 gpa335 gpaabove35 gpamissing
                     enrolled2 [pweight = weight], augment

Performing chained iterations ...

Multivariate imputation                     Imputations =       10
Chained equations                                 added =       10
Imputed: m=1 through m=10                       updated =        0

Initialization: monotone                     Iterations =        0
                                                burn-in =        0

       noactive_im: multinomial logistic regression
    active_noun_im: augmented multinomial logistic regression
    active_ls10_im: augmented multinomial logistic regression
    active_mt10_im: augmented multinomial logistic regression

------------------------------------------------------------------
                   |               Observations per m             
                   |----------------------------------------------
          Variable |   Complete   Incomplete   Imputed |     Total
-------------------+-----------------------------------+----------
       noactive_im |     364338        73983     73983 |    438321
    active_noun_im |     364338        73983     73983 |    438321
    active_ls10_im |     364338        73983     73983 |    438321
    active_mt10_im |     364338        73983     73983 |    438321
------------------------------------------------------------------
(Complete + Incomplete = Total; Imputed is the minimum across m
 of the number of filled-in observations.)

 *********************
mi estimate, post: mlogit ori_cohab_birth_exact1  i.mlthw_edu agedis18new ///
c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 bioandstep1 singlemom1 singledad1 foster hhstruother1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin enrolled2 active_noun_im active_ls10_im active_mt10_im  if  diff2==1 [pweight = weight]  , rrr cluster(ID) 

outreg2 using mn18bim_cohab_d_onevar_w.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

mimrgns , dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_imp1_onevar_w
outreg2 using impuave_cohabـonevar_w.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

**
mi estimate, post: mlogit ori_cohab_birth_exact1  ib0.blthw_edu agedis18new ///
c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ib0.blthw_edu#c.agedis18new ///
ib0.blthw_edu#c.agedis18new#c.agedis18new ib0.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 bioandstep1 singlemom1 singledad1 foster hhstruother1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin enrolled2 active_noun_im active_ls10_im active_mt10_im  if  diff2==1, rrr cluster(ID) 
outreg2 using mn18bim_birth_d_onevar_w.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

mimrgns , dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post 
estimates save ave18_imp2_onrvar_w
outreg2 using impuave_birth_onevar_w.xls, excel dec(6) cttop (mnl1)  stat (coef se) append
***********************
mi estimate, post: mlogit ori_cohab_birth_exact1  i.mlthw_edu agedis22new ///
c.agedis22new#c.agedis22new c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
bioandstep1 singlemom1 singledad1 foster hhstruother1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin active_noun_im active_ls10_im active_mt10_im enrolled2   if  diff2==1  , rrr cluster(ID) 

outreg2 using mn22bim_cohab_d_onrvar_w.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

mimrgns , dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_imp1_onrvar_w
outreg2 using impuave_cohab_onrvar_w.xls, excel dec(6) cttop (mnl1)  stat (coef se) append


*******
mi estimate, post: mlogit ori_cohab_birth_exact1  ib0.blthw_edu agedis22new c.agedis22new#c.agedis22new c.agedis22new#c.agedis22new#c.agedis22new ///
ib0.blthw_edu#c.agedis22new  ib0.blthw_edu#c.agedis22new#c.agedis22new ///
ib0.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
bioandstep1 singlemom1 singledad1 foster hhstruother1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin active_noun_im active_ls10_im active_mt10_im  enrolled2 if  diff2==1  , rrr cluster(ID)

outreg2 using mn22bim_birth_d_onrvar_w.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

mimrgns , dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_imp2_onrvar_w
outreg2 using impuave_birth_onrvar_w.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

********************coefplot

*
. estimates use  ave18_11sg9
. estimates store  ave18_11sg9

. estimates use  ave18_21sg9
. estimates store  ave18_21sg9

. estimates use  ave18_31sg9
. estimates store  ave18_31sg9

. estimates use  ave18_41sg9
. estimates store  ave18_41sg9

. estimates use   ave18_51sg9
. estimates store   ave18_51sg9

. estimates use   ave18_imp1
. estimates store   ave18_imp1

. estimates use   ave18_imp1_onevar
. estimates store   ave18_imp1_onevar

coefplot (ave18_11sg9, label(1:Baseline))(ave18_21sg9, label(2:+HH structure)) ///
(ave18_31sg9, label(3:+HH inc)) (ave18_41sg9, label(4:+HS GPA)) (ave18_51sg9, label(5:+School Enrollment))  (ave18_imp1, label(6:+Sexually Active)) (ave18_imp1_onevar, label(7:+combined Sexually var)),keep(*.mlthw_edu)  vertical ///
recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) ///
coeflabel(1.mlthw_edu ="White HS" 2.mlthw_edu ="WHite BA+" 3.mlthw_edu ="Black <HS" ///
4.mlthw_edu = "Black HS" 5.mlthw_edu ="Black BA+")  ytitle("monthly probability")


*birth combined 18 
. estimates use  ave18_12bsg9
. estimates store  ave18_12bsg9

. estimates use  ave18_22bsg9
. estimates store  ave18_22bsg9

. estimates use  ave18_32bsg9
. estimates store  ave18_32bsg9

. estimates use  ave18_42bsg9
. estimates store  ave18_42bsg9

. estimates use  ave18_52bsg9
. estimates store  ave18_52bsg9

. estimates use  ave18_imp2
. estimates store  ave18_imp2

. estimates use  ave18_imp2_onrvar
. estimates store  ave18_imp2_onrvar


coefplot (ave18_12bsg9, label(1:Baseline)) (ave18_22bsg9, label(2:+HH Structure)) ///
(ave18_32bsg9, label(3:+HH Inc)) (ave18_42bsg9, label(4:+HS GPA)) ///
(ave18_52bsg9, label(5:+School Enrollment))( ave18_imp2, label(6:+Times of unprotected sex)) ///
(ave18_imp2_onrvar, label(7:+combined Sexually active var)), ///
keep(*.blthw_edu)  vertical recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) citop  ///
coeflabel(1.blthw_edu ="Black HS" 2.blthw_edu ="Black BA+" 3.blthw_edu ="White <HS" ///
4.blthw_edu = "White HS" 5.blthw_edu ="White BA+", labsize(small)) ytitle("monthly probability")
*
***cohab 18 vs 22
. estimates use  ave18_11sg9
. estimates store  ave18_11sg9

. estimates use  ave18_21sg9
. estimates store  ave18_21sg9

. estimates use  ave18_31sg9
. estimates store  ave18_31sg9

. estimates use  ave18_41sg9
. estimates store  ave18_41sg9

. estimates use  ave18_51sg9
. estimates store  ave18_51sg9

. estimates use   ave18_imp1_onevar
. estimates store   ave18_imp1_onevar

*
estimates use  ave22_11sg9
. estimates store  ave22_11sg9

. estimates use  ave22_21sg9
. estimates store  ave22_21sg9

. estimates use  ave22_31sg9
. estimates store  ave22_31sg9

. estimates use  ave22_41sg9
. estimates store  ave22_41sg9

. estimates use   ave22_51sg9
. estimates store   ave22_51sg9

. estimates use   ave22_imp1_onrvar
. estimates store   ave22_imp1_onrvar

coefplot (ave18_11sg9, label(1:Baseline)) (ave18_21sg9, label(2:+HH Structure)) ///
(ave18_31sg9, label(3:+HH Inc)) (ave18_41sg9, label(4:+HS GPA)) ///
(ave18_51sg9, label(5:+School Enrollment first)) ///
(ave18_imp1_onevar, label(7:+Sex/Contraception)), ///
bylabel(At Age 18)||(ave22_11sg9, label(1:Baseline)) (ave22_21sg9, label(2:+HH Structure)) ///
(ave22_31sg9, label(3:+HH Inc)) (ave22_41sg9, label(4:+HS GPA)) (ave22_51sg9, label(5:+School Enrollment)) /// 
(ave22_imp1_onrvar, label(7:+Sex/Contraception)), bylabel(At Age 22)|| ,keep(*.mlthw_edu) ///
vertical recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) ///
coeflabel(1.mlthw_edu ="White HS" 2.mlthw_edu ="WHite BA+" 3.mlthw_edu ="Black <HS" ///
4.mlthw_edu = "Black HS" 5.mlthw_edu ="Black BA+", labsize(small)) ytitle("monthly probability")



*birth combined 18 vs 22
. estimates use  ave18_12bsg9
. estimates store  ave18_12bsg9

. estimates use  ave18_22bsg9
. estimates store  ave18_22bsg9

. estimates use  ave18_32bsg9
. estimates store  ave18_32bsg9

. estimates use  ave18_42bsg9
. estimates store  ave18_42bsg9

. estimates use  ave18_52bsg9
. estimates store  ave18_52bsg9

. estimates use  ave18_imp2_onrvar
. estimates store  ave18_imp2_onrvar

*
estimates use  ave22_12sg9
. estimates store  ave22_12sg9

. estimates use  ave22_22sg9
. estimates store  ave22_22sg9

. estimates use  ave22_32sg9
. estimates store  ave22_32sg9

. estimates use  ave22_42sg9
. estimates store  ave22_42sg9

. estimates use  ave22_52sg9
. estimates store  ave22_52sg9

. estimates use  ave22_imp2_onrvar
. estimates store  ave22_imp2_onrvar


coefplot (ave18_12bsg9, label(1:Baseline)) (ave18_22bsg9, label(2:+HH Structure)) ///
(ave18_32bsg9, label(3:+HH Inc)) (ave18_42bsg9, label(4:+HS GPA)) ///
(ave18_52bsg9, label(5:+School Enrollment)) ///
(ave18_imp2_onrvar, label(7:+Sex/Contraception)), ///
bylabel(At Age 18)|| (ave22_12sg9, label(1:Baseline)) (ave22_22sg9, label(2:+HH Structure)) ///
(ave22_32sg9, label(3:+HH Inc)) (ave22_42sg9, label(4:+HS GPA)) (ave22_52sg9, label(5: +School Enrollment)) ///
(ave22_imp2_onrvar, label(7:+Sex/Contraception)), bylabel(At Age 22)|| ,keep(*.blthw_edu)  vertical ///
recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) citop  ///
coeflabel(1.blthw_edu ="Black HS" 2.blthw_edu ="Black BA+" 3.blthw_edu ="White <HS" ///
4.blthw_edu = "White HS" 5.blthw_edu ="White BA+", labsize(small)) ytitle("monthly probability")

*combine weighted and unweighted coefplots***
***combine coefplots
. estimates use  ave18_11sg9
. estimates store  ave18_11sg9

. estimates use  ave18_21sg9
. estimates store  ave18_21sg9

. estimates use  ave18_31sg9
. estimates store  ave18_31sg9

. estimates use  ave18_41sg9
. estimates store  ave18_41sg9

. estimates use  ave18_51sg9
. estimates store  ave18_51sg9

. estimates use  ave18_imp1_onevar
. estimates store  ave18_imp1_onevar

*
. estimates use  ave18_11sg9w
. estimates store  ave18_11sg9w

. estimates use  ave18_21sg9w
. estimates store  ave18_21sg9w

. estimates use  ave18_31sg9w
. estimates store  ave18_31sg9w

. estimates use  ave18_41sg9w
. estimates store  ave18_41sg9w

. estimates use  ave18_51sg9w
. estimates store  ave18_51sg9w

. estimates use  ave18_imp1_onevar_w
. estimates store  ave18_imp1_onevar_w

coefplot (ave18_11sg9, label(1:Baseline)) (ave18_21sg9, label(2:+HH Structure)) ///
(ave18_31sg9, label(3:+HH Inc)) (ave18_41sg9, label(4:+HS GPA)) ///
(ave18_51sg9, label(5:+School Enrollment first)) (ave18_imp1_onevar, label(6:+Sex/Contraception)), ///
bylabel(At Age 18, unweighted)||(ave18_11sg9w, label(1:Baseline)) (ave18_21sg9w, label(2:+HH Structure)) ///
(ave18_31sg9w, label(3:+HH Inc)) (ave18_41sg9w, label(4:+HS GPA)) ///
(ave18_51sg9w, label(5:+School Enrollment first)) (ave18_imp1_onevar_w, label(6:+Sex/Contraception)), ///
bylabel(At Age 18, weighted)|| ,keep(*.mlthw_edu) ///
vertical recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) ///
coeflabel(1.mlthw_edu ="White HS" 2.mlthw_edu ="White BA+" 3.mlthw_edu ="Black <HS" ///
4.mlthw_edu = "Black HS" 5.mlthw_edu ="Black BA+", labsize(small)) ytitle("monthly probability")

*
estimates use  ave22_11sg9
. estimates store  ave22_11sg9

. estimates use  ave22_21sg9
. estimates store  ave22_21sg9

. estimates use  ave22_31sg9
. estimates store  ave22_31sg9

. estimates use  ave22_41sg9
. estimates store  ave22_41sg9

. estimates use   ave22_51sg9
. estimates store   ave22_51sg9

. estimates use   ave22_imp1_onrvar
. estimates store   ave22_imp1_onrvar

*
estimates use  ave22_11sg9w
. estimates store  ave22_11sg9w

. estimates use  ave22_21sg9w
. estimates store  ave22_21sg9w

. estimates use  ave22_31sg9w
. estimates store  ave22_31sg9w

. estimates use  ave22_41sg9w
. estimates store  ave22_41sg9w

. estimates use   ave22_51sg9w
. estimates store   ave22_51sg9w

. estimates use  ave22_imp1_onrvar_w
. estimates store  ave22_imp1_onrvar_w


coefplot (ave22_11sg9, label(1:Baseline)) (ave22_21sg9, label(2:+HH Structure)) ///
(ave22_31sg9, label(3:+HH Inc)) (ave22_41sg9, label(4:+HS GPA)) (ave22_51sg9, label(5:+School Enrollment)) /// 
(ave22_imp1_onrvar, label(6:+Sex/Contraception)), bylabel(At Age 22, unweighted)||(ave22_11sg9w, label(1:Baseline)) (ave22_21sg9w, label(2:+HH Structure)) ///
(ave22_31sg9w, label(3:+HH Inc)) (ave22_41sg9w, label(4:+HS GPA)) (ave22_51sg9w, label(5:+School Enrollment)) /// 
(ave22_imp1_onrvar_w, label(6:+Sex/Contraception)), bylabel(At Age 22, weighted)|| ,keep(*.mlthw_edu) ///
vertical recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) ///
coeflabel(1.mlthw_edu ="White HS" 2.mlthw_edu ="White BA+" 3.mlthw_edu ="Black <HS" ///
4.mlthw_edu = "Black HS" 5.mlthw_edu ="Black BA+", labsize(small)) ytitle("monthly probability")
*

*birth combined 
. estimates use  ave18_12bsg9
. estimates store  ave18_12bsg9

. estimates use  ave18_22bsg9
. estimates store  ave18_22bsg9

. estimates use  ave18_32bsg9
. estimates store  ave18_32bsg9

. estimates use  ave18_42bsg9
. estimates store  ave18_42bsg9

. estimates use  ave18_52bsg9
. estimates store  ave18_52bsg9

. estimates use  ave18_imp2_onrvar
. estimates store  ave18_imp2_onrvar

*
. estimates use  ave18_12bsg9w
. estimates store  ave18_12bsg9w

. estimates use  ave18_22bsg9w
. estimates store  ave18_22bsg9w

. estimates use  ave18_32bsg9w
. estimates store  ave18_32bsg9w

. estimates use  ave18_42bsg9w
. estimates store  ave18_42bsg9w

. estimates use  ave18_52bsg9w
. estimates store  ave18_52bsg9w

. estimates use  ave18_imp2_onrvar_w
. estimates store  ave18_imp2_onrvar_w

coefplot (ave18_12bsg9, label(1:Baseline)) (ave18_22bsg9, label(2:+HH Structure)) ///
(ave18_32bsg9, label(3:+HH Inc)) (ave18_42bsg9, label(4:+HS GPA)) ///
( ave18_52bsg9, label(5:+School Enrollment))(ave18_imp2_onrvar, label(6:+Sex/Contraception)), ///
bylabel(At Age 18, unweighted)|| (ave18_12bsg9w, label(1:Baseline)) (ave18_22bsg9w, label(2:+HH Structure)) ///
(ave18_32bsg9w, label(3:+HH Inc)) (ave18_42bsg9w, label(4:+HS GPA)) ///
(ave18_52bsg9w, label(5:+School Enrollment))(ave18_imp2_onrvar_w, label(6:+Sex/Contraception)), ///
bylabel(At Age 18, weighted)|| ,keep(*.blthw_edu)  vertical ///
recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) citop  ///
coeflabel(1.blthw_edu ="Black HS" 2.blthw_edu ="Black BA+" 3.blthw_edu ="White <HS" ///
4.blthw_edu = "White HS" 5.blthw_edu ="White BA+", labsize(small)) ytitle("monthly probability")



*
estimates use  ave22_12sg9
. estimates store  ave22_12sg9

. estimates use  ave22_22sg9
. estimates store  ave22_22sg9

. estimates use  ave22_32sg9
. estimates store  ave22_32sg9

. estimates use  ave22_42sg9
. estimates store  ave22_42sg9

. estimates use  ave22_52sg9
. estimates store  ave22_52sg9

. estimates use  ave22_imp2
. estimates store  ave22_imp2

*
estimates use  ave22_12sg9w
. estimates store  ave22_12sg9w

. estimates use  ave22_22sg9w
. estimates store  ave22_22sg9w

. estimates use  ave22_32sg9w
. estimates store  ave22_32sg9w

. estimates use  ave22_42sg9w
. estimates store  ave22_42sg9w

. estimates use  ave22_52sg9w
. estimates store  ave22_52sg9w

. estimates use  ave22_imp2_onrvar_w
. estimates store  ave22_imp2_onrvar_w


coefplot (ave22_12sg9, label(1:Baseline)) (ave22_22sg9, label(2:+HH Structure)) ///
(ave22_32sg9, label(3:+HH Inc)) (ave22_42sg9, label(4:+HS GPA)) (ave22_52sg9, label(5:+School Enrollment)) ///
(ave22_imp2, label(6:+Sex/Contraception)), bylabel(At Age 22, unweighted)|| (ave22_12sg9w, label(1:Baseline)) (ave22_22sg9, label(2:+HH Structure)) ///
(ave22_32sg9w, label(3:+HH Inc)) (ave22_42sg9w, label(4:+HS GPA)) (ave22_52sg9w, label(5:+School Enrollment)) ///
(ave22_imp2_onrvar_w, label(6:+Sex/Contraception)), bylabel(At Age 22, weighted)|| ,keep(*.blthw_edu)  vertical ///
recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) citop  ///
coeflabel(1.blthw_edu ="Black HS" 2.blthw_edu ="Black BA+" 3.blthw_edu ="White <HS" ///
4.blthw_edu = "White HS" 5.blthw_edu ="White BA+", labsize(small)) ytitle("monthly probability")




*
*conception 9 months, birth by year
gen eventmonth1_yr=eventmonth1
replace eventmonth1_yr=0 if orimax2==0 & contimonth==173
replace eventmonth1_yr=minmonth1 if eventmonth1_yr==. & minmonth1==contimonth

duplicates drop ID eventmonth1_yr, force
drop if eventmonth1_yr==.


tab  year orimax2 if eventmonth1_yr!=. &  mlthw_edu==0 
tab year   orimax2 if   eventmonth1_yr!=. &  mlthw_edu==1
tab year   orimax2 if   eventmonth1_yr!=. &  mlthw_edu==2


tab  year orimax2 if eventmonth1_yr!=. &  mlthw_edu==3 
tab year   orimax2 if   eventmonth1_yr!=. &  mlthw_edu==4
tab year   orimax2 if   eventmonth1_yr!=. &  mlthw_edu==5

*
egen year_yr1= cut(year), at(1994,1996,1998,2000,2002,2004,2006,2008,2010,2012,2014,2016,2018,2019)

tab year_yr1 orimax2 if eventmonth1_yr!=. &  mlthw_edu==0 
tab year_yr1   orimax2 if   eventmonth1_yr!=. &  mlthw_edu==1
tab year_yr1   orimax2 if   eventmonth1_yr!=. &  mlthw_edu==2


tab year_yr1 orimax2 if eventmonth1_yr!=. &  mlthw_edu==3 
tab year_yr1  orimax2 if   eventmonth1_yr!=. &  mlthw_edu==4
tab year_yr1  orimax2 if   eventmonth1_yr!=. &  mlthw_edu==5

***% of birth among all the births are in the recession years 
use  "/Users/mx2154/Desktop/Desktop - ADUAEI12760LPMX - 1/nlsy/for pub/birth_2019.dta"

reshape long CV_CHILD_BIRTH_MONTH_ , i(ID) string
save "/Users/mx2154/Desktop/Desktop - ADUAEI12760LPMX - 1/nlsy/for pub/birth2019_reshape.dta"

. merge m:m ID using  "/Users/mx2154/Desktop/Desktop - ADUAEI12760LPMX - 1/nlsy/for pub/birth_by_yr.dta"

gen birthinconti=( CV_CHILD_BIRTH_MONTH_ -birthday_conti)/12 if  CV_CHILD_BIRTH_MONTH_ >0 
egen birth_yr1= cut(birthinconti), at(14,16,18,20,22,24,26,28,30,32,34,36,38,39)


. 
.   rename  CV_CHILD_BIRTH_DATE_02_Y_2019 CV_CHILD_BIRTH_DATE_Y_02 // CV_CHILD_BIRTH_DATE.02~Y
.   rename  CV_CHILD_BIRTH_DATE_03_Y_2019 CV_CHILD_BIRTH_DATE_Y_03   // CV_CHILD_BIRTH_DATE.03~Y
.   rename CV_CHILD_BIRTH_DATE_04_Y_2019 CV_CHILD_BIRTH_DATE_Y_04   // CV_CHILD_BIRTH_DATE.04~Y
.   rename CV_CHILD_BIRTH_DATE_05_Y_2019 CV_CHILD_BIRTH_DATE_Y_05   // CV_CHILD_BIRTH_DATE.05~Y
.   rename CV_CHILD_BIRTH_DATE_06_Y_2019 CV_CHILD_BIRTH_DATE_Y_06  // CV_CHILD_BIRTH_DATE.06~Y
.   rename  CV_CHILD_BIRTH_DATE_07_Y_2019 CV_CHILD_BIRTH_DATE_Y_07   // CV_CHILD_BIRTH_DATE.07~Y
.   rename  CV_CHILD_BIRTH_DATE_08_Y_2019 CV_CHILD_BIRTH_DATE_Y_08 // CV_CHILD_BIRTH_DATE.08~Y
.   rename  CV_CHILD_BIRTH_DATE_09_Y_2019 CV_CHILD_BIRTH_DATE_Y_09   // CV_CHILD_BIRTH_DATE.09~Y
.   rename  CV_CHILD_BIRTH_DATE_10_Y_2019 CV_CHILD_BIRTH_DATE_Y_10   // CV_CHILD_BIRTH_DATE.10~Y
.   rename  CV_CHILD_BIRTH_DATE_11_Y_2019 CV_CHILD_BIRTH_DATE_Y_11  // CV_CHILD_BIRTH_DATE.11~Y
.   rename CV_CHILD_BIRTH_DATE_12_Y_2019 CV_CHILD_BIRTH_DATE_Y_12   // CV_CHILD_BIRTH_DATE.12~Y
.   rename  CV_CHILD_BIRTH_DATE_13_Y_2019  CV_CHILD_BIRTH_DATE_Y_13   // CV_CHILD_BIRTH_DATE.13~Y

reshape long CV_CHILD_BIRTH_DATE_Y_ , i(ID) string

egen birth_inyr= cut( CV_CHILD_BIRTH_DATE_Y_ ) if  CV_CHILD_BIRTH_DATE_Y_ >0, ///
at(1994,1996,1998,2000,2002,2004,2006,2008,2010,2012,2014,2016,2018,2020)


keep if CV_CHILD_BIRTH_DATE_Y_ >0

***all birth
tab birth_inyr  orimax2 if eventmonth1_yr!=. &  mlthw_edu==0 
tab birth_inyr   orimax2 if   eventmonth1_yr!=. &  mlthw_edu==1
tab birth_inyr  orimax2 if   eventmonth1_yr!=. &  mlthw_edu==2

tab birth_inyr  orimax2 if eventmonth1_yr!=. &  mlthw_edu==3 
tab birth_inyr  orimax2 if   eventmonth1_yr!=. &  mlthw_edu==4
tab birth_inyr  orimax2 if   eventmonth1_yr!=. &  mlthw_edu==5

*among first birhs, % are to the conception first, by mom 
use  "/Users/mx2154/Desktop/Desktop - ADUAEI12760LPMX - 1/nlsy/for pub/mar_cohab_birth_bandw_lifetable.dta"

egen birth_inyr= cut( CV_CHILD_BIRTH_DATE_Y_ ) if  CV_CHILD_BIRTH_DATE_Y_ >0, ///
at(1994,1996,1998,2000,2002,2004,2006,2008,2010,2012,2014,2016,2018,2020)

tab birth_inyr  orimax2 if  mlthw_edu==0 
tab birth_inyr  orimax2 if    mlthw_edu==1
tab birth_inyr  orimax2 if    mlthw_edu==2

tab birth_inyr  orimax2 if  mlthw_edu==3 
tab birth_inyr  orimax2 if    mlthw_edu==4
tab birth_inyr  orimax2 if    mlthw_edu==5
****

*limit to yr 2014 for the comparison of NSFG
tab birth_inyr  orimax2 if  mlthw_edu==0  & birth_inyr <=2014
tab birth_inyr  orimax2 if    mlthw_edu==1 & birth_inyr <=2014
tab birth_inyr  orimax2 if    mlthw_edu==2 & birth_inyr <=2014

tab birth_inyr  orimax2 if  mlthw_edu==3  & birth_inyr <=2014
tab birth_inyr  orimax2 if    mlthw_edu==4 & birth_inyr <=2014
tab birth_inyr  orimax2 if    mlthw_edu==5 & birth_inyr <=2014
****

bysort mlthw_edu: tab year withbiomom,m 

gen age_yr=(ageinmnth)/12
gen age_yr1=trunc(age_yr)
duplicates drop ID age_yr1, force

*check thte valid skip and missing apttern for no answering living with bio mom 
*in the yr 2000-2002

*prefer to use distance to mom (undersame household)
bysort mlthw_edu: tab age_yr1 withbiomom,m 
bysort mlthw_edu: tab age_yr1 withbiomom if year>2002, m 

bysort mlthw_edu: tab age_yr1 withbiomom if year<2003 & year>=1997, m 
bysort mlthw_edu: tab age_yr1 withbiomom if year<2000 & year>=1997, m 

***use NSFG to check the premartial birth applies to disadvantaged blacks
order id cb fmarr fbaby
gen ori_cohab_birth1=0 if cb==. & fmarr==. & fbaby==.
replace ori_cohab_birth1=1  if (cb<= fmarr )&  (cb< (fbaby-9)) & ori_cohab_birth1!=0 
replace ori_cohab_birth1=2  if (fbaby<= (fmarr+9) )&  (fbaby<= (cb+9)) & ori_cohab_birth1!=0 & ori_cohab_birth1!=1 
replace ori_cohab_birth1=3  if (fmarr<fbaby  )&  (fmarr< cb) & ori_cohab_birth1!=0 & ori_cohab_birth1!=1 & ori_cohab_birth1!=2

gen eventmonth1=cb if ori_cohab_birth1==1
replace eventmonth1=fbaby if ori_cohab_birth1==2
replace eventmonth1=fmarr if ori_cohab_birth1==3

gen event_yr1=1900 +int((eventmonth1-1)/12)
egen event_2yr1=cut(event_yr1), at(1994,1996,1998,2000,2002,2004,2006,2008,2010,2012,2014,2016,2018,2019)

. gen eventage1=event_yr1-yob


gen ori_cohab_birth=0 if cb==. & fmarr==. & fbaby==.
replace ori_cohab_birth=1  if (cb<= fmarr )&  (cb< (fbaby)) & ori_cohab_birth!=0 
replace ori_cohab_birth=2  if (fbaby<= (fmarr) )&  (fbaby<= (cb)) & ori_cohab_birth!=0 & ori_cohab_birth!=1 
replace ori_cohab_birth=3  if (fmarr<fbaby  )&  (fmarr< cb) & ori_cohab_birth!=0 & ori_cohab_birth!=1 & ori_cohab_birth!=2

gen eventmonth=cb if ori_cohab_birth==1
replace eventmonth=fbaby if ori_cohab_birth==2
replace eventmonth=fmarr if ori_cohab_birth==3

gen event_yr=1900 +int((eventmonth-1)/12)
egen event_2yr=cut(event_yr), at(1994,1996,1998,2000,2002,2004,2006,2008,2010,2012,2014,2016,2018,2019)

gen eventage=event_yr-yob

 order ori_cohab_birth ori_cohab_birth1 eventmonth eventmonth1 event_yr event_yr1 eventage eventage1

 gen mlthw_edu=0 if race==0 &  educmom==1 & hisp==0
 replace mlthw_edu=1 if race==0 & ( educmom==2| educmom==3) & hisp==0
 replace mlthw_edu=2 if race==0 &   educmom==4 & hisp==0
 replace mlthw_edu=3 if race==1 &  educmom==1 & hisp==0
 replace mlthw_edu=4 if race==1 & ( educmom==2| educmom==3)  & hisp==0
 replace mlthw_edu=5  if race==1 &  educmom==4 & hisp==0

tab ori_cohab_birth1 mlthw_edu  if     yob>=1980 & yob<=1984 
*
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==0 & yob>=1980 & yob<=1984 ,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==1 & yob>=1980 & yob<=1984,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==2 & yob>=1980 & yob<=1984,m

tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==3 & yob>=1980 & yob<=1984,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==4 & yob>=1980 & yob<=1984,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==5 & yob>=1980 & yob<=1984,m

forvalue z = 5/7 { 
	
forvalue  j = 0/5 { 
	
tab  event_yr ori_cohab_birth if    mlthw_edu==`j' & bcoh==`z'
}
}

tab ori_cohab_birth1 mlthw_edu  if     yob>=1985 & yob<=1989 
*
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==0 & yob>=1985 & yob<=1989,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==1 & yob>=1985 & yob<=1989,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==2 & yob>=1985 & yob<=1989,m

tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==3 & yob>=1985 & yob<=1989,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==4 & yob>=1985 & yob<=1989,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==5 & yob>=1985 & yob<=1989,m 

tab ori_cohab_birth1 mlthw_edu  if     yob>=1990 & yob<=1994 
*
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==0 & yob>=1990 & yob<=1994,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==1 & yob>=1990 & yob<=1994,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==2 & yob>=1990 & yob<=1994,m

tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==3 & yob>=1990 & yob<=1994,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==4 & yob>=1990 & yob<=1994,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==5 & yob>=1990 & yob<=1994,m

tab ori_cohab_birth1 mlthw_edu  if     yob>=1985 & yob<=1994 
*
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==0 & yob>=1985 & yob<=1994,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==1 & yob>=1985 & yob<=1994,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==2 & yob>=1985 & yob<=1994,m

tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==3 & yob>=1985 & yob<=1994,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==4 & yob>=1985 & yob<=1994,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==5 & yob>=1985 & yob<=1994,m

****among all the first births, % belong to conception first by mom edu 
gen fbaby_yr =1900 +int((fbaby-1)/12)

egen fbaby_2yr=cut(fbaby_yr), at(1994,1996,1998,2000,2002,2004,2006,2008,2010,2012,2014,2016,2018,2019)

*
tab fbaby_2yr ori_cohab_birth1  if  mlthw_edu==0 & yob>=1980 & yob<=1984
tab fbaby_2yr ori_cohab_birth1 if  mlthw_edu==1 & yob>=1980 & yob<=1984
tab fbaby_2yr ori_cohab_birth1  if mlthw_edu==2 & yob>=1980 & yob<=1984

tab fbaby_2yr ori_cohab_birth1 if  mlthw_edu==3 & yob>=1980 & yob<=1984
tab fbaby_2yr ori_cohab_birth1 if  mlthw_edu==4 & yob>=1980 & yob<=1984
tab fbaby_2yr ori_cohab_birth1 if  mlthw_edu==5 & yob>=1980 & yob<=1984

*
tab fbaby_2yr ori_cohab_birth1  if  mlthw_edu==0 & yob>=1985 & yob<=1989
tab fbaby_2yr ori_cohab_birth1 if  mlthw_edu==1 & yob>=1985 & yob<=1989
tab fbaby_2yr ori_cohab_birth1  if mlthw_edu==2 & yob>=1985 & yob<=1989

tab fbaby_2yr ori_cohab_birth1 if  mlthw_edu==3 & yob>=1985 & yob<=1989
tab fbaby_2yr ori_cohab_birth1 if  mlthw_edu==4 & yob>=1985 & yob<=1989
tab fbaby_2yr ori_cohab_birth1 if  mlthw_edu==5 & yob>=1985 & yob<=1989

***use NSFG by age
order id cb fmarr fbaby
gen ori_cohab_birth1=0 if cb==. & fmarr==. & fbaby==.
replace ori_cohab_birth1=1  if (cb<= fmarr )&  (cb< (fbaby-9)) & ori_cohab_birth1!=0 
replace ori_cohab_birth1=2  if (fbaby<= (fmarr+9) )&  (fbaby<= (cb+9)) & ori_cohab_birth1!=0 & ori_cohab_birth1!=1 
replace ori_cohab_birth1=3  if (fmarr<fbaby  )&  (fmarr< cb) & ori_cohab_birth1!=0 & ori_cohab_birth1!=1 & ori_cohab_birth1!=2

gen eventmonth1=cb if ori_cohab_birth1==1
replace eventmonth1=fbaby if ori_cohab_birth1==2
replace eventmonth1=fmarr if ori_cohab_birth1==3

gen event_age=((eventmonth1-cmbirth-1)/12)
gen event_age1=int((eventmonth1-cmbirth-1)/12)
gen event_age1_new=event_age1 if event_age1>13
egen eventage_2yr1=cut(event_age1), at(1994,1996,1998,2000,2002,2004,2006,2008,2010,2012,2014,2016,2018,2019)

. gen eventage1=event_yr1-yob


gen ori_cohab_birth=0 if cb==. & fmarr==. & fbaby==.
replace ori_cohab_birth=1  if (cb<= fmarr )&  (cb< (fbaby)) & ori_cohab_birth!=0 
replace ori_cohab_birth=2  if (fbaby<= (fmarr) )&  (fbaby<= (cb)) & ori_cohab_birth!=0 & ori_cohab_birth!=1 
replace ori_cohab_birth=3  if (fmarr<fbaby  )&  (fmarr< cb) & ori_cohab_birth!=0 & ori_cohab_birth!=1 & ori_cohab_birth!=2

gen eventmonth=cb if ori_cohab_birth==1
replace eventmonth=fbaby if ori_cohab_birth==2
replace eventmonth=fmarr if ori_cohab_birth==3

gen event_yr=1900 +int((eventmonth-1)/12)
egen event_2yr=cut(event_yr), at(1994,1996,1998,2000,2002,2004,2006,2008,2010,2012,2014,2016,2018,2019)

gen eventage=event_yr-yob

 order ori_cohab_birth ori_cohab_birth1 eventmonth eventmonth1 event_yr event_yr1 eventage eventage1

 gen mlthw_edu=0 if race==0 &  educmom==1 & hisp==0
 replace mlthw_edu=1 if race==0 & ( educmom==2| educmom==3) & hisp==0
 replace mlthw_edu=2 if race==0 &   educmom==4 & hisp==0
 replace mlthw_edu=3 if race==1 &  educmom==1 & hisp==0
 replace mlthw_edu=4 if race==1 & ( educmom==2| educmom==3)  & hisp==0
 replace mlthw_edu=5  if race==1 &  educmom==4 & hisp==0

tab ori_cohab_birth1 mlthw_edu  if     yob>=1980 & yob<=1984 
*
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==0 & yob>=1980 & yob<=1984 ,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==1 & yob>=1980 & yob<=1984,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==2 & yob>=1980 & yob<=1984,m

tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==3 & yob>=1980 & yob<=1984,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==4 & yob>=1980 & yob<=1984,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==5 & yob>=1980 & yob<=1984,m

forvalue z = 5/7 { 
	
forvalue  j = 0/5 { 
	
tab  event_yr ori_cohab_birth if    mlthw_edu==`j' & bcoh==`z'
}
}

tab ori_cohab_birth1 mlthw_edu  if     yob>=1985 & yob<=1989 
*
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==0 & yob>=1985 & yob<=1989,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==1 & yob>=1985 & yob<=1989,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==2 & yob>=1985 & yob<=1989,m

tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==3 & yob>=1985 & yob<=1989,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==4 & yob>=1985 & yob<=1989,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==5 & yob>=1985 & yob<=1989,m 

tab ori_cohab_birth1 mlthw_edu  if     yob>=1990 & yob<=1994 
*
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==0 & yob>=1990 & yob<=1994,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==1 & yob>=1990 & yob<=1994,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==2 & yob>=1990 & yob<=1994,m

tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==3 & yob>=1990 & yob<=1994,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==4 & yob>=1990 & yob<=1994,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==5 & yob>=1990 & yob<=1994,m

tab ori_cohab_birth1 mlthw_edu  if     yob>=1985 & yob<=1994 
*
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==0 & yob>=1985 & yob<=1994,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==1 & yob>=1985 & yob<=1994,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==2 & yob>=1985 & yob<=1994,m

tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==3 & yob>=1985 & yob<=1994,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==4 & yob>=1985 & yob<=1994,m
tab  event_2yr1 ori_cohab_birth1 if    mlthw_edu==5 & yob>=1985 & yob<=1994,m

****among all the first births, % belong to conception first by mom edu 
gen fbaby_yr =1900 +int((fbaby-1)/12)

egen fbaby_2yr=cut(fbaby_yr), at(1994,1996,1998,2000,2002,2004,2006,2008,2010,2012,2014,2016,2018,2019)

*
tab fbaby_2yr ori_cohab_birth1  if  mlthw_edu==0 & yob>=1980 & yob<=1984
tab fbaby_2yr ori_cohab_birth1 if  mlthw_edu==1 & yob>=1980 & yob<=1984
tab fbaby_2yr ori_cohab_birth1  if mlthw_edu==2 & yob>=1980 & yob<=1984

tab fbaby_2yr ori_cohab_birth1 if  mlthw_edu==3 & yob>=1980 & yob<=1984
tab fbaby_2yr ori_cohab_birth1 if  mlthw_edu==4 & yob>=1980 & yob<=1984
tab fbaby_2yr ori_cohab_birth1 if  mlthw_edu==5 & yob>=1980 & yob<=1984

*
tab fbaby_2yr ori_cohab_birth1  if  mlthw_edu==0 & yob>=1985 & yob<=1989
tab fbaby_2yr ori_cohab_birth1 if  mlthw_edu==1 & yob>=1985 & yob<=1989
tab fbaby_2yr ori_cohab_birth1  if mlthw_edu==2 & yob>=1985 & yob<=1989

tab fbaby_2yr ori_cohab_birth1 if  mlthw_edu==3 & yob>=1985 & yob<=1989
tab fbaby_2yr ori_cohab_birth1 if  mlthw_edu==4 & yob>=1985 & yob<=1989
tab fbaby_2yr ori_cohab_birth1 if  mlthw_edu==5 & yob>=1985 & yob<=1989

***shortgun
tab ori_cohab_birth1 ori_cohab_birth if yob>=1980 & yob<=1984,m
tab ori_cohab_birth1 ori_cohab_birth if yob>=1985 & yob<=1989,m



/*average marginal effects，(AMEs) 。

The AME approximates the average difference in the monthly probability of the outcome (e.g., cohab first) associated with
a one-unit difference in the covariate of interest (e.g.,  W mom HS vs W mom ls HS), where the average is taken over the sample.*/ 
*
*
mlogit ori_cohab_birth i.mlthw_edu  ///
agedis18new c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new  ib0.mlthw_edu#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates store ave18_71n
outreg2 using mnlsep18ave1.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

mlogit ori_cohab_birth i.mlthw_edu  ///
agedis18new c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new  ib0.mlthw_edu#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new  if  diff2==1  , rrr cluster(ID)


margins, dydx(*) predict(outcome(2)) at(agedis18new =0)  vsquish post
estimates store ave18_72n
outreg2 using mnlsep18ave1.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append


*
mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997  agedis18new c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new  ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates store ave18_11n
outreg2 using mnlsep18ave1.xls, excel dec(4) cttop (mnl1)  stat (coef se tstat) append
*
mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997  agedis18new c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new  ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates store ave18_12n
outreg2 using mnlsep18ave1.xls, excel dec(4) cttop (mnl1)  stat (coef se tstat) append

*
mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis18new c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new  ib0.mlthw_edu#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new i.bioandstep i.singlemom /// i.singledad i.nobiopar i.hhstruother if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates store ave18_21n
outreg2 using mnlsep18ave1.xls, excel dec(4) cttop (mnl1)  stat (coef se tstat) append

*
mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis18new c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new  ib0.mlthw_edu#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new i.bioandstep i.singlemom ///
i.singledad i.nobiopar i.hhstruotherif  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0)  vsquish post
estimates store ave18_22n
outreg2 using mnlsep18ave1.xls, excel dec(4) cttop (mnl1)  stat (coef se tstat) append



*
mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis18new c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new  ib0.mlthw_edu#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother  if  diff2==1  , rrr cluster(ID)


margins, dydx(*) predict(outcome(1))  at(agedis18new =0) vsquish post 
estimates store ave18_31n
outreg2 using mnlsep18ave1.xls, excel dec(4) cttop (mnl1)  stat (coef se tstat) append

mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis18new c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new  ib0.mlthw_edu#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother  if  diff2==1  , rrr cluster(ID)


margins, dydx(*) predict(outcome(2)) at(agedis18new =0)  vsquish post
estimates store ave18_32n
outreg2 using mnlsep18ave1.xls, excel dec(4) cttop (mnl1)  stat (coef se tstat) append

*
mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis18new c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new  ib0.mlthw_edu#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother i.gpa if  diff2==1  , rrr cluster(ID)


margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates store ave18_41n
outreg2 using mnlsep18ave1.xls, excel dec(4) cttop (mnl1)  stat (coef se tstat) append

mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis18new c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new  ib0.mlthw_edu#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother i.gpa if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates store ave18_42n
outreg2 using mnlsep18ave1.xls, excel dec(4) cttop (mnl1)  stat (coef se tstat) append


**addd enrollment status 
mlogit ori_cohab_birth i.mlthw_edu ///
i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis18new c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new  ib0.mlthw_edu#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother i.gpa i.enrolled2 ///
i.enrolled2#c.agedis18new i.enrolled2#c.agedis18new#c.agedis18new ///
i.enrolled2#c.agedis18new#c.agedis18new#c.agedis18new if  diff2==1  , rrr cluster(ID)


margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates store ave18_51n1
outreg2 using mnlsep18ave.xls, excel dec(4) cttop (mnl1)  stat (coef se tstat) append

mlogit ori_cohab_birth i.mlthw_edu ///
i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis18new c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new  ib0.mlthw_edu#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother i.gpa i.enrolled2 ///
i.enrolled2#c.agedis18new i.enrolled2#c.agedis18new#c.agedis18new ///
i.enrolled2#c.agedis18new#c.agedis18new#c.agedis18new if  diff2==1  , rrr cluster(ID)


margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates store ave18_52n1
outreg2 using mnlsep18ave1.xls, excel dec(4) cttop (mnl1)  stat (coef se tstat) append




save "/Users/mx2154/Desktop/Desktop - ADUAEI12760LPMX - 1/nlsy/mar_cohab_month-drop14.dta", replace

/*MEMs are very similar to AMEs but
instead of averaging over the sample, they  x covariate values at their means and calculate
cohort effects for people characterized by these values. MEMs are very similar to AMEs but
instead of averaging over the sample, they  x covariate values at their means and calculate
cohort effects for people characterized by these values.*/


margins, dydx(mlthw_edu)  at(agedis18new = (-4(1) 17))  predict(outcome(1)) vsquish  grand post
estimates store mem18_110
outreg2 using 18mem.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append


margins mlthw_edu, atmeans at(agedis18new = (-4(1) 22)) predict(outcome(1))    vsquish  grand post
estimates store mem18_110
outreg2 using 18mem.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append


margins mlthw_edu, at(agedis18new = (-4(1) 22))   vsquish  grand post

***

*
mlogit ori_cohab_birth i.mlthw_edu  ///
agedis18new c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new  ib0.mlthw_edu#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates store ave18_71n
outreg2 using mnlsep18ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append


 predict p18_17 , outcome(1)
 predict p18_27 , outcome(2)
 predict p18_37 , outcome(3)
 
 
putexcel set est18allnocontrol.xls, replace

local abc C D E F G H 
local race  mlthw_edu_0 mlthw_edu_1 mlthw_edu_2 mlthw_edu_3 mlthw_edu_4 mlthw_edu_5


local inde p18_17 p18_27 p18_37
local j=4


foreach x in p18_17 p18_27 p18_37 {
forval y=-5/22 {


putexcel A`j'=("`x'") 

forvalue i=1/6 {

local var: word `i' of `race'
local n: word `i' of `abc'


qui sum `x' if `var'==1 & agedis18new==`y'

local mean: dis  `r(mean)' , %9.2f
local sd: dis `r(sd)', %9.2f
local N: dis `r(N)', %9.2f

putexcel B`j'=("`y'") `n'`j'=("`mean'") 

}  

local j=`j'+1

}
}
**



*
mlogit ori_cohab_birth i.mlthw_edu  ///
agedis18new c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new  ib0.mlthw_edu#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post 
estimates store ave18_72n
outreg2 using mnlsep18ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append


*******center 22
mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis22new  c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new  ///
ib0.mlthw_edu#c.agedis22new  ib0.mlthw_edu#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new = 0 )  vsquish post 
estimates store ave22_11n            
outreg2 using mnlsep22ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append
 
mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis22new  c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new  ///
ib0.mlthw_edu#c.agedis22new  ib0.mlthw_edu#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2))  at(agedis22new = 0 ) vsquish post
estimates store ave22_12n
outreg2 using mnlsep22ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

margins, dydx(mlthw_edu)  at(agedis22new = 0 )  predict(outcome(1)) vsquish  grand post
estimates store mem18_111
outreg2 using 22mem.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append


margins mlthw_edu, at(agedis22new = (-10(1) 15))  vsquish  grand post
outreg2 using 22mem.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

   
margins, dydx(mlthw_edu)   at(agedis22new = 0 ) predict(outcome(1)) vsquish  grand post
estimates store mem22_110
outreg2 using 22mem.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append



**
mlogit ori_cohab_birth i.mlthw_edu ///
i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 agedis22new ///
c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new  c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new  ///
ib0.mlthw_edu#c.agedis22new  ib0.mlthw_edu#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother i.gpa i.enrolled2 ///
i.enrolled2#c.agedis22new  i.enrolled2#c.agedis22new#c.agedis22new ///
i.enrolled2#c.agedis22new#c.agedis22new#c.agedis22new if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new = 0 )  vsquish post 
estimates store ave22_21n
outreg2 using mnlsep22ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append


mlogit ori_cohab_birth i.mlthw_edu ///
i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 agedis22new ///
c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new  c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new  ///
ib0.mlthw_edu#c.agedis22new  ib0.mlthw_edu#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother i.gpa i.enrolled2 ///
i.enrolled2#c.agedis22new  i.enrolled2#c.agedis22new#c.agedis22new ///
i.enrolled2#c.agedis22new#c.agedis22new#c.agedis22new if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new = 0 )  vsquish post
estimates store ave22_22n
outreg2 using mnlsep22ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

*
mlogit ori_cohab_birth i.mlthw_edu ///
i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 agedis22new ///
c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new  c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new  ///
ib0.mlthw_edu#c.agedis22new  ib0.mlthw_edu#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new i.hhincqun ///
if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new = 0 )  vsquish post 
estimates store ave22_31n
outreg2 using mnlsep22ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

mlogit ori_cohab_birth i.mlthw_edu ///
i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 agedis22new ///
c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new  c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new  ///
ib0.mlthw_edu#c.agedis22new  ib0.mlthw_edu#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new i.hhincqun ///
if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new = 0 )  vsquish post
estimates store ave22_32n
outreg2 using mnlsep22ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

*
mlogit ori_cohab_birth i.mlthw_edu ///
i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 agedis22new ///
c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new  c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new  ///
ib0.mlthw_edu#c.agedis22new  ib0.mlthw_edu#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new  ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new = 0 )  vsquish post 
estimates store ave22_41n
outreg2 using mnlsep22ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

mlogit ori_cohab_birth i.mlthw_edu ///
i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 agedis22new ///
c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new  c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new  ///
ib0.mlthw_edu#c.agedis22new  ib0.mlthw_edu#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new = 0 )  vsquish post
estimates store ave22_42n
outreg2 using mnlsep22ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

**
mlogit ori_cohab_birth i.mlthw_edu ///
i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 agedis22new ///
c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new  c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new  ///
ib0.mlthw_edu#c.agedis22new  ib0.mlthw_edu#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new = 0 )  vsquish post 
estimates store ave22_51n
outreg2 using mnlsep22ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

mlogit ori_cohab_birth i.mlthw_edu ///
i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 agedis22new ///
c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new  c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new  ///
ib0.mlthw_edu#c.agedis22new  ib0.mlthw_edu#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new  i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new = 0 )  vsquish post
estimates store ave22_52n
outreg2 using mnlsep22ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

***
mlogit ori_cohab_birth i.mlthw_edu ///
i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 agedis22new ///
c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new  c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new  ///
ib0.mlthw_edu#c.agedis22new  ib0.mlthw_edu#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother i.gpa ///
if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new = 0 )  vsquish post 
estimates store ave22_61n
outreg2 using mnlsep22ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

mlogit ori_cohab_birth i.mlthw_edu ///
i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 agedis22new ///
c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new  c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new  ///
ib0.mlthw_edu#c.agedis22new  ib0.mlthw_edu#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new  i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother i.gpa ///
if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new = 0 )  vsquish post
estimates store ave22_62n
outreg2 using mnlsep22ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

******

mlogit ori_cohab_birth i.mlthw_edu ///
agedis22new  c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new  ///
ib0.mlthw_edu#c.agedis22new  ib0.mlthw_edu#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new = 0 )  vsquish post 
estimates store ave22_71n            
outreg2 using mnlsep22ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append
 
mlogit ori_cohab_birth i.mlthw_edu ///
agedis22new  c.agedis22new#c.agedis22new   c.agedis22new#c.agedis22new#c.agedis22new  ///
ib0.mlthw_edu#c.agedis22new  ib0.mlthw_edu#c.agedis22new#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2))  at(agedis22new = 0 ) vsquish post
estimates store ave22_72n
outreg2 using mnlsep22ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append



******center at age 26
mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis26new c.agedis26new#c.agedis26new c.agedis26new#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new ib0.mlthw_edu#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new#c.agedis26new#c.agedis26new  if  diff2==1  , rrr cluster(ID)

margins, dydx(mlthw_edu)  at(agedis26new = (-15(1) 13))  predict(outcome(1)) vsquish  grand post
estimates store mem26_110
outreg2 using 26mem.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append


margins, dydx(*) predict(outcome(1)) at(agedis26new = 0) vsquish post 
estimates store ave26_11n
outreg2 using mnlsep26ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis26new c.agedis26new#c.agedis26new c.agedis26new#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new ib0.mlthw_edu#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new#c.agedis26new#c.agedis26new  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis26new = 0) vsquish post
estimates store ave26_12n
outreg2 using mnlsep26ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

  
 *
mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis26new c.agedis26new#c.agedis26new c.agedis26new#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new ib0.mlthw_edu#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new#c.agedis26new#c.agedis26new  i.hhincqun ///
if  diff2==1   , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis26new = 0) vsquish post  
estimates store ave26_21n
outreg2 using mnlsep26ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis26new c.agedis26new#c.agedis26new c.agedis26new#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new ib0.mlthw_edu#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new#c.agedis26new#c.agedis26new  i.hhincqun ///
if  diff2==1   , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis26new = 0) vsquish post 
estimates store ave26_22n
outreg2 using mnlsep26ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append



*
mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis26new c.agedis26new#c.agedis26new c.agedis26new#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new ib0.mlthw_edu#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new#c.agedis26new#c.agedis26new  i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother if  diff2==1    , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis26new = 0) vsquish post 
estimates store ave26_31n
outreg2 using mnlsep26ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

*
mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis26new c.agedis26new#c.agedis26new c.agedis26new#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new ib0.mlthw_edu#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new#c.agedis26new#c.agedis26new  i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother if  diff2==1    , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis26new = 0)  vsquish post
estimates store ave26_32n
outreg2 using mnlsep26ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

*
mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis26new c.agedis26new#c.agedis26new c.agedis26new#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new ib0.mlthw_edu#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new#c.agedis26new#c.agedis26new  i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother i.gpa if  diff2==1    , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis26new = 0) vsquish post 
estimates store ave26_41n
outreg2 using mnlsep26ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis26new c.agedis26new#c.agedis26new c.agedis26new#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new ib0.mlthw_edu#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new#c.agedis26new#c.agedis26new  i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother i.gpa if  diff2==1    , rrr cluster(ID)


margins, dydx(*) predict(outcome(2)) at(agedis26new = 0) vsquish post
estimates store ave26_42n
outreg2 using mnlsep26ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append


*
mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis26new c.agedis26new#c.agedis26new c.agedis26new#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new ib0.mlthw_edu#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new#c.agedis26new#c.agedis26new  i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother i.gpa i.enrolled2 ///
i.enrolled2#c.agedis26new i.enrolled2#c.agedis26new#c.agedis26new ///
i.enrolled2#c.agedis26new#c.agedis26new#c.agedis26new if  diff2==1    , rrr cluster(ID)


margins, dydx(*) predict(outcome(1)) at(agedis26new = 0) vsquish post 
estimates store ave26_51n
outreg2 using mnlsep26ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis26new c.agedis26new#c.agedis26new c.agedis26new#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new ib0.mlthw_edu#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new#c.agedis26new#c.agedis26new  i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother i.gpa i.enrolled2 ///
i.enrolled2#c.agedis26new i.enrolled2#c.agedis26new#c.agedis26new ///
i.enrolled2#c.agedis26new#c.agedis26new#c.agedis26new if  diff2==1    , rrr cluster(ID)


margins, dydx(*) predict(outcome(2)) at(agedis26new = 0) vsquish post
estimates store ave26_52n
outreg2 using mnlsep26ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append


*
mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis26new c.agedis26new#c.agedis26new c.agedis26new#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new ib0.mlthw_edu#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new#c.agedis26new#c.agedis26new ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother if  diff2==1    , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis26new = 0) vsquish post 
estimates store ave26_61n
outreg2 using mnlsep26ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

*
mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis26new c.agedis26new#c.agedis26new c.agedis26new#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new ib0.mlthw_edu#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new#c.agedis26new#c.agedis26new ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother if  diff2==1    , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis26new = 0)  vsquish post
estimates store ave26_62n
outreg2 using mnlsep26ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append
*****


mlogit ori_cohab_birth i.mlthw_edu  ///
agedis26new c.agedis26new#c.agedis26new c.agedis26new#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new ib0.mlthw_edu#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new#c.agedis26new#c.agedis26new  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis26new = 0) vsquish post 
estimates store ave26_71n
outreg2 using mnlsep26ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append



mlogit ori_cohab_birth i.mlthw_edu ///
agedis26new c.agedis26new#c.agedis26new c.agedis26new#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new ib0.mlthw_edu#c.agedis26new#c.agedis26new ///
ib0.mlthw_edu#c.agedis26new#c.agedis26new#c.agedis26new  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis26new = 0) vsquish post 
estimates store ave26_72n
outreg2 using mnlsep26ave.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

  




/*
If we wanted to see how the probability of having diabetes for average individuals differs across age groups, we could do something like this
margins mlthw_edu ,at(age=(203040506070))atmeans vsquish



margins dydx(mlthw_edu  agedis18new), atmeans grand post
estimates store mem18_110
outreg2 using mnlsep18mem.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append


margins, dydx(mlthw_edu ) at(agedis18new = (-4(1) 22))  predict(outcome(1)) vsquish post
estimates store m18_110
outreg2 using mnlsep18mem.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

margins, at(agedis18new = (-4(1) 22)) atmeans predict(outcome(1)) vsquish post
estimates store m18_110
outreg2 using mnlsep18mem.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append


margins, at(agedis18new = (-4(1) 22)) predict(outcome(2)) vsquish post
estimates store m18_12
outreg2 using mnlsep18mem.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append


margins, at(agedis18new = (-4(1) 22) at means  predict(outcome(3)) vsquish post 
estimates store m18_13
outreg2 using mnlsep18mem.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append



/*
The -predict- command calculates a separate predicted value for every observation in the data set for which all of the predictor variables are non-missing.

The -margins- command calculates average predicted values for groups of observations, the groups being defined by levels of some variable(s) in the model.

So, for example, if you have a data set where each observation is a person, -predict- calculates predicted values for every person. -margins- calculates average predictions for subgroups such as all men, or all people over age 65, or all Buddhists, etc.*/

*/

**black mom= less than high as the reference

 gen blthw_edu=0 if black==1 & biomomedu==1
 replace blthw_edu=1 if black==1 & biomomedu==2
 replace blthw_edu=2 if black==1 &  biomomedu==3
 replace blthw_edu=3 if black==0 & biomomedu==1
 replace blthw_edu=4 if black==0 & biomomedu==2
 replace blthw_edu=5  if black==0 & biomomedu==3

 

*
mlogit ori_cohab_birth i.blthw_edu  i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997  agedis18new agedis18_sqnew agedis18_cubicnew ///
ib0.blthw_edu#c.agedis18new  ib0.blthw_edu#c.agedis18new#c.agedis18new ///
ib0.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new if  diff2==1 , rrr cluster(ID)

 predict p18_11b , outcome(1)
 predict p18_21b , outcome(2)
 predict p18_31b , outcome(3)
 
 ***
 forvalues i=0/5{
	
gen blthw_edu_`i'=0
replace blthw_edu_`i'=1 if blthw_edu==`i'
}

 
 
 
 
putexcel set est18b.xls, replace

local abc C D E F G H 
local race  blthw_edu_0 blthw_edu_1 blthw_edu_2 blthw_edu_3 blthw_edu_4 blthw_edu_5


local inde p18_11b p18_21b p18_31b
local j=4


foreach x in p18_11b p18_21b p18_31b {
forval y=-5/22 {


putexcel A`j'=("`x'") 

forvalue i=1/6 {

local var: word `i' of `race'
local n: word `i' of `abc'


qui sum `x' if `var'==1 & agedis18new==`y'

local mean: dis  `r(mean)' , %9.2f
local sd: dis `r(sd)', %9.2f
local N: dis `r(N)', %9.2f

putexcel B`j'=("`y'") `n'`j'=("`mean'") 

}  

local j=`j'+1

}
}
**

mlogit ori_cohab_birth i.blthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis18new c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
ib0.blthw_edu#c.agedis18new  ib0.blthw_edu#c.agedis18new#c.agedis18new ///
ib0.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new  i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)


margins, dydx(blthw_edu ) at(agedis18new = (-4(1) 22))  predict(outcome(1)) vsquish post
estimates store m18_410b
outreg2 using mnlsep18memb.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append


mlogit ori_cohab_birth i.blthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997 ///
agedis18new c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
ib0.blthw_edu#c.agedis18new  ib0.blthw_edu#c.agedis18new#c.agedis18new ///
ib0.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new  i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)


margins, dydx(blthw_edu ) at(agedis18new = (-4(1) 22))  predict(outcome(2)) vsquish post
estimates store m18_420b
outreg2 using mnlsep18memb.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append



outreg2 using mnlsep18month11.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*

margins mlthw_edu ,at(age=(203040506070))atmeans vsquish

margins mlthw_edu ,at(agedis18new = (-4(1) 22)) atmeans vsquish

at(-9,-8,-7,-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)


margins, dydx(mlthw_edu)  at(agedis18new = (-4(1) 17))  predict(outcome(1)) vsquish  grand post
estimates store mem18_110
outreg2 using 18mem.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append


margins mlthw_edu, atmeans at(agedis18new = (-4(1) 22)) predict(outcome(1))    vsquish  grand post
estimates store mem18_110
outreg2 using 18mem.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append


margins mlthw_edu, at(agedis18new = (-4(1) 22))   vsquish  grand post


***means difference tests
 
forvalues i=0/5 { 

gen mlthw_edunew_`i'=1 if mlthw_edu==`i' 
replace  mlthw_edunew_`i'=0 if mlthw_edunew_`i'==. & mlthw_edu==0
}
*


forvalues i=1/5{
	
gen incqun_`i'=0
replace incqun_`i'=1 if hhincqun==`i'
}

gen gpalessthan2=1 if gpa==1
replace gpalessthan2=0 if gpalessthan2==.

	
  gen mlthw_edu=0 if black1==0 & biomomedunew1==2
 replace mlthw_edu=1 if black1==0 & (biomomedunew1==3|biomomedunew1==4)
 replace mlthw_edu=2 if black1==0 &  biomomedunew1==5
 replace mlthw_edu=3 if black1==1 & biomomedunew1==2
 replace mlthw_edu=4 if black1==1 & (biomomedunew1==3|biomomedunew1==4)
 replace mlthw_edu=5  if black1==1 & biomomedunew1==5
 
 
use "/Users/mx2154/Desktop/Desktop - ADUAEI12760LPMX - 1/nlsy/desc_1997.dta"
duplicates drop ID, force



****try some margin and test 

*
mlogit ori_cohab_birth i.mlthw_edu i.CENSUS_12 urban12_1 urban12_unknown i.BDATE_Y_1997  agedis18new c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new  ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new if  diff2==1  , rrr cluster(ID)

margins  mlthw_edu, at( agedis18new=(-4(1)11)) vsquish  post


foreach x in  mlthw_edu_0 mlthw_edu_1 mlthw_edu_2 mlthw_edu_3 mlthw_edu_4 mlthw_edu_5{
replace `x'=. if  mlthw_edu==.
}


**cpefplot
forvalues i=1/4 { 

gen census_`i'=0 
replace census_`i'=1 if CENSUS_12 ==`i' 
}
*
forvalues i=1981/1984 { 

gen birthyr_`i'=0 
replace birthyr_`i'=1 if BDATE_Y_1997  ==`i' 
}
*



*18 cohab
mlogit ori_cohab_birth i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep18cohabjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post
estimates save ave18_11
outreg2 using mnlsep18avejuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep18cohabjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post
estimates save ave18_21
outreg2 using mnlsep18avejuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep18cohabjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post
estimates save ave18_31
outreg2 using mnlsep18avejuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin   if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep18cohabjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post
estimates save ave18_41
outreg2 using mnlsep18avejuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

**addd enrollment status 
mlogit ori_cohab_birth i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep18cohabjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post
estimates save ave18_51
outreg2 using mnlsep18avejuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 i.new299   if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep18cohabjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post
estimates save ave18_61
outreg2 using mnlsep18avejuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append


***black reg coef plot
*
mlogit ori_cohab_birth i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep18birthjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_12
outreg2 using mnlsep18avebirthjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep18birthjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_22
outreg2 using mnlsep18avebirthjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep18birthjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_32
outreg2 using mnlsep18avebirthjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin   if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep18birthjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_42
outreg2 using mnlsep18avebirthjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

**addd enrollment status 
mlogit ori_cohab_birth i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2   if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep18birthjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_52
outreg2 using mnlsep18avebirthjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 unprotect_10 unprotect_50 ///
unprotect_above50 unprotect_miss  if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep18birthjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_62
outreg2 using mnlsep18avebirthjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 unprotect_10 unprotect_above10 ///
unprotect_miss  if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep18birthjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_72
outreg2 using mnlsep18avebirthjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append



*****at age 22
*
mlogit ori_cohab_birth i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep22cohabjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post
estimates save ave22_11
outreg2 using mnlsep22avecohabjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep22cohabjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post
estimates save ave22_21
outreg2 using mnlsep22avecohabjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep22cohabjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post
estimates save ave22_31
outreg2 using mnlsep22avecohabjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5  gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep22cohabjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post
estimates save ave22_41
outreg2 using mnlsep22avecohabjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep22cohabjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post
estimates save ave22_51
outreg2 using mnlsep22avecohabjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 i.new299   if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep22cohabjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post
estimates save ave22_61
outreg2 using mnlsep22avecohabjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append


***black as the ref
*
mlogit ori_cohab_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ////
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep22birthjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post
estimates save ave22_12
outreg2 using mnlsep22ave1bjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ////
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep22birthjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_22
outreg2 using mnlsep22ave1bjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep22birthjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(2))  at(agedis22new =0) vsquish post 
estimates save ave22_32
outreg2 using mnlsep22ave1bjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep22birthjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_42
outreg2 using mnlsep22ave1bjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep22birthjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post
estimates save ave22_52
outreg2 using mnlsep22ave1bjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 unprotect_10 unprotect_50 ///
unprotect_above50 unprotect_miss  if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep22birthjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post
estimates save ave22_62
outreg2 using mnlsep22ave1bjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 unprotect_10 unprotect_above10 ///
unprotect_miss  if  diff2==1  , rrr cluster(ID)
outreg2 using mnlsep22birthjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) nor2 ///
addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post
estimates save ave22_72
outreg2 using mnlsep22ave1bjuly.xls, excel dec(6) cttop (mnl1)  stat (coef se) append




************
 
************try the shotgun*************************************************
mlogit ori_cohab_birth_exact i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post
estimates save ave18_11sg
outreg2 using mnlsep18ave1sg.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_21sg
outreg2 using mnlsep18ave1sg.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append


*
mlogit ori_cohab_birth_exact i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1))  at(agedis18new =0) vsquish post 
estimates save ave18_31sg
outreg2 using mnlsep18ave1sg.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append

*
mlogit ori_cohab_birth_exact i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5  gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_41sg
outreg2 using mnlsep18ave1sg.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append


** 
mlogit ori_cohab_birth_exact i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  if  diff2==1  , rrr cluster(ID)


margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_51sg
outreg2 using mnlsep18ave1sg.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append
*


***********

***black reg coef plot
*
mlogit ori_cohab_birth_exact i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_12bsg
outreg2 using mnlsep18ave1bsg.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post 
estimates save ave18_22bsg
outreg2 using mnlsep18ave1bsg.xls, excel dec(6) cttop (mnl1)  stat (coef se) append


*
mlogit ori_cohab_birth_exact i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0)  vsquish post
estimates save ave18_32bsg
outreg2 using mnlsep18ave1bsg.xls, excel dec(6) cttop (mnl1)  stat (coef se) append


*
mlogit ori_cohab_birth_exact i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_42bsg
outreg2 using mnlsep18ave1bsg.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append


*
mlogit ori_cohab_birth_exact i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_52bsg
outreg2 using mnlsep18ave1bsg.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append


*****at age 22
*
mlogit ori_cohab_birth_exact i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post
estimates save ave22_11sg
outreg2 using mnlsep22ave1sg.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_21sg
outreg2 using mnlsep22ave1sg.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1))  at(agedis22new =0) vsquish post 
estimates save ave22_31sg
outreg2 using mnlsep22ave1sg.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5  gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_41sg
outreg2 using mnlsep22ave1sg.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  if  diff2==1  , rrr cluster(ID)


margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post
estimates save ave22_51sg
outreg2 using mnlsep22ave1sg.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append


***black as the ref
*
mlogit ori_cohab_birth_exact i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ////
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post
estimates save ave22_12sg
outreg2 using mnlsep22ave1bsg.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ////
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_22sg
outreg2 using mnlsep22ave1b.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append

*
mlogit ori_cohab_birth_exact i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2))  at(agedis22new =0) vsquish post 
estimates save ave22_32sg
outreg2 using mnlsep22ave1bsg.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append

*
mlogit ori_cohab_birth_exact i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5  gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_42sg
outreg2 using mnlsep22ave1bsg.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  if  diff2==1  , rrr cluster(ID)


margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post
estimates save ave22_52sg
outreg2 using mnlsep22ave1bsg.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append



****get some marriage mkt situation
use "/Users/mx2154/Desktop/Desktop - ADUAEI12760LPMX - 1/nlsy/97.dta"

tab  


**************************inter act with all the base/exog variables 
mlogit ori_cohab_birth i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 i.census_1#c.agedis18new ///
i.census_1#c.agedis18new#c.agedis18new i.census_1#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2#c.agedis18new ///
i.census_2#c.agedis18new#c.agedis18new i.census_2#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_3#c.agedis18new ///
i.census_3#c.agedis18new#c.agedis18new i.census_3#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_4#c.agedis18new ///
i.census_4#c.agedis18new#c.agedis18new i.census_4#c.agedis18new#c.agedis18new#c.agedis18new ///
i.urban12_1 i.urban12_unknown ///
i.urban12_1#c.agedis18new ///
i.urban12_1#c.agedis18new#c.agedis18new i.urban12_1#c.agedis18new#c.agedis18new#c.agedis18new ///
i.urban12_un#c.agedis18new ///
i.urban12_un#c.agedis18new#c.agedis18new i.urban12_un#c.agedis18new#c.agedis18new#c.agedis18new ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.birthyr_1981#c.agedis18new ///
i.birthyr_1981#c.agedis18new#c.agedis18new i.birthyr_1981#c.agedis18new#c.agedis18new#c.agedis18new ///
i.birthyr_1982#c.agedis18new ///
i.birthyr_1982#c.agedis18new#c.agedis18new i.birthyr_1982#c.agedis18new#c.agedis18new#c.agedis18new ///
i.birthyr_1983#c.agedis18new ///
i.birthyr_1983#c.agedis18new#c.agedis18new i.birthyr_1983#c.agedis18new#c.agedis18new#c.agedis18new ///
i.birthyr_1984#c.agedis18new ///
i.birthyr_1984#c.agedis18new#c.agedis18new i.birthyr_1984#c.agedis18new#c.agedis18new#c.agedis18new ///
if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post
estimates save ave18_11act
outreg2 using mnlsep18act.xls, excel dec(6) cttop (mnl1)  stat (coef se) append


local exog i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 i.census_1#c.agedis18new ///
i.census_1#c.agedis18new#c.agedis18new i.census_1#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2#c.agedis18new ///
i.census_2#c.agedis18new#c.agedis18new i.census_2#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_3#c.agedis18new ///
i.census_3#c.agedis18new#c.agedis18new i.census_3#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_4#c.agedis18new ///
i.census_4#c.agedis18new#c.agedis18new i.census_4#c.agedis18new#c.agedis18new#c.agedis18new ///
i.urban12_1 i.urban12_unknown ///
i.urban12_1#c.agedis18new ///
i.urban12_1#c.agedis18new#c.agedis18new i.urban12_1#c.agedis18new#c.agedis18new#c.agedis18new ///
i.urban12_un#c.agedis18new ///
i.urban12_un#c.agedis18new#c.agedis18new i.urban12_un#c.agedis18new#c.agedis18new#c.agedis18new ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.birthyr_1981#c.agedis18new ///
i.birthyr_1981#c.agedis18new#c.agedis18new i.birthyr_1981#c.agedis18new#c.agedis18new#c.agedis18new ///
i.birthyr_1982#c.agedis18new ///
i.birthyr_1982#c.agedis18new#c.agedis18new i.birthyr_1982#c.agedis18new#c.agedis18new#c.agedis18new ///
i.birthyr_1983#c.agedis18new ///
i.birthyr_1983#c.agedis18new#c.agedis18new i.birthyr_1983#c.agedis18new#c.agedis18new#c.agedis18new ///
i.birthyr_1984#c.agedis18new ///
i.birthyr_1984#c.agedis18new#c.agedis18new i.birthyr_1984#c.agedis18new#c.agedis18new#c.agedis18new



mlogit ori_cohab_birth `exog' i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_21act
outreg2 using mnlsep18act.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append

*
mlogit ori_cohab_birth `exog' i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother  i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1))  at(agedis18new =0) vsquish post 
estimates save ave18_31act
outreg2 using mnlsep18act.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append


*
mlogit ori_cohab_birth `exog' i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5  gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_41act
outreg2 using mnlsep18act.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append


*
mlogit ori_cohab_birth `exog'  i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  if  diff2==1  , rrr cluster(ID)


margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_51act
outreg2 using mnlsep18act.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append
*

*********************************************************************************

local exogb i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 i.census_1#c.agedis18new ///
i.census_1#c.agedis18new#c.agedis18new i.census_1#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2#c.agedis18new ///
i.census_2#c.agedis18new#c.agedis18new i.census_2#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_3#c.agedis18new ///
i.census_3#c.agedis18new#c.agedis18new i.census_3#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_4#c.agedis18new ///
i.census_4#c.agedis18new#c.agedis18new i.census_4#c.agedis18new#c.agedis18new#c.agedis18new ///
i.urban12_1 i.urban12_unknown ///
i.urban12_1#c.agedis18new ///
i.urban12_1#c.agedis18new#c.agedis18new i.urban12_1#c.agedis18new#c.agedis18new#c.agedis18new ///
i.urban12_un#c.agedis18new ///
i.urban12_un#c.agedis18new#c.agedis18new i.urban12_un#c.agedis18new#c.agedis18new#c.agedis18new ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.birthyr_1981#c.agedis18new ///
i.birthyr_1981#c.agedis18new#c.agedis18new i.birthyr_1981#c.agedis18new#c.agedis18new#c.agedis18new ///
i.birthyr_1982#c.agedis18new ///
i.birthyr_1982#c.agedis18new#c.agedis18new i.birthyr_1982#c.agedis18new#c.agedis18new#c.agedis18new ///
i.birthyr_1983#c.agedis18new ///
i.birthyr_1983#c.agedis18new#c.agedis18new i.birthyr_1983#c.agedis18new#c.agedis18new#c.agedis18new ///
i.birthyr_1984#c.agedis18new ///
i.birthyr_1984#c.agedis18new#c.agedis18new i.birthyr_1984#c.agedis18new#c.agedis18new#c.agedis18new


*
mlogit ori_cohab_birth `exogb' if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_b12act
outreg2 using mnlsep18avebact.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) append

**
mlogit ori_cohab_birth `exogb' i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post 
estimates save ave18_b22act
outreg2 using mnlsep18avebact.xls, excel dec(6) cttop (mnl1)  stat (coef tstat) append

***
mlogit ori_cohab_birth `exogb' i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0)  vsquish post
estimates save ave18_b32act
outreg2 using mnlsep18avebact.xls, excel dec(6) cttop (mnl1)  stat (coef tstat) append

****
mlogit ori_cohab_birth `exogb' i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother gpa23 gpa335 gpaabove35 gpamissin  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0)  vsquish post
estimates save ave18_b42act
outreg2 using mnlsep18avebact.xls, excel dec(6) cttop (mnl1)  stat (coef tstat) append

*****
mlogit ori_cohab_birth `exogb'  i.hhincqun ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother gpa23 gpa335 gpaabove35 gpamissin enrolled2  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0)  vsquish post
estimates save ave18_b52act
outreg2 using mnlsep18avebact.xls, excel dec(6) cttop (mnl1)  stat (coef tstat) append

*******
estimates use  ave18_b32act
. estimates store  ave18_b32act

. estimates use  ave18_b22act
. estimates store  ave18_b22act

. estimates use  ave18_b12act
. estimates store  ave18_b12act

*****at age 22*****************************************************************


local exog22 i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 i.census_1#c.agedis22new ///
i.census_1#c.agedis22new#c.agedis22new i.census_1#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2#c.agedis22new ///
i.census_2#c.agedis22new#c.agedis22new i.census_2#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_3#c.agedis22new ///
i.census_3#c.agedis22new#c.agedis22new i.census_3#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_4#c.agedis22new ///
i.census_4#c.agedis22new#c.agedis22new i.census_4#c.agedis22new#c.agedis22new#c.agedis22new ///
i.urban12_1 i.urban12_unknown ///
i.urban12_1#c.agedis22new ///
i.urban12_1#c.agedis22new#c.agedis22new i.urban12_1#c.agedis22new#c.agedis22new#c.agedis22new ///
i.urban12_un#c.agedis22new ///
i.urban12_un#c.agedis22new#c.agedis22new i.urban12_un#c.agedis22new#c.agedis22new#c.agedis22new ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.birthyr_1981#c.agedis22new ///
i.birthyr_1981#c.agedis22new#c.agedis22new i.birthyr_1981#c.agedis22new#c.agedis22new#c.agedis22new ///
i.birthyr_1982#c.agedis22new ///
i.birthyr_1982#c.agedis22new#c.agedis22new i.birthyr_1982#c.agedis22new#c.agedis22new#c.agedis22new ///
i.birthyr_1983#c.agedis22new ///
i.birthyr_1983#c.agedis22new#c.agedis22new i.birthyr_1983#c.agedis22new#c.agedis22new#c.agedis22new ///
i.birthyr_1984#c.agedis22new ///
i.birthyr_1984#c.agedis22new#c.agedis22new i.birthyr_1984#c.agedis22new#c.agedis22new#c.agedis22new


*
mlogit ori_cohab_birth i.mlthw_edu `exog22' if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post
estimates save ave22_11act
outreg2 using mnlsep22ave1act.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth `exog22' i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_21act
outreg2 using mnlsep22ave1act.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append

*
mlogit ori_cohab_birth `exog22' i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1))  at(agedis22new =0) vsquish post 
estimates save ave22_31act
outreg2 using mnlsep22ave1act.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append

*
mlogit ori_cohab_birth `exog22' i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5  gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_41act
outreg2 using mnlsep22ave1act.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append

*
mlogit ori_cohab_birth `exog22' i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  if  diff2==1  , rrr cluster(ID)


margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post
estimates save ave22_51act
outreg2 using mnlsep22ave1act.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append

***************************************************************************
local exog22b i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 i.census_1#c.agedis22new ///
i.census_1#c.agedis22new#c.agedis22new i.census_1#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2#c.agedis22new ///
i.census_2#c.agedis22new#c.agedis22new i.census_2#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_3#c.agedis22new ///
i.census_3#c.agedis22new#c.agedis22new i.census_3#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_4#c.agedis22new ///
i.census_4#c.agedis22new#c.agedis22new i.census_4#c.agedis22new#c.agedis22new#c.agedis22new ///
i.urban12_1 i.urban12_unknown ///
i.urban12_1#c.agedis22new ///
i.urban12_1#c.agedis22new#c.agedis22new i.urban12_1#c.agedis22new#c.agedis22new#c.agedis22new ///
i.urban12_un#c.agedis22new ///
i.urban12_un#c.agedis22new#c.agedis22new i.urban12_un#c.agedis22new#c.agedis22new#c.agedis22new ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.birthyr_1981#c.agedis22new ///
i.birthyr_1981#c.agedis22new#c.agedis22new i.birthyr_1981#c.agedis22new#c.agedis22new#c.agedis22new ///
i.birthyr_1982#c.agedis22new ///
i.birthyr_1982#c.agedis22new#c.agedis22new i.birthyr_1982#c.agedis22new#c.agedis22new#c.agedis22new ///
i.birthyr_1983#c.agedis22new ///
i.birthyr_1983#c.agedis22new#c.agedis22new i.birthyr_1983#c.agedis22new#c.agedis22new#c.agedis22new ///
i.birthyr_1984#c.agedis22new ///
i.birthyr_1984#c.agedis22new#c.agedis22new i.birthyr_1984#c.agedis22new#c.agedis22new#c.agedis22new



mlogit ori_cohab_birth  `exog22b' if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post
estimates save ave22_12bact
outreg2 using mnlsep22ave1bact.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth `exog22b' i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_22bact
outreg2 using mnlsep22ave1bact.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append


mlogit ori_cohab_birth `exog22b' i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2))  at(agedis22new =0) vsquish post 
estimates save ave22_32bact
outreg2 using mnlsep22ave1bact.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append

*/
mlogit ori_cohab_birth `exog22b' i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5  gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_42bact
outreg2 using mnlsep22ave1bact.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append

*
mlogit ori_cohab_birth `exog22b' i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post
estimates save ave22_52bact
outreg2 using mnlsep22ave1bact.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append



****************************************************try the shot gun
************try the shotgun*************************************************

local exog i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 i.census_1#c.agedis18new ///
i.census_1#c.agedis18new#c.agedis18new i.census_1#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2#c.agedis18new ///
i.census_2#c.agedis18new#c.agedis18new i.census_2#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_3#c.agedis18new ///
i.census_3#c.agedis18new#c.agedis18new i.census_3#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_4#c.agedis18new ///
i.census_4#c.agedis18new#c.agedis18new i.census_4#c.agedis18new#c.agedis18new#c.agedis18new ///
i.urban12_1 i.urban12_unknown ///
i.urban12_1#c.agedis18new ///
i.urban12_1#c.agedis18new#c.agedis18new i.urban12_1#c.agedis18new#c.agedis18new#c.agedis18new ///
i.urban12_un#c.agedis18new ///
i.urban12_un#c.agedis18new#c.agedis18new i.urban12_un#c.agedis18new#c.agedis18new#c.agedis18new ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.birthyr_1981#c.agedis18new ///
i.birthyr_1981#c.agedis18new#c.agedis18new i.birthyr_1981#c.agedis18new#c.agedis18new#c.agedis18new ///
i.birthyr_1982#c.agedis18new ///
i.birthyr_1982#c.agedis18new#c.agedis18new i.birthyr_1982#c.agedis18new#c.agedis18new#c.agedis18new ///
i.birthyr_1983#c.agedis18new ///
i.birthyr_1983#c.agedis18new#c.agedis18new i.birthyr_1983#c.agedis18new#c.agedis18new#c.agedis18new ///
i.birthyr_1984#c.agedis18new ///
i.birthyr_1984#c.agedis18new#c.agedis18new i.birthyr_1984#c.agedis18new#c.agedis18new#c.agedis18new



mlogit ori_cohab_birth_exact1 `exog' if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post
estimates save ave18_11sgact
outreg2 using mnlsep18ave1sgact.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 `exog' i.singlemom /// 
i.singledad i.nobiopar i.hhstruother if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_21sgact
outreg2 using mnlsep18ave1sgact.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append


*
mlogit ori_cohab_birth_exact1 `exog'  i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother incquar_2 incquar_3 incquar_4  hhinc_missing   if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1))  at(agedis18new =0) vsquish post 
estimates save ave18_31sgact
outreg2 using mnlsep18ave1sgact.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append

*
mlogit ori_cohab_birth_exact `exog' i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5  gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_41sgact
outreg2 using mnlsep18ave1sgact.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append


mlogit ori_cohab_birth_exact `exog' i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  if  diff2==1  , rrr cluster(ID)


margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_51sgact
outreg2 using mnlsep18ave1sgact.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append
*


***********


local exogb i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 i.census_1#c.agedis18new ///
i.census_1#c.agedis18new#c.agedis18new i.census_1#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2#c.agedis18new ///
i.census_2#c.agedis18new#c.agedis18new i.census_2#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_3#c.agedis18new ///
i.census_3#c.agedis18new#c.agedis18new i.census_3#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_4#c.agedis18new ///
i.census_4#c.agedis18new#c.agedis18new i.census_4#c.agedis18new#c.agedis18new#c.agedis18new ///
i.urban12_1 i.urban12_unknown ///
i.urban12_1#c.agedis18new ///
i.urban12_1#c.agedis18new#c.agedis18new i.urban12_1#c.agedis18new#c.agedis18new#c.agedis18new ///
i.urban12_un#c.agedis18new ///
i.urban12_un#c.agedis18new#c.agedis18new i.urban12_un#c.agedis18new#c.agedis18new#c.agedis18new ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.birthyr_1981#c.agedis18new ///
i.birthyr_1981#c.agedis18new#c.agedis18new i.birthyr_1981#c.agedis18new#c.agedis18new#c.agedis18new ///
i.birthyr_1982#c.agedis18new ///
i.birthyr_1982#c.agedis18new#c.agedis18new i.birthyr_1982#c.agedis18new#c.agedis18new#c.agedis18new ///
i.birthyr_1983#c.agedis18new ///
i.birthyr_1983#c.agedis18new#c.agedis18new i.birthyr_1983#c.agedis18new#c.agedis18new#c.agedis18new ///
i.birthyr_1984#c.agedis18new ///
i.birthyr_1984#c.agedis18new#c.agedis18new i.birthyr_1984#c.agedis18new#c.agedis18new#c.agedis18new

*
mlogit ori_cohab_birth_exact `exogb' if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_12bsgact
outreg2 using mnlsep18ave1bsgact.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact `exogb' i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post 
estimates save ave18_22bsgact
outreg2 using mnlsep18ave1bsgact.xls, excel dec(6) cttop (mnl1)  stat (coef se) append


*
mlogit ori_cohab_birth_exact `exogb' i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0)  vsquish post
estimates save ave18_32bsgact
outreg2 using mnlsep18ave1bsgact.xls, excel dec(6) cttop (mnl1)  stat (coef se) append



mlogit ori_cohab_birth_exact `exogb' i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_42bsgact
outreg2 using mnlsep18ave1bsgact.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append


*
mlogit ori_cohab_birth_exact `exogb' i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_52bsgact
outreg2 using mnlsep18ave1bsgact.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append


*****at age 22*****************************************************************


local exog22 i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 i.census_1#c.agedis22new ///
i.census_1#c.agedis22new#c.agedis22new i.census_1#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2#c.agedis22new ///
i.census_2#c.agedis22new#c.agedis22new i.census_2#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_3#c.agedis22new ///
i.census_3#c.agedis22new#c.agedis22new i.census_3#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_4#c.agedis22new ///
i.census_4#c.agedis22new#c.agedis22new i.census_4#c.agedis22new#c.agedis22new#c.agedis22new ///
i.urban12_1 i.urban12_unknown ///
i.urban12_1#c.agedis22new ///
i.urban12_1#c.agedis22new#c.agedis22new i.urban12_1#c.agedis22new#c.agedis22new#c.agedis22new ///
i.urban12_un#c.agedis22new ///
i.urban12_un#c.agedis22new#c.agedis22new i.urban12_un#c.agedis22new#c.agedis22new#c.agedis22new ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.birthyr_1981#c.agedis22new ///
i.birthyr_1981#c.agedis22new#c.agedis22new i.birthyr_1981#c.agedis22new#c.agedis22new#c.agedis22new ///
i.birthyr_1982#c.agedis22new ///
i.birthyr_1982#c.agedis22new#c.agedis22new i.birthyr_1982#c.agedis22new#c.agedis22new#c.agedis22new ///
i.birthyr_1983#c.agedis22new ///
i.birthyr_1983#c.agedis22new#c.agedis22new i.birthyr_1983#c.agedis22new#c.agedis22new#c.agedis22new ///
i.birthyr_1984#c.agedis22new ///
i.birthyr_1984#c.agedis22new#c.agedis22new i.birthyr_1984#c.agedis22new#c.agedis22new#c.agedis22new


mlogit ori_cohab_birth_exact `exog22' if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post
estimates save ave22_11sgact
outreg2 using mnlsep22ave1sgact.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact `exog22' i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_21sgact
outreg2 using mnlsep22ave1sgact.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact `exog22' i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1))  at(agedis22new =0) vsquish post 
estimates save ave22_31sgact
outreg2 using mnlsep22ave1sgact.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*/
mlogit ori_cohab_birth_exact `exog22' i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5  gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_41sgact
outreg2 using mnlsep22ave1sgact.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact `exog22' i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  if  diff2==1  , rrr cluster(ID)


margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post
estimates save ave22_51sgact
outreg2 using mnlsep22ave1sgact.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append


***black as the ref
local exog22b i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 i.census_1#c.agedis22new ///
i.census_1#c.agedis22new#c.agedis22new i.census_1#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2#c.agedis22new ///
i.census_2#c.agedis22new#c.agedis22new i.census_2#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_3#c.agedis22new ///
i.census_3#c.agedis22new#c.agedis22new i.census_3#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_4#c.agedis22new ///
i.census_4#c.agedis22new#c.agedis22new i.census_4#c.agedis22new#c.agedis22new#c.agedis22new ///
i.urban12_1 i.urban12_unknown ///
i.urban12_1#c.agedis22new ///
i.urban12_1#c.agedis22new#c.agedis22new i.urban12_1#c.agedis22new#c.agedis22new#c.agedis22new ///
i.urban12_un#c.agedis22new ///
i.urban12_un#c.agedis22new#c.agedis22new i.urban12_un#c.agedis22new#c.agedis22new#c.agedis22new ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.birthyr_1981#c.agedis22new ///
i.birthyr_1981#c.agedis22new#c.agedis22new i.birthyr_1981#c.agedis22new#c.agedis22new#c.agedis22new ///
i.birthyr_1982#c.agedis22new ///
i.birthyr_1982#c.agedis22new#c.agedis22new i.birthyr_1982#c.agedis22new#c.agedis22new#c.agedis22new ///
i.birthyr_1983#c.agedis22new ///
i.birthyr_1983#c.agedis22new#c.agedis22new i.birthyr_1983#c.agedis22new#c.agedis22new#c.agedis22new ///
i.birthyr_1984#c.agedis22new ///
i.birthyr_1984#c.agedis22new#c.agedis22new i.birthyr_1984#c.agedis22new#c.agedis22new#c.agedis22new

*
mlogit ori_cohab_birth_exact `exog22b' if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post
estimates save ave22_12sgact
outreg2 using mnlsep22ave1bsgact.xls, excel dec(6) cttop (mnl1)  stat (coef se) append


mlogit ori_cohab_birth_exact `exog22b'  i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_22sgact
outreg2 using mnlsep22ave1bact.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append

*
mlogit ori_cohab_birth_exact `exog22b' i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2))  at(agedis22new =0) vsquish post 
estimates save ave22_32sgact
outreg2 using mnlsep22ave1bsgact.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append


mlogit ori_cohab_birth_exact `exog22b'  i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5  gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_42sgact
outreg2 using mnlsep22ave1bsgact.xls, excel dec(6) cttop (mnl1)  stat (coef se) append


mlogit ori_cohab_birth_exact `exog22b'  i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  if  diff2==1  , rrr cluster(ID)


margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post
estimates save ave22_52sgact
outreg2 using mnlsep22ave1bsgact.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append

*****


****incarceration
****reshape
reshape long INCARC_STATUS, i(ID) string
gen year=substr(_j,1,4)
gen month=substr(_j,6,2)
tostring ID, replace force
gen mergeidmonth=ID+year+month

merge 1:1 mergeidmonth using "/Users/mx2154/Desktop/Desktop - ADUAEI12760LPMX - 1/nlsy/incarinmonth.dta",force

*
reshape long CV_INTERVIEW_DATE_Y, i(ID) string
gen year=substr(_j,2,4)
tostring ID, replace force
gen mergeidyr=ID+year

merge 1:1 mergeidmonth using "/Users/mx2154/Desktop/Desktop - ADUAEI12760LPMX - 1/nlsy/incarinmonth.dta",force

**
*mom edu

replace  biomomedu=2 if  CV_HGC_BIO_MOM_1997>0 & CV_HGC_BIO_MOM_1997<=11 & SEX_1997==1
replace  biomomedu=3 if  CV_HGC_BIO_MOM_1997>11 & CV_HGC_BIO_MOM_1997<=15 & SEX_1997==1
replace  biomomedu=4 if  CV_HGC_BIO_MOM_1997>15 & CV_HGC_BIO_MOM_1997<90 & SEX_1997==1

gen  biomomedunew=2 if  CV_HGC_BIO_MOM_1997>0 & CV_HGC_BIO_MOM_1997<=11
replace  biomomedunew=3 if  CV_HGC_BIO_MOM_1997==12
replace  biomomedunew=4 if  CV_HGC_BIO_MOM_1997>12 & CV_HGC_BIO_MOM_1997<=15
replace  biomomedunew=5 if  CV_HGC_BIO_MOM_1997>15 & CV_HGC_BIO_MOM_1997<90


******mnl
  gen mlthw_edu=0 if  RACE_ETHNICITY_1997==4 & biomomedunew==2
 replace mlthw_edu=1 if  RACE_ETHNICITY_1997==4 & (biomomedunew==3|biomomedunew==4)
 replace mlthw_edu=2 if RACE_ETHNICITY_1997==4 &  biomomedunew==5
 replace mlthw_edu=3 if  RACE_ETHNICITY_1997==1 & biomomedunew==2
 replace mlthw_edu=4 if RACE_ETHNICITY_1997==1 & (biomomedunew==3|biomomedunew==4)
 replace mlthw_edu=5  if RACE_ETHNICITY_1997==1 & biomomedunew==5
 
 

gen mlthw_edu=0 if RACE_ETHNICITY_1997==4 & biomomedunew==2 & SEX_1997==1
replace mlthw_edu=1 if RACE_ETHNICITY_1997==4 & (biomomedunew==3|biomomedunew==4) & SEX_1997==1
replace mlthw_edu=2 if RACE_ETHNICITY_1997==4 &  biomomedunew==5 & SEX_1997==1
replace mlthw_edu=3 if RACE_ETHNICITY_1997==1 & biomomedunew==2 & SEX_1997==1
replace mlthw_edu=4 if RACE_ETHNICITY_1997==1 & (biomomedunew==3|biomomedunew==4) & SEX_1997==1
replace mlthw_edu=5  if RACE_ETHNICITY_1997==1 & biomomedunew==5 & SEX_1997==1
 
 
 tab mlthw_edu CV_INTERVIEW_DATE_Y_1997 if SEX_1997==1 ,m 
 tab mlthw_edu CV_INTERVIEW_DATE_Y_1997 if SEX_1997==2 ,m 
 
 
foreach x in CV_INTERVIEW_DATE_Y_1998  CV_INTERVIEW_DATE_Y_1999 CV_INTERVIEW_DATE_Y_2000 CV_INTERVIEW_DATE_Y_2001 CV_INTERVIEW_DATE_Y_2002 CV_INTERVIEW_DATE_Y_2003 CV_INTERVIEW_DATE_Y_2004 CV_INTERVIEW_DATE_Y_2005 CV_INTERVIEW_DATE_Y_2006 CV_INTERVIEW_DATE_Y_2007 CV_INTERVIEW_DATE_Y_2008 CV_INTERVIEW_DATE_Y_2009 CV_INTERVIEW_DATE_Y_2010 CV_INTERVIEW_DATE_Y_2011 CV_INTERVIEW_DATE_Y_2013 CV_INTERVIEW_DATE_Y_2015 CV_INTERVIEW_DATE_Y_2017 CV_INTERVIEW_DATE_Y_2019 {

tab mlthw_edu  `x' if `x'==-5 & SEX_1997==1
}*

 
foreach x in CV_INTERVIEW_DATE_Y_1998  CV_INTERVIEW_DATE_Y_1999 CV_INTERVIEW_DATE_Y_2000 CV_INTERVIEW_DATE_Y_2001 CV_INTERVIEW_DATE_Y_2002 CV_INTERVIEW_DATE_Y_2003 CV_INTERVIEW_DATE_Y_2004 CV_INTERVIEW_DATE_Y_2005 CV_INTERVIEW_DATE_Y_2006 CV_INTERVIEW_DATE_Y_2007 CV_INTERVIEW_DATE_Y_2008 CV_INTERVIEW_DATE_Y_2009 CV_INTERVIEW_DATE_Y_2010 CV_INTERVIEW_DATE_Y_2011 CV_INTERVIEW_DATE_Y_2013 CV_INTERVIEW_DATE_Y_2015 CV_INTERVIEW_DATE_Y_2017 CV_INTERVIEW_DATE_Y_2019 {

tab mlthw_edu  `x' if `x'==-5 & SEX_1997==2
}

**
 gen incar=1 if INCARC_STATUS==1
 tab year mlthw_edu if incar_yr>0,m
 **
 gen contimonth_bith=(BDATE_Y_1997-1980)*12+BDATE_M_1997
 
 destring year month, replace
 gen incar_month=(year-1980)*12+month
 
 gen age=(incar_month-contimonth_bith)/12

 tostring age, gen(age_yr) force
 gen age_yr1=substr(age_yr,1,2)
 destring age_yr1, replace
 

 tab age_yr1 mlthw_edu if incar_yr>0,m
 
 
 *****
tostring INCARC_FIRST_XRND, gen(firstincar)
gen first_incar_yr=substr(firstincar,1,4) if INCARC_FIRST_XRND>0
gen first_incar_month=substr(firstincar,5,2) if INCARC_FIRST_XRND>0
destring first_incar_yr first_incar_month, replace force

gen month_firstincar=(first_incar_yr-1980)*12+first_incar_month
gen age_firstincar=( month_firstincar-contimonth_bith)/12
 tostring age_firstincar, gen(age_firstincar1) force
 gen age_firstincar2=substr(age_firstincar1,1,2)
 destring age_firstincar2, replace
 save "/Users/mx2154/Desktop/Desktop - ADUAEI12760LPMX - 1/nlsy/incar_yr_males.dta", replace
 
 
 duplicates drop ID,force
tab age_firstincar2 mlthw_edu if age_firstincar2!=.,m
 

 ***age of first sex
 
gen firstsexyr=  YSAQ_312M_Y_2000 if  YSAQ_312M_Y_2000>0
foreach x in YSAQ_312M_Y_2001 YSAQ2_312M_Y_2002 YSAQ2_312M_Y_2003 YSAQ2_300A_Y_2002 YSAQ2_300A_Y_2003 YSAQ2_300A_Y_2004 YSAQ2_300A_Y_2005 YSAQ2_300A_Y_2006 YSAQ2_300A_Y_2007 YSAQ2_300A_Y_2008 YSAQ2_300A_Y_2009 YSAQ2_300A_Y_2010 YSAQ2_300A_Y_2011{


replace  firstsexyr= `x' if  firstsexyr==. & `x'>0
}

gen firstsexmon=YSAQ_312M_M_2000 if YSAQ_312M_M_2000>0
foreach x in YSAQ_312M_M_2000 YSAQ_312M_M_2001 YSAQ2_312M_M_2002 YSAQ2_312M_M_2003 YSAQ2_300A_M_2002 YSAQ2_300A_M_2003 YSAQ2_300A_M_2004 YSAQ2_300A_M_2005 YSAQ2_300A_M_2006 YSAQ2_300A_M_2007 YSAQ2_300A_M_2008 YSAQ2_300A_M_2009 YSAQ2_300A_M_2010 YSAQ2_300A_M_2011{
	
replace firstsexmon=`x' if firstsexmon==. &  `x' >=0
}



gen firstsexage=YSAQ_300_1997 if YSAQ_300_1997>0
foreach x in YSAQ_300_1998 YSAQ_300_1999 YSAQ_300_2000 YSAQ_300_2001 YSAQ2_300_2002 YSAQ2_300_2003 YSAQ2_300_2004 YSAQ2_300_2005 YSAQ2_300_2006 YSAQ2_300_2007 YSAQ2_300_2008 YSAQ2_300_2009 YSAQ2_300_2010 YSAQ2_300_2011 YSAQ2_300_2013 YSAQ2_300_2015{

replace firstsexage=`x' if firstsexage==. &  `x' >=0
}


*
reshape long YSAQ2_311_ YSAQ2_308M_ YSAQ2_309M_ , i(ID) string
rename _j year
tostring ID, replace force
tostring year, replace force
gen mergeidyr=ID+year



bysort ID :replace firstsexage=firstsexage[_n-1] if firstsexage==. & firstsexage[_n-1]!=.

bysort ID :replace firstsexage=firstsexage[_n+1] if firstsexage==. & firstsexage[_n+1]!=.



gen firstsex_conti=(firstsexyr-1980)*12+ firstsexmon

bysort ID :replace firstsex_conti=firstsex_conti[_n-1] if firstsex_conti==. & firstsex_conti[_n-1]!=.
bysort ID :replace firstsex_conti=firstsex_conti[_n+1] if firstsex_conti==. & firstsex_conti[_n+1]!=.


gen firstsex1=(firstsex_conti-birthday_conti)/12
replace firstsex1=firstsexage if firstsex1==.



bysort mlthw_edu : sum firstsexage,d
bysort mlthw_edu orimax : sum firstsexage,d

bysort mlthw_edu orimax2: sum firstsex1,d

bysort mlthw_edu : sum firstsex1,d



/*********************************************************************************************

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post
estimates save ave22_61
outreg2 using mnlsep22ave1.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post
estimates save ave22_71
outreg2 using mnlsep22ave1.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post
estimates save ave22_62
outreg2 using mnlsep22ave1b.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post
estimates save ave22_72
outreg2 using mnlsep22ave1b.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_61sg
outreg2 using mnlsep18ave1sg.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_71sg
outreg2 using mnlsep18ave1sg.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append
*

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post 
estimates save ave18_62bsg
outreg2 using mnlsep18ave1bsg.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post 
estimates save ave18_72bsg
outreg2 using mnlsep18ave1bsg.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_61sg
outreg2 using mnlsep22ave1sg.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post
estimates save ave22_71sg
outreg2 using mnlsep22ave1sg.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append
*

***black as the ref
margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_62sg
outreg2 using mnlsep22ave1bsg.xls, excel dec(6) cttop (mnl1)  stat (coef se) append


margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post
estimates save ave22_72sg
outreg2 using mnlsep22ave1bsg.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append
*/

*In rounds 1 and 2, data on sexual activity were obtained from respondents who were at least 14 years old; all respondents were eligible in later rounds.

*Refusal(-1)           66
*Don't Know(-2)        65

***R EVER HAVE SEXUAL INTERCOURSE?: Have you ever had sexual intercourse, that is, made love, *had sex, or gone all the way with a person of the opposite sex? (R299)
*UNIVERSE: R did not answer questions about sex at DLI

* R HAVE SEX SINCE DLI? Have you had sexual intercourse since the last interview on [date of *last interview], that is, made love, had sex, or gone all the way with a person of  the *opposite sex? (R299B)

* R HAD SEX > ONCE?: Have you had intercourse more than once? (YSAQ-303)
*UNIVERSE: R >= 14 at end of prev year; has ever had sexual intercourse

*# TIMES R HAD SEX IN LAST 12 MONTHS: About HOW MANY TIMES have you had sexual intercourse in the last 12 months? UNIVERSE: R >= 14 at end of prev year; has ever had sexual intercourse; has had sex in past year ([YSAQ-308])

*  ESTIMATED # TIMES R HAD SEX SINCE DLI?: Which of these is closest to the number of times you had sexual intercourse  since the last interview? .UNIVERSE: All except prisoners in an insecure environment; has ever had sexual intercourse; 1+ partners since DLI; DK/RF how many times had sex since DLI ([YSAQ-309])
*
reshape long YSAQ2_299_ YSAQ2_299B_ YSAQ_303_  YSAQ2_308_ YSAQ2_309_,  i(ID) string

gen hadsex_ldi=YSAQ2_299B_ if YSAQ2_299B_>=0  

replace hadsex_ldi=1 if YSAQ2_308_>0 & hadsex_ldi==. & YSAQ2_308_!=.

tab YSAQ2_309_ if YSAQ2_308_==-2 |YSAQ2_308_==-1
replace hadsex_ldi=1 if YSAQ2_309_>0 & hadsex_ldi==. & YSAQ2_309_!=.

replace hadsex_ldi=YSAQ2_299_ if year==1997 & YSAQ2_299_>=0 & hadsex_ldi==. & YSAQ2_299_!=.

replace hadsex_ldi=0 if year==1997 & YSAQ2_299_==-4 & hadsex_ldi==.

replace hadsex_ldi=YSAQ2_299_ if YSAQ2_299_>=0 & hadsex_ldi==. & YSAQ2_299_!=.

replace hadsex_ldi=0 if year==1997 & YSAQ2_299_==-4 & hadsex_ldi==.


bysort ID: replace hadsex_ldi=0 if (YSAQ2_299_==-4|YSAQ2_299_==0) & hadsex_ldi==. ///
& hadsex_ldi[_n-1]==0

replace  hadsex_ldi=0 if contimonth< firstsex_conti

gen hadsex_ldi1=.
bysort ID: replace hadsex_ldi1= hadsex_ldi[_n+1]
replace  hadsex_ldi1=0 if contimonth< firstsex_conti

****


**************using sexual relaionaship need 
mlogit ori_cohab_birth i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.hadsex_ldi  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_81n
outreg2 using mnlsep18ave1.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append

*
mlogit ori_cohab_birth i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.tacensus_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.hadsex_ldi  i.enrolled2  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_91n
outreg2 using mnlsep18ave1.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append
*



***black reg coef plot
*
mlogit ori_cohab_birth i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.hadsex_ldi  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_82b
outreg2 using mnlsep18ave1b.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append

*
mlogit ori_cohab_birth i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.hadsex_ldi  i.enrolled2  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_92b
outreg2 using mnlsep18ave1b.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append


*****at age 22
*
mlogit ori_cohab_birth i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5  gpa23 gpa335 gpaabove35 gpamissin i.hadsex_ldi if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_81
outreg2 using mnlsep22ave1.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append

*
mlogit ori_cohab_birth i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.hadsex_ldi i.enrolled2  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post
estimates save ave22_91
outreg2 using mnlsep22ave1.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append


***black as the ref
*
mlogit ori_cohab_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5  gpa23 gpa335 gpaabove35 gpamissin i.hadsex_ldi if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_82
outreg2 using mnlsep22ave1b.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append

*
mlogit ori_cohab_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.hadsex_ldi i.enrolled2  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post
estimates save ave22_92
outreg2 using mnlsep22ave1b.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append




************try the shotgun*************************************************
** 
mlogit ori_cohab_birth_exact i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.hadsex_ldi if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_81sg
outreg2 using mnlsep18ave1sg.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append

*
mlogit ori_cohab_birth_exact i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.hadsex_ldi i.enrolled2  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_91sg
outreg2 using mnlsep18ave1sg.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append
*


***********
***black reg coef plot
mlogit ori_cohab_birth_exact i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.hadsex_ldi if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_82bsg
outreg2 using mnlsep18ave1bsg.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append


*
mlogit ori_cohab_birth_exact i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.hadsex_ldi i.enrolled2  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_92bsg
outreg2 using mnlsep18ave1bsg.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append


*****at age 22
*
mlogit ori_cohab_birth_exact i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5  gpa23 gpa335 gpaabove35 gpamissin i.hadsex_ldi if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_81sg
outreg2 using mnlsep22ave1sg.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.hadsex_ldi i.enrolled2  if  diff2==1  , rrr cluster(ID)


margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post
estimates save ave22_91sg
outreg2 using mnlsep22ave1sg.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append


***black as the ref
*
mlogit ori_cohab_birth_exact i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5  gpa23 gpa335 gpaabove35 gpamissin i.hadsex_ldi if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_82sg
outreg2 using mnlsep22ave1bsg.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.hadsex_ldi i.enrolled2  if  diff2==1  , rrr cluster(ID)


margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post
estimates save ave22_92sg
outreg2 using mnlsep22ave1bsg.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append

****dating information 
*ever
forvalues i=1997/2001{
replace YSAQ2_291A_`i'=YSAQ_294A_`i' if SEX_1997==2
}

*times/number of dates
forvalues i=1997/2001{
replace YSAQ2_293_`i'=YSAQ_296_`i' if SEX_1997==2
}

*age of first date
forvalues i=1997/2001{
replace YSAQ_292_`i'=YSAQ_295_`i' if SEX_1997==2
}


*# DIFFERENT people DATED IN LAST YEAR; incomplete infor for female btw yr 1998-2001

reshape long YSAQ2_291A_ YSAQ2_293_ YSAQ_292_, i(ID) string
rename _j year
tostring ID year, replace force
gen mergeidyr=ID+year
rename YSAQ_292_ fisrstdateage


bysort ID: egen fstdateage=max(fisrstdateage) 



bysort ID :replace firstsexage=firstsexage[_n-1] if firstsexage==. & firstsexage[_n-1]!=.

bysort ID :replace firstsexage=firstsexage[_n+1] if firstsexage==. & firstsexage[_n+1]!=.

**birth control, condition on had sex DLI

*[YSAQ-310]:  # TIMES R USED BIRTH CONTROL IN LAST YEAR
*YSAQ-311]  EST TIMES R USED BIRTH CONTROL IN LAST YEAR (in %) only for the DK/Refuse (universe)* 
*so should use the 310 (times), not the estimated %*

reshape long  YSAQ2_311_, i(ID) string
rename _j year
tostring ID, replace force
gen mergeidyr=ID+year




*
putexcel set dating.xls, replace

local abc  C D  E F G H
local group  mlthw_edunew_0 mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5

local inde YSAQ2_291A_1997 YSAQ2_291A_1998 YSAQ2_291A_1999 YSAQ2_291A_2000 YSAQ2_291A_2001 YSAQ2_291A_2002 YSAQ2_291A_2003 YSAQ2_291A_2004 YSAQ2_291A_2005 YSAQ2_291A_2006 YSAQ2_291A_2007 YSAQ2_291A_2008 

local j=4
local k=5
local g=6

foreach  y in YSAQ2_291A_1997 YSAQ2_291A_1998 YSAQ2_291A_1999 YSAQ2_291A_2000 YSAQ2_291A_2001 YSAQ2_291A_2002 YSAQ2_291A_2003 YSAQ2_291A_2004 YSAQ2_291A_2005 YSAQ2_291A_2006 YSAQ2_291A_2007 YSAQ2_291A_2008{
forvalue i=1/6 { 

local var: word `i' of `group'
local n: word `i' of `abc'

qui sum `y' if  `var'==1 & `y'>=0   

local mean: dis  `r(mean)' , %9.2f
local sd: dis `r(sd)', %9.2f
local N: dis `r(N)', %9.2f

putexcel B`j'=("`y'") `n'`j'=("`mean'") `n'`k'=("`sd'") `n'`g'=("`N'")  
 

 }

local j=`j'+3
local k=`k'+3
local g=`g'+3
}
*****

*
putexcel set datingtimes.xls, replace

local abc  C D  E F G H
local group  mlthw_edunew_0 mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5

local inde YSAQ2_293_1997 YSAQ2_293_1998 YSAQ2_293_1999 YSAQ2_293_2000 YSAQ2_293_2001 YSAQ2_293_2002 YSAQ2_293_2003 YSAQ2_293_2004 YSAQ2_293_2005 YSAQ2_293_2006 YSAQ2_293_2007 YSAQ2_293_2008
local j=4
local k=5
local g=6

foreach  y in YSAQ2_293_1997 YSAQ2_293_1998 YSAQ2_293_1999 YSAQ2_293_2000 YSAQ2_293_2001 YSAQ2_293_2002 YSAQ2_293_2003 YSAQ2_293_2004 YSAQ2_293_2005 YSAQ2_293_2006 YSAQ2_293_2007 YSAQ2_293_2008{
forvalue i=1/6 { 

local var: word `i' of `group'
local n: word `i' of `abc'

qui sum `y' if  `var'==1 & `y'>=0   

local mean: dis  `r(mean)' , %9.2f
local sd: dis `r(sd)', %9.2f
local N: dis `r(N)', %9.2f

putexcel B`j'=("`y'") `n'`j'=("`mean'") `n'`k'=("`sd'") `n'`g'=("`N'")  
 

 }

local j=`j'+3
local k=`k'+3
local g=`g'+3
}
*****

ttest firstsex1, by(black)

foreach x in mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5{ 
ttest firstsex1 , by(`x')
}
*

bysort mlthw_edu orimax : sum firstsex1,d
*

*
putexcel set agefstsex.xls, replace

local abc  C D  E F G H
local group  mlthw_edunew_0 mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5

local inde firstsex1
local j=4
local k=5
local g=6

foreach  y in firstsex1{
forvalue i=1/6 { 

local var: word `i' of `group'
local n: word `i' of `abc'

qui sum `y' if  `var'==1 & `y'>=0 & orimax ==0  

local mean: dis  `r(mean)' , %9.2f
local sd: dis `r(sd)', %9.2f
local N: dis `r(N)', %9.2f

putexcel B`j'=("`y'") `n'`j'=("`mean'") `n'`k'=("`sd'") `n'`g'=("`N'")  
 

 }

local j=`j'+3
local k=`k'+3
local g=`g'+3
}
*****

*
putexcel set agefstsex1.xls, replace

local abc  C D  E F G H
local group  mlthw_edunew_0 mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5

local inde firstsex1
local j=4
local k=5
local g=6

foreach  y in firstsex1{
forvalue i=1/6 { 

local var: word `i' of `group'
local n: word `i' of `abc'

qui sum `y' if  `var'==1 & `y'>=0 & orimax ==1  

local mean: dis  `r(mean)' , %9.2f
local sd: dis `r(sd)', %9.2f
local N: dis `r(N)', %9.2f

putexcel B`j'=("`y'") `n'`j'=("`mean'") `n'`k'=("`sd'") `n'`g'=("`N'")  
 

 }

local j=`j'+3
local k=`k'+3
local g=`g'+3
}
*****
*
putexcel set agefstsex2.xls, replace

local abc  C D  E F G H
local group  mlthw_edunew_0 mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5

local inde firstsex1
local j=4
local k=5
local g=6

foreach  y in firstsex1{
forvalue i=1/6 { 

local var: word `i' of `group'
local n: word `i' of `abc'

qui sum `y' if  `var'==1 & `y'>=0 & orimax ==2 

local mean: dis  `r(mean)' , %9.2f
local sd: dis `r(sd)', %9.2f
local N: dis `r(N)', %9.2f

putexcel B`j'=("`y'") `n'`j'=("`mean'") `n'`k'=("`sd'") `n'`g'=("`N'")  
 

 }

local j=`j'+3
local k=`k'+3
local g=`g'+3
}
*****

*
putexcel set agefstsex3.xls, replace

local abc  C D  E F G H
local group  mlthw_edunew_0 mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5

local inde firstsex1
local j=4
local k=5
local g=6

foreach  y in firstsex1{
forvalue i=1/6 { 

local var: word `i' of `group'
local n: word `i' of `abc'

qui sum `y' if  `var'==1 & `y'>=0 & orimax ==3 

local mean: dis  `r(mean)' , %9.2f
local sd: dis `r(sd)', %9.2f
local N: dis `r(N)', %9.2f

putexcel B`j'=("`y'") `n'`j'=("`mean'") `n'`k'=("`sd'") `n'`g'=("`N'")  
 

 }

local j=`j'+3
local k=`k'+3
local g=`g'+3
}
*****

ttest fstdateage, by(black)

foreach x in mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5{ 
ttest fstdateage , by(`x')
}
*

*
putexcel set agefstdate.xls, replace

local abc  C D  E F G H
local group  mlthw_edunew_0 mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5

local inde fstdateage 
local j=4
local k=5
local g=6

foreach  y in fstdateage{
forvalue i=1/6 { 

local var: word `i' of `group'
local n: word `i' of `abc'

qui sum `y' if  `var'==1 & `y'>=0 & orimax ==0  

local mean: dis  `r(mean)' , %9.2f
local sd: dis `r(sd)', %9.2f
local N: dis `r(N)', %9.2f

putexcel B`j'=("`y'") `n'`j'=("`mean'") `n'`k'=("`sd'") `n'`g'=("`N'")  
 

 }

local j=`j'+3
local k=`k'+3
local g=`g'+3
}
*****
*
putexcel set agefstdate1.xls, replace

local abc  C D  E F G H
local group  mlthw_edunew_0 mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5

local inde fstdateage 
local j=4
local k=5
local g=6

foreach  y in fstdateage{
forvalue i=1/6 { 

local var: word `i' of `group'
local n: word `i' of `abc'

qui sum `y' if  `var'==1 & `y'>=0 & orimax ==1  

local mean: dis  `r(mean)' , %9.2f
local sd: dis `r(sd)', %9.2f
local N: dis `r(N)', %9.2f

putexcel B`j'=("`y'") `n'`j'=("`mean'") `n'`k'=("`sd'") `n'`g'=("`N'")  
 

 }

local j=`j'+3
local k=`k'+3
local g=`g'+3
}
*****
*
putexcel set agefstdate2.xls, replace

local abc  C D  E F G H
local group  mlthw_edunew_0 mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5

local inde fstdateage 
local j=4
local k=5
local g=6

foreach  y in fstdateage{
forvalue i=1/6 { 

local var: word `i' of `group'
local n: word `i' of `abc'

qui sum `y' if  `var'==1 & `y'>=0 & orimax ==2  

local mean: dis  `r(mean)' , %9.2f
local sd: dis `r(sd)', %9.2f
local N: dis `r(N)', %9.2f

putexcel B`j'=("`y'") `n'`j'=("`mean'") `n'`k'=("`sd'") `n'`g'=("`N'")  
 

 }

local j=`j'+3
local k=`k'+3
local g=`g'+3
}
*****
*
putexcel set agefstdate3.xls, replace

local abc  C D  E F G H
local group  mlthw_edunew_0 mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5

local inde fstdateage 
local j=4
local k=5
local g=6

foreach  y in fstdateage{
forvalue i=1/6 { 

local var: word `i' of `group'
local n: word `i' of `abc'

qui sum `y' if  `var'==1 & `y'>=0 & orimax ==3  

local mean: dis  `r(mean)' , %9.2f
local sd: dis `r(sd)', %9.2f
local N: dis `r(N)', %9.2f

putexcel B`j'=("`y'") `n'`j'=("`mean'") `n'`k'=("`sd'") `n'`g'=("`N'")  
 

 }

local j=`j'+3
local k=`k'+3
local g=`g'+3
}
*****

forvalues i=0/5{
 tab  fstdateage mlthw_edu if mlthw_edu==`i',m
}
*
gen firstsex1_rd=round(firstsex1)
gen firstsex2_rd=trunc(firstsex1)


forvalues i=0/5{
 tab  firstsex1_rd mlthw_edu if mlthw_edu==`i',m
}

forvalues i=0/5{
 tab  firstsex2_rd mlthw_edu if mlthw_edu==`i',m
}

**
order ID YSAQ2_299_1997 YSAQ2_311_1997 YSAQ2_299_1998 YSAQ2_299B_1998 YSAQ2_311_1998 YSAQ2_299_1999 YSAQ2_299B_1999 YSAQ2_311_1999 YSAQ2_299_2000 YSAQ2_299B_2000 YSAQ2_311_2000 YSAQ2_299_2001 YSAQ2_299B_2001 YSAQ2_311_2001 YSAQ2_299_2002 YSAQ2_299B_2002 YSAQ2_311_2002 YSAQ2_299_2003 YSAQ2_299B_2003 YSAQ2_311_2003 YSAQ2_299_2004 YSAQ2_299B_2004 YSAQ2_311_2004 YSAQ2_299_2005 YSAQ2_299B_2005 YSAQ2_311_2005 YSAQ2_299B_2006 YSAQ2_311_2006 YSAQ2_299B_2007 YSAQ2_311_2007 YSAQ2_299B_2008 YSAQ2_311_2008 YSAQ2_299B_2009 YSAQ2_311_2009 YSAQ2_299B_2010 YSAQ2_311_2010 YSAQ2_299B_2011 YSAQ2_311_2011 YSAQ2_299_2013 YSAQ2_311_2013 YSAQ2_299_2015 YSAQ2_311_2015 YSAQ2_311_2017 YSAQ2_311_2019


reshape long YSAQ2_310_ YSAQ2_311_ YSAQ2_299_ YSAQ2_299B_ ///
YSAQ2_308_ YSAQ2_309_ YSAQ2_301_ , i(ID) string
drop year
rename _j year
destring year, replace force


gen ratio= YSAQ2_310_/YSAQ2_308_ if YSAQ2_310_>=0 & YSAQ2_308_ >0
replace ratio=ratio*100 if ratio!=.
replace ratio=YSAQ2_311_  if YSAQ2_311_>0 & ratio==. 


*reshape wide ratio YSAQ2_310_ YSAQ2_308_ , i(ID) j(year) string


use "/Users/mx2154/Desktop/Desktop - ADUAEI12760LPMX - 1/nlsy/sex-reshape.dta"

gen contraception_n=1 if YSAQ2_311_>=0
replace contraception_n=1 if YSAQ2_299B_==1 

bysort ID: egen sex_yr=min(year) if YSAQ2_299_==1
replace contraception_n=1 if year==sex_yr & contraception_n==.& year>=1998

*
forvalues i=1997/2015{
forvalues j=0/5{
	
	
bysort year: sum  YSAQ2_311_ if contraception_n==1&  mlthw_edu_`j'==1,d
}
}
*

*
putexcel set birthcontrol.xls, replace

local abc  C D  E F G H
local group  mlthw_edunew_0 mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5

local inde ratio  

local j=4
local k=5
local g=6

foreach  y in ratio {
forvalue h=1997/2011 { 
forvalue i=1/6 { 

local var: word `i' of `group'
local n: word `i' of `abc'

qui  sum `y' if  `var'==1 & `y'>=0  & year==`h'

local mean: dis  `r(mean)' , %9.2f
local sd: dis `r(sd)', %9.2f
local N: dis `r(N)', %9.2f

putexcel B`j'=("`y'") `n'`j'=("`mean'") `n'`k'=("`sd'") `n'`g'=("`N'")  
 

 }

local j=`j'+3
local k=`k'+3
local g=`g'+3
}
}
*****


*
putexcel set birthcontrolcount.xls, replace

local abc  C D  E F G H
local group  mlthw_edunew_0 mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5

local inde contraception_n 

local j=4
local k=5
local g=6

foreach  y in contraception_n {
forvalue h=1997/2015 { 
forvalue i=1/6 { 

local var: word `i' of `group'
local n: word `i' of `abc'

qui  sum `y' if  `var'==1  & contraception_n==1 & year==`h'

local mean: dis  `r(mean)' , %9.2f
local sd: dis `r(sd)', %9.2f
local N: dis `r(N)', %9.2f

putexcel B`j'=("`y'") `n'`g'=("`N'")  
 

 }

local j=`j'+3
local k=`k'+3
local g=`g'+3
}
}
*****

use "/Users/mx2154/Desktop/Desktop - ADUAEI12760LPMX - 1/nlsy/mar_cohab_month-drop14-keep only.dta"
**#


gen new299= YSAQ2_299B if YSAQ2_299B>=0
replace new299=1 if YSAQ2_308_>0 & new299==. & YSAQ2_308_!=.
replace new299=1  if YSAQ2_309_>0 & new299==. & YSAQ2_309_!=.
replace new299=0 if orimax==0 & firstsex_conti==. &  new299==.

replace new299=0 if contimonth< firstsex_conti & firstsex_conti!=.
replace new299=1 if contimonth== firstsex_conti & firstsex_conti!=.



bysort ID: gen new299_1new=new299[_n+12] 
replace new299_1new=0 if contimonth< firstsex_conti & firstsex_conti!=.
replace new299_1new=1 if contimonth== firstsex_conti & firstsex_conti!=.

*unprotecedsex
gen unprotected=YSAQ2_308_-YSAQ2_310_ if YSAQ2_308_>=0 &YSAQ2_310_>=0 ///
& YSAQ2_308_!=. & YSAQ2_310_!=. 
replace unprotected=YSAQ2_309_*(100-YSAQ2_311_)/100 if YSAQ2_309_>=0 &YSAQ2_311_>=0 ///
& YSAQ2_309_!=. & YSAQ2_311_!=. & unprotected==.

gen unprotected1=round(unprotected,1)
replace unprotected1=. if unprotected1<0

bysort ID: gen unprotected1_new=unprotected1[_n+12] 
replace unprotected1_new=0 if contimonth< firstsex_conti & firstsex_conti!=.
replace unprotected1_new=0 if  orimax==0 & diff2==1


tab unprotected1 if diff2==1,m

tab unprotected1 if diff2==1,
tab  unprotected1 mlthw_edu if diff2==1

histogram unprotected1 if diff2==1, freq
histogram unprotected1 if diff2==1 & unprotected1>0 , freq


gen unprotected2= unprotected1 if unprotected1 <=50
replace  unprotected2=51 if unprotected1 >50 & unprotected1 <=100
replace  unprotected2=101 if unprotected1 >100 & unprotected1 <=400
replace  unprotected2=401 if unprotected1 >400 & unprotected1!=.

tab  unprotected2 mlthw_edu if diff2==1, m
histogram unprotected2 if diff2==1, freq


gen unprotected3=0 if unprotected1 ==0
replace  unprotected3=5 if unprotected1 >0 & unprotected1 <=5
replace  unprotected3=10 if unprotected1 >5 & unprotected1 <=10
replace  unprotected3=50 if unprotected1 >10 & unprotected1 <=50
replace  unprotected3=51 if unprotected1 >50 & unprotected1<=100
replace  unprotected3=101 if unprotected1 >100 & unprotected1!=.


tab  unprotected3 mlthw_edu if diff2==1,m

histogram unprotected3 if diff2==1,  fraction

()
gen unprotect_0=0
replace unprotect_0=1 if unprotected1 ==0

gen unprotect_10=0
replace unprotect_10=1 if unprotected1 >0 & unprotected1 <=10

gen unprotect_above10=0
replace unprotect_above10=1 if unprotected1 >10 & unprotected1!=.


gen unprotect_50=0
replace unprotect_50=1 if unprotected1 >10 & unprotected1 <=50

gen unprotect_above50=0
replace unprotect_above50=1 if unprotected1 >50  & unprotected1!=.

gen unprotect_miss=0
replace unprotect_miss=1 if unprotected1==.

gen unprotect_25=0
replace unprotect_25=1 if unprotected1 >10 & unprotected1 <=25

gen unprotect_above25=0
replace unprotect_above25=1 if unprotected1 >25  & unprotected1!=.

gen unprotect_20=0
replace unprotect_20=1 if unprotected1 >10 & unprotected1 <=20

gen unprotect_above20=0
replace unprotect_above20=1 if unprotected1 >20  & unprotected1!=.

gen unprotect_25=0
replace unprotect_25=1 if unprotected1 >10 & unprotected1 <=25

gen unprotect_above25=0
replace unprotect_above25=1 if unprotected1 >25  & unprotected1!=.

gen unprotect_35=0
replace unprotect_35=1 if unprotected1 >10 & unprotected1 <=35

gen unprotect_above35=0
replace unprotect_above35=1 if unprotected1 >35  & unprotected1!=.

gen unprotect_new=0 if unprotected1 ==0
replace unprotect_new=1 if unprotected1 >0 & unprotected1 <=10
replace unprotect_new=2 if unprotected1 >10 & unprotected1 <=25
replace unprotect_new=3 if unprotected1 >25 &  unprotected1!=.
replace unprotect_new=4 if unprotected1==.


/*gen sex9=0   if contimonth< firstsex_conti & firstsex_conti !=.
bysort ID: replace sex9=YSAQ2_299B_1[_n+7] if sex9==. 
*

gen sex9_n=0  if contimonth< firstsex_conti & firstsex_conti !=.
replace sex9_n=1  if contimonth== firstsex_conti & firstsex_conti !=.
bysort ID: replace  sex9_n=YSAQ2_299B_1 if sex9_n==.  
replace sex9_n=. if sex9_n<0

**************using sexually activity 7 month minus at birth 
mlogit ori_cohab_birth i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.sex9_1  if  diff2==1 & age30_before==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_141n_test
outreg2 using mnlsep18ave1.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append

*
mlogit ori_cohab_birth i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.sex9_1  i.enrolled2  if  diff2==1 & age30_before==1   , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_151n
outreg2 using mnlsep18ave1.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append
*



***black reg coef plot
*
mlogit ori_cohab_birth i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.sex9_1  if  diff2==1 & age30_before==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_12b
outreg2 using mnlsep18ave1b.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append

*
mlogit ori_cohab_birth i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  i.sex9_1  if  diff2==1 & age30_before==1 , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_112b
outreg2 using mnlsep18ave1b.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append

*****at age 22
*
mlogit ori_cohab_birth i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5  gpa23 gpa335 gpaabove35 gpamissin i.sex9_1  if  diff2==1 & age30_before==1 , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_101
outreg2 using mnlsep22ave1.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append

*
mlogit ori_cohab_birth i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin  i.enrolled2  i.sex9_1  if  diff2==1 & age30_before==1 , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post
estimates save ave22_111
outreg2 using mnlsep22ave1.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append


***black as the ref
*
mlogit ori_cohab_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5  gpa23 gpa335 gpaabove35 gpamissin i.sex9_1  if  diff2==1 & age30_before==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_102
outreg2 using mnlsep22ave1b.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append

*
mlogit ori_cohab_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 i.sex9_1 if  diff2==1 & age30_before==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post
estimates save ave22_112
outreg2 using mnlsep22ave1b.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append

********
**************using sexually activity 7 month minus at birth 
mlogit ori_cohab_birth i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.sex9_1  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_121n
outreg2 using mnlsep18ave1.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append

*
mlogit ori_cohab_birth i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.sex9_1  i.enrolled2  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_131n
outreg2 using mnlsep18ave1.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append
*



***black reg coef plot
*
mlogit ori_cohab_birth i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.sex9_1  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_122b
outreg2 using mnlsep18ave1b.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append

*
mlogit ori_cohab_birth i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  i.sex9_1  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_132b
outreg2 using mnlsep18ave1b.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append

*****at age 22
*
mlogit ori_cohab_birth i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5  gpa23 gpa335 gpaabove35 gpamissin i.sex9_1  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_121
outreg2 using mnlsep22ave1.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append

*
mlogit ori_cohab_birth i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin  i.enrolled2  i.sex9_1  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post
estimates save ave22_131
outreg2 using mnlsep22ave1.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append


***black as the ref
*
mlogit ori_cohab_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5  gpa23 gpa335 gpaabove35 gpamissin i.sex9_1  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_122
outreg2 using mnlsep22ave1b.xls, excel dec(6) cttop (mnl1)  stat (coef se tstat) append

*
mlogit ori_cohab_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 i.sex9_1 if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post
estimates save ave22_132
outreg2 using mnlsep22ave1b.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append
*/

*************************************************
************try the shotgun*************************************************
** 
mlogit ori_cohab_birth_exact i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.sex9_n   if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_101sgtest
outreg2 using mnlsep18ave1sg.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append

*
mlogit ori_cohab_birth_exact i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.sex9_n i.enrolled2  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis18new =0) vsquish post 
estimates save ave18_111sg
outreg2 using mnlsep18ave1sg.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append
*


***********
***black reg coef plot
mlogit ori_cohab_birth_exact i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.sex9_n if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_102bsg
outreg2 using mnlsep18ave1bsg.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append


*
mlogit ori_cohab_birth_exact i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.sex9_n i.enrolled2  if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis18new =0) vsquish post
estimates save ave18_112bsg
outreg2 using mnlsep18ave1bsg.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append


*****at age 22
*
mlogit ori_cohab_birth_exact i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5  gpa23 gpa335 gpaabove35 gpamissin i.sex9_n if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_101sg
outreg2 using mnlsep22ave1sg.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.sex9_n i.enrolled2  if  diff2==1  , rrr cluster(ID)


margins, dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post
estimates save ave22_111sg
outreg2 using mnlsep22ave1sg.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append


***black as the ref
*
mlogit ori_cohab_birth_exact i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5  gpa23 gpa335 gpaabove35 gpamissin i.sex9_n if  diff2==1  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_102sg
outreg2 using mnlsep22ave1bsg.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 urban12_1 urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep i.singlemom /// 
i.singledad i.nobiopar i.hhstruother i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 ///
incqun_5   gpa23 gpa335 gpaabove35 gpamissin i.sex9_n i.enrolled2  if  diff2==1  , rrr cluster(ID)


margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post
estimates save ave22_112sg
outreg2 using mnlsep22ave1bsg.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append



******coefplot******************************************************************
*cohab
. estimates use  ave18_11
. estimates store  ave18_11

. estimates use  ave18_21
. estimates store  ave18_21

. estimates use  ave18_31
. estimates store  ave18_31

. estimates use  ave18_41n
. estimates store  ave18_41n

. estimates use  ave18_141n
. estimates store  ave18_141n

. estimates use  ave18_151n
. estimates store  ave18_151n

*
. estimates use  ave18_11sg
. estimates store  ave18_11sg

. estimates use  ave18_21sg
. estimates store  ave18_21sg

. estimates use  ave18_31sg
. estimates store  ave18_31sg

. estimates use  ave18_41sg
. estimates store  ave18_41sg

. estimates use  ave18_101sg
. estimates store  ave18_101sg

. estimates use  ave18_111sg
. estimates store  ave18_111sg


. estimates use  ave18_11act
. estimates store  ave18_11act

. estimates use  ave18_21act
. estimates store  ave18_21act

. estimates use  ave18_31act
. estimates store  ave18_31act

. estimates use  ave18_41act
. estimates store  ave18_41act

. estimates use  ave18_51act
. estimates store  ave18_51act


coefplot (ave18_11, label(Baseline)) (ave18_21, label(+HH structure)) ///
(ave18_31, label(+HH inc)) (ave18_41n, label(+HS GPA)) ( ave18_141n, label(+Sexually Active)) ///
( ave18_151n, label(+School Enrollment)),keep(*.mlthw_edu)  vertical ///
recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) ///
coeflabel(1.mlthw_edu ="White HS" 2.mlthw_edu ="WHite BA+" 3.mlthw_edu ="Black <HS" ///
4.mlthw_edu = "Black HS" 5.mlthw_edu ="Black BA+")

coefplot (ave18_11sg, label(Baseline)) (ave18_21sg, label(+HH structure)) ///
(ave18_31sg, label(+HH inc)) (ave18_41sg, label(+HS GPA)) ( ave18_101sg, label(+Sexually Active)) ///
( ave18_111sg, label(+School Enrollment)),keep(*.mlthw_edu)  vertical ///
recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) ///
coeflabel(1.mlthw_edu ="White HS" 2.mlthw_edu ="WHite BA+" 3.mlthw_edu ="Black <HS" ///
4.mlthw_edu = "Black HS" 5.mlthw_edu ="Black BA+")



coefplot (ave18_11sg, label(Baseline)) (ave18_21sg, label(+HH structure)) ///
(ave18_31sg, label(+HH inc)) (ave18_41sg, label(+HS GPA)) ///
( ave18_51sg, label(+School Enrollment)), bylabel(exclude conception)|| (ave18_11act, label(Baseline)) ///
(ave18_21act, label(+HH structure)) ///
(ave18_31act, label(+HH inc)) (ave18_41act, label(+HS GPA)) ///
( ave18_51act, label(+School Enrollment)), bylabel(age interacting with all baseline controls)|| ///
,keep(*.mlthw_edu)  vertical ///
recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) ///
coeflabel(1.mlthw_edu ="White HS" 2.mlthw_edu ="WHite BA+" 3.mlthw_edu ="Black <HS" ///
4.mlthw_edu = "Black HS" 5.mlthw_edu ="Black BA+")




***************************
. estimates use  ave18_12b
. estimates store  ave18_12b

. estimates use  ave18_22b
. estimates store  ave18_22b

. estimates use  ave18_32b
. estimates store  ave18_32b

. estimates use  ave18_42b
. estimates store  ave18_42b

. estimates use  ave18_122b
. estimates store  ave18_122b

. estimates use  ave18_132b
. estimates store  ave18_132b

*
. estimates use  ave18_12bsg
. estimates store  ave18_12bsg

. estimates use  ave18_22bsg
. estimates store  ave18_22bsg

. estimates use  ave18_32bsg
. estimates store  ave18_32bsg

. estimates use  ave18_42bsg
. estimates store  ave18_42bsg

. estimates use  ave18_102bsg
. estimates store  ave18_102bsg

. estimates use  ave18_112bsg
. estimates store  ave18_112bsg


. estimates use  ave18_b12act
. estimates store  ave18_b12act

. estimates use  ave18_b22act
. estimates store  ave18_b22act

. estimates use  ave18_b32act
. estimates store  ave18_b32act

. estimates use  ave18_b42act
. estimates store  ave18_b42act

. estimates use  ave18_b52act
. estimates store  ave18_b52act


coefplot (ave18_12bsg, label(Baseline)) (ave18_22bsg, label(+HH structure)) ///
(ave18_32bsg, label(+HH inc)) (ave18_42bsg, label(+HS GPA)) ( ave18_102bsg, label(+Sexually Active))  ///
( ave18_112bsg, label(+School Enrollment)), keep(*.blthw_edu)  vertical ///
recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) citop ///
coeflabel(1.blthw_edu ="Black HS" 2.blthw_edu ="Black BA+" 3.blthw_edu ="White <HS" ///
4.blthw_edu = "White HS" 5.blthw_edu ="White BA+")

coefplot (ave18_12b, label(Baseline)) (ave18_22b, label(+HH structure)) ///
(ave18_32b, label(+HH inc)) (ave18_42b, label(+HS GPA)) ( ave18_122b, label(+Sexually Active))  ///
( ave18_132b, label(+School Enrollment)), keep(*.blthw_edu)  vertical ///
recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) citop ///
coeflabel(1.blthw_edu ="Black HS" 2.blthw_edu ="Black BA+" 3.blthw_edu ="White <HS" ///
4.blthw_edu = "White HS" 5.blthw_edu ="White BA+")


coefplot (ave18_12bsg, label(Baseline)) (ave18_22bsg, label(+HH structure)) ///
(ave18_32bsg, label(+HH inc)) (ave18_42bsg, label(+HS GPA)) ///
(ave18_52bsg, label(+School Enrollment)), bylabel(conception first)|| ///
(ave18_b12act, label(Baseline)) (ave18_b22act, label(+HH structure)) ///
(ave18_b32act, label(+HH inc)) (ave18_b42act, label(+HS GPA)) ///
(ave18_b52act, label(+School Enrollment)), bylabel(age interacting with all baseline controls)|| ///
,keep(*.blthw_edu)  vertical ///
recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) citop ///
coeflabel(1.blthw_edu ="Black HS" 2.blthw_edu ="Black BA+" 3.blthw_edu ="White <HS" ///
4.blthw_edu = "White HS" 5.blthw_edu ="White BA+")




*************************age 22*******************************************
. estimates use  ave22_11
. estimates store  ave22_11

. estimates use  ave22_21
. estimates store  ave22_21

. estimates use  ave22_31
. estimates store  ave22_31

. estimates use  ave22_41
. estimates store  ave22_41

. estimates use  ave22_121
. estimates store  ave22_121

. estimates use  ave22_131
. estimates store ave22_131


*

. estimates use  ave22_11sg
. estimates store  ave22_11sg

. estimates use  ave22_21sg
. estimates store  ave22_21sg

. estimates use  ave22_31sg
. estimates store  ave22_31sg

. estimates use  ave22_41sg
. estimates store  ave22_41sg

. estimates use   ave22_101sg
. estimates store   ave22_101sg

. estimates use   ave22_111sg
. estimates store   ave22_111sg

***

. estimates use  ave22_11act
. estimates store  ave22_11act

. estimates use  ave22_21act
. estimates store  ave22_21act

. estimates use  ave22_31act
. estimates store  ave22_31act

. estimates use  ave22_41act
. estimates store  ave22_41act

. estimates use  ave22_51act
. estimates store  ave22_51act

coefplot (ave22_11, label(Baseline)) ///
(ave22_21, label(+HH structure)) ///
(ave22_31, label(+HH inc)) (ave22_41, label(+HS GPA)) (ave22_121, label(+Sexually Active)) /// ///
( ave22_131, label(+School Enrollment)), bylabel(at age 22)||,keep(*.mlthw_edu)  vertical ///
recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) ///
coeflabel(1.mlthw_edu ="White HS" 2.mlthw_edu ="WHite BA+" 3.mlthw_edu ="Black <HS" ///
4.mlthw_edu = "Black HS" 5.mlthw_edu ="Black BA+")

coefplot (ave22_11sg, label(Baseline)) ///
(ave22_21sg, label(+HH structure)) ///
(ave22_31sg, label(+HH inc)) (ave22_41sg, label(+HS GPA)) (ave22_101sg, label(+Sexually Active)) /// ///
( ave22_111sg, label(+School Enrollment)), bylabel(at age 22)||,keep(*.mlthw_edu)  vertical ///
recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) ///
coeflabel(1.mlthw_edu ="White HS" 2.mlthw_edu ="WHite BA+" 3.mlthw_edu ="Black <HS" ///
4.mlthw_edu = "Black HS" 5.mlthw_edu ="Black BA+")

coefplot (ave22_11sg, label(Baseline)) (ave22_21sg, label(+HH structure)) ///
(ave22_31sg, label(+HH inc)) (ave22_41sg, label(+HS GPA)) ///
(ave22_51sg, label(+School Enrollment)),  bylabel(exclude conception)|| ///
(ave22_11act, label(Baseline)) (ave22_21act, label(+HH structure)) ///
(ave22_31act, label(+HH inc)) (ave22_41act, label(+HS GPA)) ///
( ave22_51act, label(+School Enrollment)), bylabel(age interacting with all baseline controls)|| ///
,keep(*.mlthw_edu)  vertical ///
recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) citop  ///
coeflabel(1.mlthw_edu ="White HS" 2.mlthw_edu ="WHite BA+" 3.mlthw_edu ="Black <HS" ///
4.mlthw_edu = "Black HS" 5.mlthw_edu ="Black BA+")


****birth
. estimates use  ave22_12
. estimates store  ave22_12

. estimates use  ave22_22
. estimates store  ave22_22

. estimates use  ave22_32
. estimates store  ave22_32

. estimates use  ave22_42
. estimates store  ave22_42

. estimates use  ave22_122
. estimates store  ave22_122

. estimates use  ave22_132
. estimates store  ave22_132


**
estimates use  ave22_12sg
. estimates store  ave22_12sg

. estimates use  ave22_22sg
. estimates store  ave22_22sg

. estimates use  ave22_32sg
. estimates store  ave22_32sg

. estimates use  ave22_42sg
. estimates store  ave22_42sg

. estimates use  ave22_102sg
. estimates store  ave22_102sg

. estimates use  ave22_112sg
. estimates store  ave22_112sg



estimates use  ave22_12bact
. estimates store  ave22_12bact

. estimates use  ave22_22bact
. estimates store  ave22_22bact

. estimates use  ave22_32bact
. estimates store  ave22_32bact

. estimates use  ave22_42bact
. estimates store  ave22_42bact

. estimates use  ave22_52bact
. estimates store  ave22_52bact


coefplot(ave22_12, label(Baseline)) (ave22_22, label(+HH structure)) ///
(ave22_32, label(+HH inc)) (ave22_42, label(+HS GPA)) (ave22_122, label(+Sexually Active)) ///
(ave22_132, label(+School enrollment))||,keep(*.blthw_edu)  vertical ///
recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) citop  ///
coeflabel(1.blthw_edu ="Black HS" 2.blthw_edu ="Black BA+" 3.blthw_edu ="White <HS" ///
4.blthw_edu = "White HS" 5.blthw_edu ="White BA+")

coefplot(ave22_12sg, label(Baseline)) (ave22_22sg, label(+HH structure)) ///
(ave22_32sg, label(+HH inc)) (ave22_42sg, label(+HS GPA)) (ave22_102sg, label(+Sexually Active)) ///
(ave22_112sg, label(+School enrollment))||,keep(*.blthw_edu)  vertical ///
recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) citop  ///
coeflabel(1.blthw_edu ="Black HS" 2.blthw_edu ="Black BA+" 3.blthw_edu ="White <HS" ///
4.blthw_edu = "White HS" 5.blthw_edu ="White BA+")




coefplot (ave22_12sg, label(Baseline)) (ave22_22sg, label(+HH structure)) ///
(ave22_32sg, label(+HH inc)) (ave22_42sg, label(+HS GPA)) ///
(ave22_52sg, label(+School enrollment)), bylabel(conception first)|| ///
(ave22_12bact, label(Baseline)) (ave22_22bact, label(+HH structure)) ///
(ave22_32bact, label(+HH inc)) (ave22_42bact, label(+HS GPA)) ///
(ave22_52bact, label(+School Enrollment)), bylabel(age interacting with all baseline controls)|| ///
,keep(*.blthw_edu)   vertical ///
recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) citop ///
coeflabel(1.blthw_edu ="Black HS" 2.blthw_edu ="Black BA+" 3.blthw_edu ="White <HS" ///
4.blthw_edu = "White HS" 5.blthw_edu ="White BA+")
******


/*****seperate estimates for different groups, using conceptions (9-month)
*********************************************************************************


*****at age 18
forvalues i=0/5{
local exogb  agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 

mlogit ori_cohab_birth_exact1  `exogb'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)

margins census_1 census_2 census_3 census_4 urban12_1 urban12_unknown ///
birthyr_1981 birthyr_1982 birthyr_1983 birthyr_1984, ///
atmeans predict(outcome(1))  at(agedis18new =0) vsquish post 

outreg2 using mnl18momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
}

forvalues i=0/5{
local exogb  agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 

mlogit ori_cohab_birth_exact1  `exogb'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)

margins census_1 census_2 census_3 census_4 urban12_1 urban12_unknown ///
birthyr_1981 birthyr_1982 birthyr_1983 birthyr_1984, ///
atmeans predict(outcome(2))  at(agedis18new =0) vsquish post 

outreg2 using mnl18momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
}

forvalues i=0/5{
local exogb1  agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother

mlogit ori_cohab_birth_exact1  `exogb1'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)

margins census_1 census_2 census_3 census_4 urban12_1 urban12_unknown ///
birthyr_1981 birthyr_1982 birthyr_1983 birthyr_1984 ///
bioandstep singlemom singledad nobiopar hhstruother, ///
atmeans predict(outcome(1))  at(agedis18new =0) vsquish post 


outreg2 using mnl18momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
	
}
forvalues i=0/5{
local exogb1  agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother

mlogit ori_cohab_birth_exact1  `exogb1'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)

margins census_1 census_2 census_3 census_4 urban12_1 urban12_unknown ///
birthyr_1981 birthyr_1982 birthyr_1983 birthyr_1984 ///
bioandstep singlemom singledad nobiopar hhstruother, ///
atmeans predict(outcome(2))  at(agedis18new =0) vsquish post 


outreg2 using mnl18momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
	
}

forvalues i=0/5{
local exogb2  agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 i.incqun_5  

mlogit ori_cohab_birth_exact1  `exogb2'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)

margins census_1 census_2 census_3 census_4 urban12_1 urban12_unknown ///
birthyr_1981 birthyr_1982 birthyr_1983 birthyr_1984 ///
bioandstep singlemom singledad nobiopar hhstruother ///
incqun_1 incqun_2 incqun_3 incqun_4 incqun_5, ///
atmeans predict(outcome(1))  at(agedis18new =0) vsquish post 

outreg2 using mnl18momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
	
}

forvalues i=0/5{
local exogb2  agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 i.incqun_5  

mlogit ori_cohab_birth_exact1  `exogb2'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)

margins census_1 census_2 census_3 census_4 urban12_1 urban12_unknown ///
birthyr_1981 birthyr_1982 birthyr_1983 birthyr_1984 ///
bioandstep singlemom singledad nobiopar hhstruother ///
incqun_1 incqun_2 incqun_3 incqun_4 incqun_5, ///
atmeans predict(outcome(2))  at(agedis18new =0) vsquish post 

outreg2 using mnl18momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
	
}

forvalues i=0/5{
local exogb3  agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing 

mlogit ori_cohab_birth_exact1  `exogb3'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)

margins census_1 census_2 census_3 census_4 urban12_1 urban12_unknown ///
birthyr_1981 birthyr_1982 birthyr_1983 birthyr_1984 ///
bioandstep singlemom singledad nobiopar hhstruother ///
incqun_1 incqun_2 incqun_3 incqun_4 incqun_5 ///
gpa23 gpa335 gpaabove35 gpamissing , atmeans predict(outcome(1))  at(agedis18new =0) vsquish post 


outreg2 using mnl18momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
	
}

forvalues i=0/5{
local exogb3  agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing 

mlogit ori_cohab_birth_exact1  `exogb3'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)

margins census_1 census_2 census_3 census_4 urban12_1 urban12_unknown ///
birthyr_1981 birthyr_1982 birthyr_1983 birthyr_1984 ///
bioandstep singlemom singledad nobiopar hhstruother ///
incqun_1 incqun_2 incqun_3 incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing , atmeans predict(outcome(2))  at(agedis18new =0) vsquish post 


outreg2 using mnl18momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
	
}
*w ba not concave 
forvalues i=0/6{
if inlist(`i',2,6) continue
local exogb4  agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.new299_1new 

mlogit ori_cohab_birth_exact1  `exogb4'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)


outreg2 using mnl18momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
}





mlogit ori_cohab_birth_exact1 agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.new299_1new  if  diff2==1 & mlthw_edu_3==1  , rrr cluster(ID)

margins census_1 census_2 census_3 census_4 urban12_1 urban12_unknown ///
birthyr_1981 birthyr_1982 birthyr_1983 birthyr_1984 ///
bioandstep singlemom singledad nobiopar hhstruother ///
incqun_1 incqun_2 incqun_3 incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.new299_1new , atmeans predict(outcome(1))  at(agedis18new =0) vsquish post 


outreg2 using mnl18momedu3.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append 

mlogit ori_cohab_birth_exact1 agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.new299_1new  if  diff2==1 & mlthw_edu_4==1  , rrr cluster(ID)

margins census_1 census_2 census_3 census_4 urban12_1 urban12_unknown ///
birthyr_1981 birthyr_1982 birthyr_1983 birthyr_1984 ///
bioandstep singlemom singledad nobiopar hhstruother ///
incqun_1 incqun_2 incqun_3 incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.new299_1new , atmeans predict(outcome(1))  at(agedis18new =0) vsquish post 


outreg2 using mnl18momedu4.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform

mlogit ori_cohab_birth_exact1 agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.new299_1new  if  diff2==1 & mlthw_edu_5==1  , rrr cluster(ID)

margins census_1 census_2 census_3 census_4 urban12_1 urban12_unknown ///
birthyr_1981 birthyr_1982 birthyr_1983 birthyr_1984 ///
bioandstep singlemom singledad nobiopar hhstruother ///
incqun_1 incqun_2 incqun_3 incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.new299_1new , atmeans predict(outcome(1))  at(agedis18new =0) vsquish post 

outreg2 using mnl18momedu5.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
*
*
forvalues i=0/5{
local exogb4  agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.enrolled2

mlogit ori_cohab_birth_exact1  `exogb4'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)
 
outreg2 using mnl18momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
}

*w ba not concave 
forvalues i=0/6{
if inlist(`i',2,6) continue
local exogb5  agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.new299_1new i.enrolled2

mlogit ori_cohab_birth_exact1  `exogb5'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)

outreg2 using mnl18momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
	
}

mlogit ori_cohab_birth_exact1 agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.new299_1new i.enrolled2  if  diff2==1 & mlthw_edu_0==1  , rrr cluster(ID)

outreg2 using mnl18momedu0.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append 




mlogit ori_cohab_birth_exact1 agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.new299_1new i.enrolled2  if  diff2==1 & mlthw_edu_3==1  , rrr cluster(ID)

margins census_1 census_2 census_3 census_4 urban12_1 urban12_unknown ///
birthyr_1981 birthyr_1982 birthyr_1983 birthyr_1984 ///
bioandstep singlemom singledad nobiopar hhstruother ///
incqun_1 incqun_2 incqun_3 incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.new299_1new i.enrolled2 , atmeans predict(outcome(1))  at(agedis18new =0) vsquish post 

outreg2 using mnl18momedu3.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append 

mlogit ori_cohab_birth_exact1 agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.new299_1new i.enrolled2  if  diff2==1 & mlthw_edu_4==1  , rrr cluster(ID)

margins census_1 census_2 census_3 census_4 urban12_1 urban12_unknown ///
birthyr_1981 birthyr_1982 birthyr_1983 birthyr_1984 ///
bioandstep singlemom singledad nobiopar hhstruother ///
incqun_1 incqun_2 incqun_3 incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.new299_1new i.enrolled2 , atmeans predict(outcome(1))  at(agedis18new =0) vsquish post 

outreg2 using mnl18momedu4.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform

*B BA+, variance non singular
mlogit ori_cohab_birth_exact1 agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.new299_1new i.enrolled2 if  diff2==1 & mlthw_edu_5==1  , rrr cluster(ID)

margins census_1 census_2 census_3 census_4 urban12_1 urban12_unknown ///
birthyr_1981 birthyr_1982 birthyr_1983 birthyr_1984 ///
bioandstep singlemom singledad nobiopar hhstruother ///
incqun_1 incqun_2 incqun_3 incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.new299_1new i.enrolled2 , atmeans predict(outcome(1))  at(agedis18new =0) vsquish post 

outreg2 using mnl18momedu5.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
*
forvalues i=0/6{
if inlist(`i',2,6) continue
local exogb5  agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.new299_1new i.enrolled2

mlogit ori_cohab_birth_exact1  `exogb5'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)

margins census_1 census_2 census_3 census_4 urban12_1 urban12_unknown ///
birthyr_1981 birthyr_1982 birthyr_1983 birthyr_1984 ///
bioandstep singlemom singledad nobiopar hhstruother ///
incqun_1 incqun_2 incqun_3 incqun_4 i.incqun_5 ///
gpa23 gpa335 gpaabove35 gpamissing new299_1new enrolled2 , ///
atmeans predict(outcome(2))  at(agedis18new =0) vsquish post
outreg2 using mnl18momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
	
}


*
forvalues i=0/5{
local exogb6  agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.enrolled2

mlogit ori_cohab_birth_exact1  `exogb6'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)

outreg2 using mnl18momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
}


*
forvalues i=0/5{
local exogb7  agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.enrolled2 ///
i.unprotect_10 i.unprotect_25 i.unprotect_above25 i.unprotect_miss 

mlogit ori_cohab_birth_exact1  `exogb7'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)

outreg2 using mnl18momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
}



*
forvalues i=0/5{
local exogb7  agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing ///
i.unprotect_10 i.unprotect_25 i.unprotect_above25 i.unprotect_miss 

mlogit ori_cohab_birth_exact1  `exogb7'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)

outreg2 using mnl18momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
}



*****at age 22
forvalues i=0/5{
local exogb22  agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 

mlogit ori_cohab_birth_exact1  `exogb22'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)

	
outreg2 using mnl22momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
	
}

forvalues i=0/5{
local exogb221  agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother

mlogit ori_cohab_birth_exact1  `exogb221'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)


outreg2 using mnl22momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
	
}

forvalues i=0/5{
local exogb222  agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 i.incqun_5  

mlogit ori_cohab_birth_exact1  `exogb222'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)

outreg2 using mnl22momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
	
}

forvalues i=0/5{
local exogb223  agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 i.incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing 

mlogit ori_cohab_birth_exact1  `exogb223'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)

outreg2 using mnl22momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
	
}

forvalues i=0/6{
if inlist(`i',2,6) continue
local exogb224  agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.new299_1new

mlogit ori_cohab_birth_exact1  `exogb224'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)
outreg2 using mnl22momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
	
}

forvalues i=0/5{
local exogb226  agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.enrolled2

mlogit ori_cohab_birth_exact1  `exogb226'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)
outreg2 using mnl22momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
	
}


forvalues i=0/6{
if inlist(`i',2,6) continue
local exogb226  agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.new299_1new i.enrolled2

mlogit ori_cohab_birth_exact1  `exogb226'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)
outreg2 using mnl22momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
	
}
	
forvalues i=0/5{
local exogb226  agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.unprotect_10 i.unprotect_25 ///
i.unprotect_above25 i.unprotect_miss 

mlogit ori_cohab_birth_exact1  `exogb226'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)
outreg2 using mnl22momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
	
}

forvalues i=0/5{
local exogb226  agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_1 i.census_2 i.census_3 i.census_4 ///
i.urban12_1 i.urban12_unknown ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
i.bioandstep i.singlemom i.singledad i.nobiopar i.hhstruother ///
i.incqun_1 i.incqun_2 i.incqun_3 i.incqun_4 incqun_5 ///
i.gpa23 i.gpa335 i.gpaabove35 i.gpamissing i.unprotect_10 i.unprotect_25 ///
i.unprotect_above25 i.unprotect_miss  i.enrolled2

mlogit ori_cohab_birth_exact1  `exogb226'  if  diff2==1 & mlthw_edu_`i'==1  , rrr cluster(ID)
outreg2 using mnl22momedu`i'.xls, excel dec(6) cttop (mnl1)  stat (coef se ) append eform
	
}
*/
	
***********

*******coefplot******************************************************************
*cohab

*
. estimates use  ave18_11sg9
. estimates store  ave18_11sg9

. estimates use  ave18_21sg9
. estimates store  ave18_21sg9

. estimates use  ave18_31sg9
. estimates store  ave18_31sg9

. estimates use  ave18_41sg9
. estimates store  ave18_41sg9

. estimates use  ave18_51sg9
. estimates store  ave18_51sg9

. estimates use  ave18_61sg9
. estimates store  ave18_61sg9

. estimates use  ave18_71sg9
. estimates store  ave18_71sg9

coefplot (ave18_11sg9, label(1:Baseline)) (ave18_21sg9, label(2:+HH structure)) ///
(ave18_31sg9, label(3:+HH inc)) (ave18_41sg9, label(4:+HS GPA)) ///
 (ave18_71sg9, label(5:+School Enrollment first)) (ave18_61sg9, label(6:+Sexually Active)) ///
,keep(*.mlthw_edu) vertical recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) ///
coeflabel(1.mlthw_edu ="White HS" 2.mlthw_edu ="WHite BA+" 3.mlthw_edu ="Black <HS" ///
4.mlthw_edu = "Black HS" 5.mlthw_edu ="Black BA+") title("no interaction btw mom edu and mediators")


***************************
. estimates use  ave18_12bsg9
. estimates store  ave18_12bsg9

. estimates use  ave18_22bsg9
. estimates store  ave18_22bsg9

. estimates use  ave18_32bsg9
. estimates store  ave18_32bsg9

. estimates use  ave18_42bsg9
. estimates store  ave18_42bsg9

. estimates use  ave18_52bsg9
. estimates store  ave18_52bsg9

. estimates use  ave18_62bsg9
. estimates store  ave18_62bsg9

. estimates use  ave18_72bsg9
. estimates store  ave18_72bsg9

. estimates use  ave18_82bsg9
. estimates store  ave18_82bsg9

. estimates use  ave18_92bsg9
. estimates store  ave18_92bsg9


coefplot (ave18_12bsg9, label(1:Baseline)) (ave18_22bsg9, label(2:+HH structure)) ///
(ave18_32bsg9, label(3:+HH inc)) (ave18_42bsg9, label(4:+HS GPA)) ( ave18_52bsg9, label(5-1:+Sexually Active))  ( ave18_92bsg9, label(5-2:+School Enrollment first)) ///
( ave18_62bsg9, label(6:+School Enrollment))( ave18_72bsg9, label(7:+Unprotected Sex)) ///
( ave18_82bsg9, label(8:+School Enrollment)) , keep(*.blthw_edu)  vertical ///
recast(bar) barwidth(0.07) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) citop  ///
coeflabel(1.blthw_edu ="Black HS" 2.blthw_edu ="Black BA+" 3.blthw_edu ="White <HS" ///
4.blthw_edu = "White HS" 5.blthw_edu ="White BA+")



coefplot (ave18_12bsg9, label(1:Baseline)) (ave18_22bsg9, label(2:+HH structure)) ///
(ave18_32bsg9, label(3:+HH inc)) (ave18_42bsg9, label(4:+HS GPA)) ///
( ave18_92bsg9, label(5:+School Enrollment)) ///
( ave18_82bsg9, label(6:+times of unprotected sex)) , keep(*.blthw_edu)  vertical ///
recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) citop  ///
coeflabel(1.blthw_edu ="Black HS" 2.blthw_edu ="Black BA+" 3.blthw_edu ="White <HS" ///
4.blthw_edu = "White HS" 5.blthw_edu ="White BA+") title("no interaction btw mom edu and mediators")



*
. estimates use  ave22_11sg9
. estimates store  ave22_11sg9

. estimates use  ave22_21sg9
. estimates store  ave22_21sg9

. estimates use  ave22_31sg9
. estimates store  ave22_31sg9

. estimates use  ave22_41sg9
. estimates store  ave22_41sg9

. estimates use   ave22_51sg9
. estimates store   ave22_51sg9

. estimates use   ave22_61sg9
. estimates store   ave22_61sg9

. estimates use   ave22_71sg9
. estimates store   ave22_71sg9

coefplot (ave22_11sg9, label(1:Baseline))(ave22_21sg9, label(2:+HH structure)) ///
(ave22_31sg9, label(3:+HH inc)) (ave22_41sg9, label(4:+HS GPA)) (ave22_51sg9, label(5-1:+Sexually Active)) /// 
(ave22_71sg9, label(5-1:+School Enrollment first))(ave22_61sg9, label(6:+School Enrollment)),keep(*.mlthw_edu)  vertical ///
recast(bar) barwidth(0.1) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) ///
coeflabel(1.mlthw_edu ="White HS" 2.mlthw_edu ="WHite BA+" 3.mlthw_edu ="Black <HS" ///
4.mlthw_edu = "Black HS" 5.mlthw_edu ="Black BA+")

****birth
estimates use  ave22_12sg9
. estimates store  ave22_12sg9

. estimates use  ave22_22sg9
. estimates store  ave22_22sg9

. estimates use  ave22_32sg9
. estimates store  ave22_32sg9

. estimates use  ave22_42sg9
. estimates store  ave22_42sg9

. estimates use  ave22_52sg9
. estimates store  ave22_52sg9

. estimates use  ave22_62sg9
. estimates store  ave22_62sg9

. estimates use  ave22_72sg9
. estimates store  ave22_72sg9

. estimates use  ave22_82sg9
. estimates store  ave22_82sg9

. estimates use  ave22_92sg9
. estimates store  ave22_92sg9

coefplot(ave22_12sg9, label(1:Baseline)) (ave22_22sg9, label(2:+HH structure)) ///
(ave22_32sg9, label(3:+HH inc)) (ave22_42sg9, label(4:+HS GPA)) (ave22_52sg9, label(5-1:+Sexually Active)) ///
(ave22_92sg9, label(5-2:+School enrollment first))(ave22_62sg9, label(6:+School enrollment)) ///
(ave22_72sg9, label(7:+Unprotected Sex)) ///
(ave22_82sg9, label(8:+School Enrollment))||,keep(*.blthw_edu)  vertical ///
recast(bar) barwidth(0.07) fcolor(*.5) ciopts(recast(rcap)) ///
fcolor(. white) lwidth(. medium) citop  ///
coeflabel(1.blthw_edu ="Black HS" 2.blthw_edu ="Black BA+" 3.blthw_edu ="White <HS" ///
4.blthw_edu = "White HS" 5.blthw_edu ="White BA+")






/*On the mi impute mvn command line we can use the add option to specify the number of imputations to be performed. In this example we chose 10 imputations.  Variables on the left side of the equal sign have missing information, while the right side is reserved for variables with no missing information and are therefore solely considered "predictors" of missing values.  

After the mvn all the variables for the imputation model are specified including all the variables in the analytic model as well as any auxiliary variables. The option rseed is not required, but since MI is designed to be a random process, setting a seed will allow you to obtain the same imputed dataset each time. The imputed datasets will  be stored appended or "stacked" together in a dataset. The indicator variable called _mi_m is automatically populated to number each new imputed dataset (1 -10).*/

webuse mheart5                                                                
mi set mlong                                                                    
mi register imputed age bmi                                                      
set seed 29390                                                                  
mi impute mvn age bmi = attack smokes hsgrad female, add(10)
preserve
forval i=1/10{
    mi extract `i', clear
    save mi_dataset`i'
    restore, preserve
}


***********


***********
 

estimates use ave22_71sg9w
estimates store ave22_71sg9w
ereturn display


********************estimating marriage for reviewer comments

****
 gen mlthw_edu_ba=0 if mlthw_edu==2
 replace mlthw_edu_ba=1 if mlthw_edu==0
 replace mlthw_edu_ba=2 if mlthw_edu==1
 replace mlthw_edu_ba=3 if mlthw_edu==3
 replace mlthw_edu_ba=4 if mlthw_edu==4
 replace mlthw_edu_ba=5  if mlthw_edu==5
 
***MSA
label define vlR1210400 1 "not in MSA"  2 "in MSA, not in central city"  3 "in MSA, in central city"  4 "in MSA, not known"  5 "not in country" 

 gen msa12=0 if  CV_MSA_AGE_12_1997==1
 replace msa12=1 if CV_MSA_AGE_12_1997==3
 replace msa12=2 if (CV_MSA_AGE_12_1997==2|CV_MSA_AGE_12_1997==4)
 replace msa12=3 if CV_MSA_AGE_12_1997==-3 |CV_MSA_AGE_12_1997==-4|CV_MSA_AGE_12_1997==5
 
 replace msa12=0 if msa12==3 & CV_MSA_AGE_12_YCHR_1997==1
 replace msa12=1 if msa12==3 & CV_MSA_AGE_12_YCHR_1997==3
 replace msa12=2 if msa12==3 & CV_MSA_AGE_12_YCHR_1997==2

 ***broad msa12
 gen msa12_broad=0 if msa12==0
 replace msa12_broad=1  if msa12>=1 & msa12<=2
 replace msa12_broad=2  if msa12==3
 


forvalues i=0/5 { 

gen mlthw_edunew_ba_`i' =1 if mlthw_edu_ba==`i' 
replace  mlthw_edunew_ba_`i' =0 if mlthw_edunew_ba_`i' ==. & mlthw_edu_ba==0
}
*


 gen reliday= YSAQ_010_1997 if YSAQ_010_1997>=0
 replace  reliday= YSAQ_010_1998 if YSAQ_010_1998>=0 & reliday==.
  replace  reliday= YSAQ_010_1999 if YSAQ_010_1999>=0 & reliday==.
  
  
. rename YHHI_SAQ_282A_2017 YSAQ_282A_2017
. rename YHHI_SAQ_282A_2019 YSAQ_282A_2019

gen reli_ser2000=YSAQ_282A_2000

reshape long YSAQ_010_ YSAQ_282A_ , i(ID) string
rename _j year

tostring ID, gen (id_str)
gen mergeid=id_str+year

gen reli_chanign=YSAQ_282A_
replace reli_chanign= YSAQ_010_ if reli_chanign==.

. merge m:m  mergeid using "/Users/mx2154/Desktop/Desktop - ADUAEI12760LPMX - 1/nlsy/reli_reshape.dta", 
> force
(note: variable year was str4 in the using data, but will be int now)
(label vlR1482600 already defined)
(label vlR1235800 already defined)
(label vlR0536401 already defined)
(label vlR0536300 already defined)

    Result                      Number of obs
    -----------------------------------------
    Not matched                       191,223
        from master                   142,677  (_merge==1)
        from using                     48,546  (_merge==2)

    Matched                           348,838  (_merge==3)
    -----------------------------------------

. drop if _merge==2

bysort ID: egen reli2000=max(reli_ser2000)
drop reli_ser2000

gen reli_ser_2000=0 if reli2000==1|  reli2000==2
replace reli_ser_2000=1 if reli2000==3 |reli2000==4|  reli2000==5
replace reli_ser_2000=2 if reli2000==6
replace reli_ser_2000=3 if reli2000==7| reli2000==8
replace reli_ser_2000=4 if reli2000<1


label define reli2000label 0 "Not religious"  1 "Some religious"  2 "Religious" ///
3 "Very religious"  4 "Missing" ,replace 
label values reli_ser_2000 reli2000label

****religion preference
sort ID mergeidmonth contimonth 
tab YINF_3600_1997
bysort ID: replace YINF_3600_1997=YINF_3600_1997[_n+1] if YINF_3600_1997[_n+1]!=. & ///
YINF_3600_1997==. 
bysort ID: replace YINF_3600_1997=YINF_3600_1997[_n-1] if YINF_3600_1997[_n-1]!=. & ///
YINF_3600_1997==. 

gen reli_conserve=0
replace reli_conserve=1 if YINF_3600_1997==2| YINF_3600_1997==10| YINF_3600_1997==11| ///
YINF_3600_1997==12| YINF_3600_1997==14| YINF_3600_1997==18| YINF_3600_1997==21

 
***********************detailed msa defination 
*age 18
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if diff2_oct==1   , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef se) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis18new =0) vsquish post
estimates save ave18_13sg9
outreg2 using mnlsep18ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis18new =0) vsquish post
estimates save ave18_23sg9
outreg2 using mnlsep18ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append


*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
ib0.reli_ser_2000 if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis18new =0) vsquish post
estimates save ave18_73sg9
outreg2 using mnlsep18ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis18new =0) vsquish post
estimates save ave18_43sg9_1
outreg2 using mnlsep18ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append
*

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis18new =0) vsquish post
estimates save ave18_53sg9_1
outreg2 using mnlsep18ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append
*

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
ib0.reli_ser_2000 ib0.reli_conserve if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 ib0.reli_conserve  gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 ib0.reli_conserve gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
ib0.reli_ser_2000 ib0.reli_conserve ib0.reli_ser_2000##i.reli_conserve if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 ib0.reli_conserve ib0.reli_ser_2000##i.reli_conserve ///
gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 ib0.reli_conserve ib0.reli_ser_2000##i.reli_conserve ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform


*****at age 22
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post
estimates save ave22_13sg9
outreg2 using mnlsep22ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform


margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post
estimates save ave22_23sg9
outreg2 using mnlsep22ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post
estimates save ave22_33sg9
outreg2 using mnlsep22ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post
estimates save ave22_73sg9
outreg2 using mnlsep22ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append


*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post
estimates save ave22_43sg9_1
outreg2 using mnlsep22ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post
estimates save ave22_53sg9_1
outreg2 using mnlsep22ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append
*

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 ib0.reli_conserve if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform


*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000  ib0.reli_conserve  gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform


*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000  ib0.reli_conserve gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 ib0.reli_conserve ib0.reli_ser_2000##i.reli_conserve if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform


*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 ib0.reli_conserve ib0.reli_ser_2000##i.reli_conserve ///
gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform


*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 ib0.reli_conserve ib0.reli_ser_2000##i.reli_conserve ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*age 25
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis25new =0) vsquish post
estimates save ave25_13sg9
outreg2 using mnlsep25ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append


*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis25new =0) vsquish post
estimates save ave25_23sg9
outreg2 using mnlsep25ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append


*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis25new =0) vsquish post
estimates save ave25_33sg9
outreg2 using mnlsep25ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis25new =0) vsquish post
estimates save ave25_73sg9
outreg2 using mnlsep25ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis25new =0) vsquish post
estimates save ave25_43sg9
outreg2 using mnlsep25ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 gpa23 gpa335 gpaabove35 gpamissin enrolled2  if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis25new =0) vsquish post
estimates save ave25_53sg9
outreg2 using mnlsep25ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000  ib0.reli_conserve if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 ib0.reli_conserve gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 ib0.reli_conserve gpa23 gpa335 gpaabove35 gpamissin enrolled2 ///
if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 ib0.reli_conserve ib0.reli_ser_2000##i.reli_conserve ///
if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 ib0.reli_conserve ib0.reli_ser_2000##i.reli_conserve ///
gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 ib0.reli_conserve ib0.reli_ser_2000##i.reli_conserve ///
gpa23 gpa335 gpaabove35 gpamissin enrolled2 ///
if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform


****************************************
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
i.reli_conserve if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis18new =0) vsquish post
estimates save ave18_73sg9r
outreg2 using mnlsep18ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
i.reli_conserve gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis18new =0) vsquish post
estimates save ave18_43sg9_1r
outreg2 using mnlsep18ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append
*

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu1 agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
i.reli_conserve  gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis18new =0) vsquish post
estimates save ave18_53sg9_1r
outreg2 using mnlsep18ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append
*

***************
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
i.reli_conserve if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post
estimates save ave22_73sg9r
outreg2 using mnlsep22ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append


*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
i.reli_conserve gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post
estimates save ave22_43sg9_1r
outreg2 using mnlsep22ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
i.reli_conserve gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post
estimates save ave22_53sg9_1r
outreg2 using mnlsep22ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*age 25
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
i.reli_conserve if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis25new =0) vsquish post
estimates save ave25_33sg9r
outreg2 using mnlsep25ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
i.reli_conserve gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis25new =0) vsquish post
estimates save ave25_43sg9r
outreg2 using mnlsep25ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
i.reli_conserve gpa23 gpa335 gpaabove35 gpamissin enrolled2  if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis25new =0) vsquish post
estimates save ave25_53sg9r
outreg2 using mnlsep25ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append


/*****************************************differnet msa (broad)
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12_broad ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis18new =0) vsquish post
estimates save ave18_13sg9
outreg2 using mnlsep18ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12_broad ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis18new =0) vsquish post
estimates save ave18_23sg9
outreg2 using mnlsep18ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append


*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12_broad ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis18new =0) vsquish post
estimates save ave18_33sg9
outreg2 using mnlsep18ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12_broad ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis18new =0) vsquish post
estimates save ave18_43sg9
outreg2 using mnlsep18ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append
*

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12_broad ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis18new =0) vsquish post
estimates save ave18_53sg9
outreg2 using mnlsep18ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append
*


*****at age 22
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12_broad ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post
estimates save ave22_13sg9
outreg2 using mnlsep22ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12_broad ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform


margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post
estimates save ave22_23sg9
outreg2 using mnlsep22ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12_broad ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post
estimates save ave22_33sg9
outreg2 using mnlsep22ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12_broad ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post
estimates save ave22_43sg9
outreg2 using mnlsep22ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12_broad ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post
estimates save ave22_53sg9
outreg2 using mnlsep22ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*/
/*religion: Comparison to Other NLS Surveys: NLSY79 respondents have provided religious preference information in select survey years. The NLSY79 Child-Young Adult dataset includes both religious preference and religious attendance information. The Original Cohort datasets do not contain information related to religion. *


*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12_broad ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
ib0.reli_ser_2000 if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis18new =0) vsquish post
estimates save ave18_73sg9
outreg2 using mnlsep18ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12_broad ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
ib0.reli_ser_2000 gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis18new =0) vsquish post
estimates save ave18_43sg9_1
outreg2 using mnlsep18ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12_broad ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
ib0.reli_ser_2000 gpa23 gpa335 gpaabove35 gpamissin enrolled2 if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis18new =0) vsquish post
estimates save ave18_53sg9_1
outreg2 using mnlsep18ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*

*age 22
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12_broad ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post
estimates save ave22_73sg9
outreg2 using mnlsep22ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12_broad ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post
estimates save ave22_43sg9_1
outreg2 using mnlsep22ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12_broad ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 gpa23 gpa335 gpaabove35 gpamissin enrolled2  if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post
estimates save ave22_53sg9_1
outreg2 using mnlsep22ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append */


*********************************imputation for marraige
gen new299_im=new299

summ  ori_cohab_birth_exact1  blthw_edu mlthw_edu census_1 census_2 census_3 ///
census_4  censusmissing  BDATE_Y_1997 msa12 msa12_broad ///
agedis18new agedis18_sqnew agedis18_cubicnew  bioandstep1 singlemom1 ///
singledad1 foster hhstruother1 incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
reli_ser_2000 gpa23 gpa335 gpaabove35 gpamissin unprotect_0_im  ///
unprotect_10_im unprotect_above10_im new299_im

mdesc ori_cohab_birth_exact1  blthw_edu mlthw_edu census_1 census_2 census_3 ///
census_4  censusmissing  BDATE_Y_1997 msa12 msa12_broad ///
agedis18new agedis18_sqnew agedis18_cubicnew  bioandstep1 singlemom1 ///
singledad1 foster hhstruother1 incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
reli_ser_2000 reli_conserve gpa23 gpa335 gpaabove35 gpamissin  new299_im


mi set mlong

mi misstable summarize ori_cohab_birth_exact1  blthw_edu mlthw_edu ///
census_1 census_2 census_3 census_4  censusmissing BDATE_Y_1997 msa12 msa12_broad ///
agedis18new agedis18_sqnew agedis18_cubicnew bioandstep1 singlemom1 ///
singledad1 foster hhstruother1 incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin reli_ser_2000 reli_conserve  new299_im, all

drop if mlthw_edu==.
 
mi misstable patterns ori_cohab_birth_exact1  blthw_edu mlthw_edu ///
census_1 census_2 census_3 census_4  censusmissing BDATE_Y_1997 msa12 msa12_broad ///
agedis18new agedis18_sqnew agedis18_cubicnew bioandstep1 singlemom1 ///
singledad1 foster hhstruother1 incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin reli_ser_2000 reli_conserve  new299_im

Missing-value patterns
(1 means complete)

              |   Pattern
    Percent   |  1
  ------------+-------------
       82%    |  1
              |
       18     |  0
  ------------+-------------
      100%    |

Variables are  (1) new299_im


mi register imputed  new299_im


mi impute mvn  new299_im = ori_cohab_birth_exact1  mlthw_edu  blthw_edu census_1 census_2 census_3 census_4  censusmissing BDATE_Y_1997 msa12 msa12_broad ///
agedis18new agedis18_sqnew agedis18_cubicnew bioandstep1 singlemom1 ///
singledad1 foster hhstruother1 incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin reli_ser_2000 reli_conserve , add(10) rseed (53421) saveptrace(trace,replace)

/*mi ptrace describe trace 
mi ptrace use trace, clear*/

*********************
mi estimate, post: mlogit ori_cohab_birth_exact1  ib0.mlthw_edu agedis18new ///
c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12_broad ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
ib0.reli_ser_2000 gpa23 gpa335 gpaabove35 gpamissin enrolled2 new299_im  if  diff2==1  , rrr cluster(ID) 


outreg2 using mn18bim_marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) nor2 addstat ("No. of subjects",e(N)) append eform

mimrgns , dydx(*) predict(outcome(3)) at(agedis18new =0) vsquish post 
estimates save ave18_imp3
outreg2 using impuave_marriage.xls, excel dec(6) cttop (mnl1)  stat (coef se) append


*
mi estimate, post: mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new ///
c.agedis22new#c.agedis22new c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12_broad i.birthyr_1981 i.birthyr_1982 ///
i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 i.singledad1 i.foster ///
i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
ib0.reli_ser_2000 gpa23 gpa335 gpaabove35 gpamissin enrolled2 new299_im   if  diff2==1  , rrr cluster(ID) 

outreg2 using mn22bim_marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) nor2 addstat ("No. of subjects",e(N)) append eform

mimrgns , dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post 
estimates save ave22_imp3
outreg2 using impuave_marriage.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*****


*age 25
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis25new =0) vsquish post
estimates save ave25_13sg9
outreg2 using mnlsep25ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append


*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis25new =0) vsquish post
estimates save ave25_23sg9
outreg2 using mnlsep25ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append


*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis25new =0) vsquish post
estimates save ave25_33sg9
outreg2 using mnlsep25ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis25new =0) vsquish post
estimates save ave25_73sg9
outreg2 using mnlsep25ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 gpa23 gpa335 gpaabove35 gpamissin if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis25new =0) vsquish post
estimates save ave25_43sg9
outreg2 using mnlsep25ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 gpa23 gpa335 gpaabove35 gpamissin enrolled2  if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

margins, dydx(*) predict(outcome(3)) at(agedis25new =0) vsquish post
estimates save ave25_53sg9
outreg2 using mnlsep25ave3sg9.xls, excel dec(6) cttop (mnl1)  stat (coef se) append




****************age 25
mi estimate, post: mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new ///
c.agedis25new#c.agedis25new c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 i.birthyr_1981 i.birthyr_1982 ///
i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 i.singledad1 i.foster ///
i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
ib0.reli_ser_2000 gpa23 gpa335 gpaabove35 gpamissin enrolled2 new299_im   if  diff2==1  , rrr cluster(ID) 

outreg2 using mn25bim_marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) nor2 addstat ("No. of subjects",e(N)) append eform

*
mi estimate, post: mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new ///
c.agedis25new#c.agedis25new c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 i.birthyr_1981 i.birthyr_1982 ///
i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 i.singledad1 i.foster ///
i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
ib0.reli_ser_2000 reli_conserve gpa23 gpa335 gpaabove35 gpamissin enrolled2 new299_im   if  diff2==1  , rrr cluster(ID) 

outreg2 using mn25bim_marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) nor2 addstat ("No. of subjects",e(N)) append eform
*
mi estimate, post: mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new ///
c.agedis25new#c.agedis25new c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 i.birthyr_1981 i.birthyr_1982 ///
i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 i.singledad1 i.foster ///
i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
ib0.reli_conserve gpa23 gpa335 gpaabove35 gpamissin enrolled2 new299_im ///
if  diff2==1  , rrr cluster(ID) 

outreg2 using mn25bim_marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) nor2 addstat ("No. of subjects",e(N)) append eform

 margins mlthw_edu , atmeans predict(outcome(3))
*
mi estimate, post: mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new ///
c.agedis25new#c.agedis25new c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 i.birthyr_1981 i.birthyr_1982 ///
i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 i.singledad1 i.foster ///
i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
ib0.reli_ser_2000 ib0.reli_conserve ib0.reli_ser_2000##i.reli_conserve ///
gpa23 gpa335 gpaabove35 gpamissin enrolled2 new299_im   if  diff2==1  , rrr cluster(ID) 

outreg2 using mn25bim_marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) nor2 addstat ("No. of subjects",e(N)) append eform


*********************age 18
*
mi estimate, post: mlogit ori_cohab_birth_exact1  ib0.mlthw_edu agedis18new ///
c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
ib0.reli_ser_2000 gpa23 gpa335 gpaabove35 gpamissin enrolled2 new299_im  if  diff2==1  , rrr cluster(ID) 

outreg2 using mn18bim_marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) nor2 addstat ("No. of subjects",e(N)) append eform

*
mi estimate, post: mlogit ori_cohab_birth_exact1  ib0.mlthw_edu agedis18new ///
c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
ib0.reli_conserve gpa23 gpa335 gpaabove35 gpamissin enrolled2 new299_im ///
if  diff2==1  , rrr cluster(ID) 

outreg2 using mn18bim_marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) nor2 addstat ("No. of subjects",e(N)) append eform

*
mi estimate, post: mlogit ori_cohab_birth_exact1  ib0.mlthw_edu agedis18new ///
c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
ib0.reli_ser_2000 ib0.reli_conserve gpa23 gpa335 gpaabove35 gpamissin enrolled2 new299_im ///
if  diff2==1  , rrr cluster(ID) 

outreg2 using mn18bim_marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) nor2 addstat ("No. of subjects",e(N)) append eform

*
mi estimate, post: mlogit ori_cohab_birth_exact1  ib0.mlthw_edu agedis18new ///
c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
ib0.reli_ser_2000 ib0.reli_conserve ib0.reli_ser_2000##i.reli_conserve ///
gpa23 gpa335 gpaabove35 gpamissin enrolled2 new299_im ///
if  diff2==1  , rrr cluster(ID) 

outreg2 using mn18bim_marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) nor2 addstat ("No. of subjects",e(N)) append eform

******************age 22
*
mi estimate, post: mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new ///
c.agedis22new#c.agedis22new c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 i.birthyr_1981 i.birthyr_1982 ///
i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 i.singledad1 i.foster ///
i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
ib0.reli_ser_2000 gpa23 gpa335 gpaabove35 gpamissin enrolled2 new299_im   if  diff2==1  , rrr cluster(ID) 

outreg2 using mn22bim_marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) nor2 addstat ("No. of subjects",e(N)) append eform

*
mi estimate, post: mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new ///
c.agedis22new#c.agedis22new c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 i.birthyr_1981 i.birthyr_1982 ///
i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 i.singledad1 i.foster ///
i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
ib0.reli_conserve gpa23 gpa335 gpaabove35 gpamissin enrolled2 new299_im   if  diff2==1  , rrr cluster(ID) 

outreg2 using mn22bim_marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) nor2 addstat ("No. of subjects",e(N)) append eform

*
mi estimate, post: mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new ///
c.agedis22new#c.agedis22new c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 i.birthyr_1981 i.birthyr_1982 ///
i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 i.singledad1 i.foster ///
i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
ib0.reli_ser_2000 ib0.reli_conserve gpa23 gpa335 gpaabove35 gpamissin ///
enrolled2 new299_im   if  diff2==1  , rrr cluster(ID) 

outreg2 using mn22bim_marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) nor2 addstat ("No. of subjects",e(N)) append eform

*
mi estimate, post: mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new ///
c.agedis22new#c.agedis22new c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 i.birthyr_1981 i.birthyr_1982 ///
i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 i.singledad1 i.foster ///
i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
ib0.reli_ser_2000 ib0.reli_conserve ib0.reli_ser_2000##i.reli_conserve ///
gpa23 gpa335 gpaabove35 gpamissin enrolled2 new299_im   if  diff2==1  , rrr cluster(ID) 

outreg2 using mn22bim_marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) nor2 addstat ("No. of subjects",e(N)) append eform


***first sex and religion 
gen sex_ever=0
replace sex_ever=1 if firstsex_conti>= contimonth & firstsex_conti!=.

gen sex_ever_miss=0
replace sex_ever_miss=1 if firstsex_conti==. & orimax2==0 & sex_ever==0

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 ib0.reli_conserve ib0.reli_ser_2000##i.reli_conserve ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 sex_ever sex_ever_miss if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 ib0.reli_conserve ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 sex_ever sex_ever_miss if  diff2==1  , rrr cluster(ID)

outreg2 using mn18marraige.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 ib0.reli_conserve ib0.reli_ser_2000##i.reli_conserve ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 sex_ever sex_ever_miss if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 ib0.reli_conserve ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 sex_ever sex_ever_miss if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 ib0.reli_conserve ib0.reli_ser_2000##i.reli_conserve ///
gpa23 gpa335 gpaabove35 gpamissin enrolled2 sex_ever sex_ever_miss ///
if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 ib0.reli_conserve ///
gpa23 gpa335 gpaabove35 gpamissin enrolled2 sex_ever sex_ever_miss ///
if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform






order ID contimonth firstsex_conti ori_cohab_birth_exact1 minmonth_exact1 orimax* ///
YINF_3600_1997 reli_ser_2000 reli_chanign reli_ser2000 reli2000

. duplicates drop ID, force
save "/Users/mx2154/Desktop/Desktop - ADUAEI12760LPMX - 1/nlsy/mar_cohab_month-marraige and reli.dta"


gen sexfirst=0 if minmonth_exact1 ==.
replace sexfirst=1 if firstsex_conti< minmonth_exact1 & firstsex_conti!=. & minmonth_exact1 !=.
replace  sexfirst=2 if firstsex_conti==minmonth_exact1  & firstsex_conti!=. & minmonth_exact1 !=.
replace  sexfirst=3 if firstsex_conti>minmonth_exact1  & firstsex_conti!=. & minmonth_exact1 !=.
replace  sexfirst=4 if firstsex_conti==.

 bysort reli_ser_2000 : tab sexfirst orimax2
 bysort reli_conserve : tab sexfirst orimax2
 
 tab reli_ser_2000 reli_conserve

 
 
 https://stats.oarc.ucla.edu/stata/code/manually-generate-predicted-probabilities-from-a-multinomial-logistic-regression-in-stata/
 
 ****marriage interaction 
 *using 22*************
 mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 i.birthyr_1981 i.birthyr_1982 ///
i.birthyr_1983 i.birthyr_1984 i.bioandstep1 ib0.mlthw_edu#i.bioandstep1 ///
i.singlemom1 ib0.mlthw_edu#i.singlemom1  i.singledad1 ib0.mlthw_edu#i.singledad1 ///
i.foster ib0.mlthw_edu#i.foster i.hhstruother1 ib0.mlthw_edu#i.hhstruother1

outreg2 using mn22marriage_inter.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*
 mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 ib0.mlthw_edu#i.bioandstep1 ///
i.singlemom1 ib0.mlthw_edu#i.singlemom1  i.singledad1 ib0.mlthw_edu#i.singledad1 ///
i.foster ib0.mlthw_edu#i.foster i.hhstruother1 ib0.mlthw_edu#i.hhstruother1 i.incquar_2 ///
ib0.mlthw_edu#i.incquar_2  i.incquar_3 ib0.mlthw_edu#i.incquar_3 i.incquar_4 ///
ib0.mlthw_edu#i.incquar_4  i.hhinc_missing ib0.mlthw_edu#i.hhinc_missing if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage_inter.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N)) append eform

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 ib0.mlthw_edu#i.bioandstep1 ///
i.singlemom1 ib0.mlthw_edu#i.singlemom1  i.singledad1 ib0.mlthw_edu#i.singledad1 ///
i.foster ib0.mlthw_edu#i.foster i.hhstruother1 ib0.mlthw_edu#i.hhstruother1 i.incquar_2 ///
ib0.mlthw_edu#i.incquar_2  i.incquar_3 ib0.mlthw_edu#i.incquar_3 i.incquar_4 ///
ib0.mlthw_edu#i.incquar_4  i.hhinc_missing ib0.mlthw_edu#i.hhinc_missing ib0.reli_ser_2000 ///
ib0.mlthw_edu#ib0.reli_ser_2000  ib0.reli_conserve ib0.mlthw_edu#ib0.reli_conserve ///
if  diff2==1  , rrr cluster(ID)

outreg2 using mn22marriage_inter.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N)) append eform
*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 ib0.mlthw_edu#i.bioandstep1 ///
i.singlemom1 ib0.mlthw_edu#i.singlemom1  i.singledad1 ib0.mlthw_edu#i.singledad1 ///
i.foster ib0.mlthw_edu#i.foster i.hhstruother1 ib0.mlthw_edu#i.hhstruother1 i.incquar_2 ///
ib0.mlthw_edu#i.incquar_2  i.incquar_3 ib0.mlthw_edu#i.incquar_3 i.incquar_4 ///
ib0.mlthw_edu#i.incquar_4  i.hhinc_missing ib0.mlthw_edu#i.hhinc_missing ib0.reli_ser_2000 ///
ib0.mlthw_edu#ib0.reli_ser_2000  ib0.reli_conserve ib0.mlthw_edu#ib0.reli_conserve ///
gpa23 ib0.mlthw_edu#i.gpa23 gpa335 ib0.mlthw_edu#i.gpa335 gpaabove35 ib0.mlthw_edu#i.gpaabove35 ///
gpamissin ib0.mlthw_edu#i.gpamissin if  diff2==1  , rrr cluster(ID) 

outreg2 using mn22marriage_inter.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N)) append eform
*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 ib0.mlthw_edu#i.bioandstep1 ///
i.singlemom1 ib0.mlthw_edu#i.singlemom1  i.singledad1 ib0.mlthw_edu#i.singledad1 ///
i.foster ib0.mlthw_edu#i.foster i.hhstruother1 ib0.mlthw_edu#i.hhstruother1 i.incquar_2 ///
ib0.mlthw_edu#i.incquar_2  i.incquar_3 ib0.mlthw_edu#i.incquar_3 i.incquar_4 ///
ib0.mlthw_edu#i.incquar_4  i.hhinc_missing ib0.mlthw_edu#i.hhinc_missing ib0.reli_ser_2000 ///
ib0.mlthw_edu#ib0.reli_ser_2000  ib0.reli_conserve ib0.mlthw_edu#ib0.reli_conserve ///
gpa23 ib0.mlthw_edu#i.gpa23 gpa335 ib0.mlthw_edu#i.gpa335 gpaabove35 ib0.mlthw_edu#i.gpaabove35 ///
gpamissin ib0.mlthw_edu#i.gpamissin i.enrolled2 ib0.mlthw_edu#i.enrolled2 if  diff2==1  , rrr cluster(ID) 

outreg2 using mn22marriage_inter.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N)) append eform
 
 **************age 25
*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 i.birthyr_1981 i.birthyr_1982 ///
i.birthyr_1983 i.birthyr_1984 i.bioandstep1 ib0.mlthw_edu#i.bioandstep1 ///
i.singlemom1 ib0.mlthw_edu#i.singlemom1  i.singledad1 ib0.mlthw_edu#i.singledad1 ///
i.foster ib0.mlthw_edu#i.foster i.hhstruother1 ib0.mlthw_edu#i.hhstruother1  if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage_inter.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N)) append eform

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 ib0.mlthw_edu#i.bioandstep1 ///
i.singlemom1 ib0.mlthw_edu#i.singlemom1  i.singledad1 ib0.mlthw_edu#i.singledad1 ///
i.foster ib0.mlthw_edu#i.foster i.hhstruother1 ib0.mlthw_edu#i.hhstruother1 i.incquar_2 ///
ib0.mlthw_edu#i.incquar_2  i.incquar_3 ib0.mlthw_edu#i.incquar_3 i.incquar_4 ///
ib0.mlthw_edu#i.incquar_4  i.hhinc_missing ib0.mlthw_edu#i.hhinc_missing ///
if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage_inter.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N)) append eform

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 ib0.mlthw_edu#i.bioandstep1 ///
i.singlemom1 ib0.mlthw_edu#i.singlemom1  i.singledad1 ib0.mlthw_edu#i.singledad1 ///
i.foster ib0.mlthw_edu#i.foster i.hhstruother1 ib0.mlthw_edu#i.hhstruother1 i.incquar_2 ///
ib0.mlthw_edu#i.incquar_2  i.incquar_3 ib0.mlthw_edu#i.incquar_3 i.incquar_4 ///
ib0.mlthw_edu#i.incquar_4  i.hhinc_missing ib0.mlthw_edu#i.hhinc_missin ib0.reli_ser_2000 ///
ib0.mlthw_edu#ib0.reli_ser_2000  ib0.reli_conserve ib0.mlthw_edu#ib0.reli_conserve if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage_inter.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N)) append eform

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 ib0.mlthw_edu#i.bioandstep1 ///
i.singlemom1 ib0.mlthw_edu#i.singlemom1  i.singledad1 ib0.mlthw_edu#i.singledad1 ///
i.foster ib0.mlthw_edu#i.foster i.hhstruother1 ib0.mlthw_edu#i.hhstruother1 i.incquar_2 ///
ib0.mlthw_edu#i.incquar_2  i.incquar_3 ib0.mlthw_edu#i.incquar_3 i.incquar_4 ///
ib0.mlthw_edu#i.incquar_4  i.hhinc_missing ib0.mlthw_edu#i.hhinc_missin ib0.reli_ser_2000 ///
ib0.mlthw_edu#ib0.reli_ser_2000  ib0.reli_conserve ib0.mlthw_edu#ib0.reli_conserve ///
gpa23 ib0.mlthw_edu#i.gpa23 gpa335 ib0.mlthw_edu#i.gpa335 gpaabove35 ib0.mlthw_edu#i.gpaabove35 ///
gpamissin ib0.mlthw_edu#i.gpamissin if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage_inter.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N)) append eform

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 ib0.mlthw_edu#i.bioandstep1 ///
i.singlemom1 ib0.mlthw_edu#i.singlemom1  i.singledad1 ib0.mlthw_edu#i.singledad1 ///
i.foster ib0.mlthw_edu#i.foster i.hhstruother1 ib0.mlthw_edu#i.hhstruother1 i.incquar_2 ///
ib0.mlthw_edu#i.incquar_2  i.incquar_3 ib0.mlthw_edu#i.incquar_3 i.incquar_4 ///
ib0.mlthw_edu#i.incquar_4  i.hhinc_missing ib0.mlthw_edu#i.hhinc_missin ib0.reli_ser_2000 ///
ib0.mlthw_edu#ib0.reli_ser_2000  ib0.reli_conserve ib0.mlthw_edu#ib0.reli_conserve ///
gpa23 ib0.mlthw_edu#i.gpa23 gpa335 ib0.mlthw_edu#i.gpa335 gpaabove35 ib0.mlthw_edu#i.gpaabove35 ///
gpamissin ib0.mlthw_edu#i.gpamissin i.enrolled2 ib0.mlthw_edu#i.enrolled2  if  diff2==1  , rrr cluster(ID)

outreg2 using mn25marriage_inter.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N)) append eform

**********************************imputation for marraige with interaction 
gen new299_im=new299
gen new299_im_m1=new299*mlthw_edunew_1
gen new299_im_m2=new299*mlthw_edunew_2
gen new299_im_m3=new299*mlthw_edunew_3
gen new299_im_m4=new299*mlthw_edunew_4
gen new299_im_m5=new299*mlthw_edunew_5


mdesc ori_cohab_birth_exact1  blthw_edu mlthw_edu census_1 census_2 census_3 ///
census_4  censusmissing  BDATE_Y_1997 msa12 msa12_broad ///
agedis18new agedis18_sqnew agedis18_cubicnew  bioandstep1 singlemom1 ///
singledad1 foster hhstruother1 incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
reli_ser_2000 reli_conserve gpa23 gpa335 gpaabove35 gpamissin reli_ser_2000 reli_conserve ///
new299_im new299_im_m1 ///
new299_im_m2 new299_im_m3 new299_im_m4 new299_im_m5


mi set mlong

mi misstable summarize ori_cohab_birth_exact1  blthw_edu mlthw_edu ///
census_1 census_2 census_3 census_4  censusmissing BDATE_Y_1997 msa12 msa12_broad ///
agedis18new agedis18_sqnew agedis18_cubicnew bioandstep1 singlemom1 ///
singledad1 foster hhstruother1 incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin reli_ser_2000 reli_conserve  new299_im new299_im_m1 ///
new299_im_m2 new299_im_m3 new299_im_m4 new299_im_m5, all

drop if mlthw_edu==.
 
mi misstable patterns ori_cohab_birth_exact1  blthw_edu mlthw_edu ///
census_1 census_2 census_3 census_4  censusmissing BDATE_Y_1997 msa12 msa12_broad ///
agedis18new agedis18_sqnew agedis18_cubicnew bioandstep1 singlemom1 ///
singledad1 foster hhstruother1 incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin reli_ser_2000 reli_conserve  new299_im new299_im_m1 ///
new299_im_m2 new299_im_m3 new299_im_m4 new299_im_m5

		Pattern
              |   Pattern
    Percent   |  1  2  3  4    5  6
  ------------+---------------------
        5%    |  1  1  1  1    1  1
              |
       35     |  1  1  0  0    0  0
       18     |  0  0  0  0    0  0
       17     |  1  0  1  0    0  0
       16     |  1  0  0  1    0  0
        6     |  1  0  0  0    1  0
        3     |  1  0  0  0    0  1
  ------------+---------------------
      100%    |
	  

Variables	are	(1) new299_im	(2)	new299_im_m1	(3)	new299_im_m4	(4)	new299_im_m2	(5)	new299_im_m3	(6)	new299_im_m5


mi register imputed  new299_im new299_im_m1 ///
new299_im_m2 new299_im_m3 new299_im_m4 new299_im_m5


mi impute mvn  new299_im new299_im_m1 new299_im_m2 new299_im_m3 new299_im_m4 new299_im_m5 = ori_cohab_birth_exact1  mlthw_edu  blthw_edu census_1 census_2 census_3 census_4  censusmissing BDATE_Y_1997 msa12 msa12_broad ///
agedis18new agedis18_sqnew agedis18_cubicnew bioandstep1 singlemom1 ///
singledad1 foster hhstruother1 incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin reli_ser_2000 reli_conserve , add(10) rseed (53421) saveptrace(trace,replace)


mi estimate, post: mlogit ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 ib0.mlthw_edu#i.bioandstep1 ///
i.singlemom1 ib0.mlthw_edu#i.singlemom1  i.singledad1 ib0.mlthw_edu#i.singledad1 ///
i.foster ib0.mlthw_edu#i.foster i.hhstruother1 ib0.mlthw_edu#i.hhstruother1 i.incquar_2 ///
ib0.mlthw_edu#i.incquar_2  i.incquar_3 ib0.mlthw_edu#i.incquar_3 i.incquar_4 ///
ib0.mlthw_edu#i.incquar_4  i.hhinc_missing ib0.mlthw_edu#i.hhinc_missin ib0.reli_ser_2000 ///
ib0.mlthw_edu#ib0.reli_ser_2000  ib0.reli_conserve ib0.mlthw_edu#ib0.reli_conserve ///
gpa23 ib0.mlthw_edu#i.gpa23 gpa335 ib0.mlthw_edu#i.gpa335 gpaabove35 ib0.mlthw_edu#i.gpaabove35 ///
gpamissin ib0.mlthw_edu#i.gpamissin i.enrolled2 ib0.mlthw_edu#i.enrolled2 ib0.new299_im  ///
ib0.mlthw_edu#ib0.new299_im  if  diff2==1  , rrr cluster(ID) 

outreg2 using mn25marriage_inter.xls, excel dec(4) cttop (mnl1)  stat (coef tstat) ///
nor2 addstat ("No. of subjects",e(N)) append eform
***


********fitted values 
*age 25
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2==1  , rrr cluster(ID)

margins   mlthw_edu , atmeans predict(outcome(3)) post
estimates save p25_edu
outreg2 using p25.xls, excel dec(6) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ib1.hhstru_new  if  diff2==1  , rrr cluster(ID)

margins   mlthw_edu hhstru_new , atmeans predict(outcome(3)) post
estimates save p25_edu1
outreg2 using p25.xls, excel dec(6) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ib1.hhstru_new ib1.hhincquar ///
if  diff2==1  , rrr cluster(ID)

margins   mlthw_edu hhstru_new hhincquar  , atmeans predict(outcome(3)) post
estimates save p25_edu2
outreg2 using p25.xls, excel dec(6) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ib1.hhstru_new ib1.hhincquar ///
ib0.reli_ser_2000 ib0.reli_conserve if  diff2==1  , rrr cluster(ID)

margins   mlthw_edu hhstru_new hhincquar reli_ser_2000 reli_conserve  , atmeans predict(outcome(3)) post
estimates save p25_edu3
outreg2 using p25.xls, excel dec(6) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ib1.hhstru_new ib1.hhincquar ///
ib0.reli_ser_2000 ib0.reli_conserve ib1.gpa if  diff2==1  , rrr cluster(ID)

margins   mlthw_edu hhstru_new hhincquar reli_ser_2000 reli_conserve gpa  , atmeans predict(outcome(3)) post
estimates save p25_edu4
outreg2 using p25.xls, excel dec(6) append

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ib1.hhstru_new ib1.hhincquar ///
ib0.reli_ser_2000 ib0.reli_conserve ib1.gpa i.enrolled2  if  diff2==1  , rrr cluster(ID)

margins   mlthw_edu hhstru_new hhincquar reli_ser_2000 reli_conserve gpa enrolled2, ///
atmeans predict(outcome(3)) post
estimates save p25_edu5
outreg2 using p25.xls, excel dec(6) append

*
mi estimate, post: mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis25new ///
c.agedis25new#c.agedis25new c.agedis25new#c.agedis25new#c.agedis25new ib0.mlthw_edu#c.agedis25new ///
ib0.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 i.birthyr_1981 i.birthyr_1982 ///
i.birthyr_1983 i.birthyr_1984 ib1.hhstru_new ib1.hhincquar ib0.reli_ser_2000 ib0.reli_conserve ///
ib1.gpa i.enrolled2 new299_im   if  diff2==1  , rrr cluster(ID) 

mimrgns  mlthw_edu hhstru_new hhincquar reli_ser_2000 reli_conserve gpa enrolled2 , ///
atmeans predict(outcome(3)) post
estimates save p25_edu6
outreg2 using p25.xls, excel dec(6) append




***
estimates use p25_edu
estimates store p25_edu
outreg2 using p25_nostar.xls, excel dec(6) noaster append

estimates use p25_edu1
estimates store p25_edu1
outreg2 using p25_nostar.xls, excel dec(6) noaster append

estimates use p25_edu2
estimates store p25_edu2
outreg2 using p25_nostar.xls, excel dec(6) noaster append

estimates use p25_edu3
estimates store p25_edu3
outreg2 using p25_nostar.xls, excel dec(6) noaster append

estimates use p25_edu4
estimates store p25_edu4
outreg2 using p25_nostar.xls, excel dec(6) noaster append

estimates use p25_edu5
estimates store p25_edu5
outreg2 using p25_nostar.xls, excel dec(6) noaster append

estimates use p25_edu6
estimates store p25_edu6
outreg2 using p25_nostar.xls, excel dec(6) noaster append


***only see birth and marraige as the first family formation 
. order ID contimonth minmonth_exactnew minmonth_exactnew_oct MAR_STATUS_ MAR_STATUS_all ///
MAR_COHABITATION_ MAR_COHABITATION_all CV_CHILD_BIRTH_MONTH_01_2019
 sort ID contimonth
 order ID contimonth  mergeidmonth
. order ID _merge

bysort ID: egen mlthw_edu_new=max(mlthw_edu)
drop mlthw_edu
rename mlthw_edu_new mlthw_edu


*identify the first marraige month
sort ID contimonth
bysort ID: gen fmar_mon=1 if MAR_STATUS[_n]==2 & MAR_STATUS[_n-1]<2

bysort ID: gen fmar_mon1=contimonth if fmar_mon==1
bysort ID: egen fmar_mon2=max(fmar_mon1)

bysort ID: egen fmar_mon3=min(fmar_mon1) if fmar_mon1!=.


*
gen mar_birth=ori_cohab_birth_exact1_oct if  diff2_oct==1 & orimax2!=1

*marriage before conception 
gen minmonth_birth_oct=CV_CHILD_BIRTH_MONTH_01_2019-9 if CV_CHILD_BIRTH_MONTH_01_2019>0
bysort ID: gen mar_b_birth=1 if minmonth_birth_oct>=fmar_mon2 & orimax2==1

bysort ID: replace mar_b_birth=0 if minmonth_birth_oct<fmar_mon2 & orimax2==1
bysort ID: egen mar_b_birth1=max(mar_b_birth)

replace mar_b_birth1=. if contimonth>fmar_mon2 &  mar_b_birth1==1
replace mar_b_birth1=. if contimonth>minmonth_birth_oct &  mar_b_birth1==0

*
replace mar_birth=3 if  mar_b_birth1==1 & mar_birth==. & contimonth>=173
replace mar_birth=2 if  mar_b_birth1==0 & mar_birth==. & contimonth>=173

replace mar_birth=0 if contimonth<minmonth_birth_oct  & mar_birth==2
replace mar_birth=0 if contimonth<fmar_mon2 & mar_birth==3

*used to be cohab first, no conception, no marriage so far
replace mar_birth=0 if orimax2==1 &  orimax_marbirth==. & mar_birth==. & contimonth>=173

bysort ID: egen mar_birthtemp=max(mar_birth)  
replace mar_birth=mar_birthtemp if mar_birthtemp==0 & mar_birth==.
******************marrriage at 22 

/*mlogit mar_birth ib2.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984, rrr cluster(ID)

outreg2 using mn22marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*
mlogit mar_birth ib2.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1, rrr cluster(ID)

outreg2 using mn22marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*

mlogit mar_birth ib2.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing, rrr cluster(ID)

outreg2 using mn22marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*
mlogit mar_birth ib2.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin , rrr cluster(ID)

outreg2 using mn22marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*
mlogit mar_birth ib2.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  , rrr cluster(ID)

outreg2 using mn22marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*

mlogit mar_birth ib2.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 i.new299_1new   , rrr cluster(ID)

outreg2 using mn22marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

****
******************for marriage ave

mlogit mar_birth ib2.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984, rrr cluster(ID)

margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post 
estimates save ave22_marbirth21
outreg2 using ave22_marbirth_formar.xls, excel dec(6) cttop (mnl1)  stat (coef se) append 

*
mlogit mar_birth ib2.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1, rrr cluster(ID)

margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post 
estimates save ave22_marbirth22
outreg2 using ave22_marbirth_formar.xls, excel dec(6) cttop (mnl1)  stat (coef se) append 

*
mlogit mar_birth ib2.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing, rrr cluster(ID)

margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post 
estimates save ave22_marbirth23
outreg2 using ave22_marbirth_formar.xls, excel dec(6) cttop (mnl1)  stat (coef se) append 

*
mlogit mar_birth ib2.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin , rrr cluster(ID)

margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post 
estimates save ave22_marbirth24
outreg2 using ave22_marbirth_formar.xls, excel dec(6) cttop (mnl1)  stat (coef se) append 

*
mlogit mar_birth ib2.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  , rrr cluster(ID)

margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post 
estimates save ave22_marbirth25
outreg2 using ave22_marbirth_formar.xls, excel dec(6) cttop (mnl1)  stat (coef se) append 

*
mlogit mar_birth ib2.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 i.new299_1new   , rrr cluster(ID)

margins, dydx(*) predict(outcome(3)) at(agedis22new =0) vsquish post 
estimates save ave22_marbirth26
outreg2 using ave22_marbirth_formar.xls, excel dec(6) cttop (mnl1)  stat (coef se) append 
*/

************
***********birth still use b-less than hs as references
******************

mlogit mar_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984, rrr cluster(ID)

outreg2 using mn22marbirth_b.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*
mlogit mar_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1, rrr cluster(ID)

outreg2 using mn22marbirth_b.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*

mlogit mar_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing, rrr cluster(ID)

outreg2 using mn22marbirth_b.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*
mlogit mar_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin , rrr cluster(ID)

outreg2 using mn22marbirth_b.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*
mlogit mar_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  , rrr cluster(ID)

outreg2 using mn22marbirth_b.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*

mlogit mar_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 i.new299_1new   , rrr cluster(ID)

outreg2 using mn22marbirth_b.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

************
*average marginal eggects, b as the reference
******************

mlogit mar_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984, rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_marbirth11_b
outreg2 using ave22_marbirth_b.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit mar_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1, rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_marbirth12_b
outreg2 using ave22_marbirth_b.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit mar_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing, rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_marbirth13_b
outreg2 using ave22_marbirth_b.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit mar_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_marbirth14_b
outreg2 using ave22_marbirth_b.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit mar_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_marbirth15_b
outreg2 using ave22_marbirth_b.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*
mlogit mar_birth i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 i.new299_1new   , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_marbirth16_b
outreg2 using ave22_marbirth_b.xls, excel dec(6) cttop (mnl1)  stat (coef se) append

*************

*the average mariginal effect at the age of 25 (18 is early for marriage, right for ealy and premarital birth. 25 sounds reasonable for the first marriage )

******************

mlogit mar_birth ib2.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984, rrr cluster(ID)

outreg2 using mn25marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*
mlogit mar_birth ib2.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1, rrr cluster(ID)

outreg2 using mn25marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*

mlogit mar_birth ib2.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing, rrr cluster(ID)

outreg2 using mn25marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*
mlogit mar_birth ib2.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin , rrr cluster(ID)

outreg2 using mn25marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*
mlogit mar_birth ib2.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  , rrr cluster(ID)

outreg2 using mn25marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*

mlogit mar_birth ib2.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 i.new299_1new   , rrr cluster(ID)

outreg2 using mn25marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

***ave for marriage
mlogit mar_birth ib2.mlthw_edu  agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984, rrr cluster(ID)

margins, dydx(*) predict(outcome(3)) at(agedis25new =0) vsquish post 
estimates save ave25_marbirth21
outreg2 using ave25_marbirth_formar.xls, excel dec(6) cttop (mnl1)  stat (coef se) append 

*
mlogit mar_birth ib2.mlthw_edu  agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1, rrr cluster(ID)

margins, dydx(*) predict(outcome(3)) at(agedis25new =0) vsquish post 
estimates save ave25_marbirth22
outreg2 using ave25_marbirth_formar.xls, excel dec(6) cttop (mnl1)  stat (coef se) append 

*

mlogit mar_birth ib2.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing, rrr cluster(ID)

margins, dydx(*) predict(outcome(3)) at(agedis25new =0) vsquish post 
estimates save ave25_marbirth23
outreg2 using ave25_marbirth_formar.xls, excel dec(6) cttop (mnl1)  stat (coef se) append 

*
mlogit mar_birth ib2.mlthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin , rrr cluster(ID)

margins, dydx(*) predict(outcome(3)) at(agedis25new =0) vsquish post 
estimates save ave25_marbirth24
outreg2 using ave25_marbirth_formar.xls, excel dec(6) cttop (mnl1)  stat (coef se) append 

*
mlogit mar_birth ib2.mlthw_edu  agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  , rrr cluster(ID)

margins, dydx(*) predict(outcome(3)) at(agedis25new =0) vsquish post 
estimates save ave25_marbirth25
outreg2 using ave25_marbirth_formar.xls, excel dec(6) cttop (mnl1)  stat (coef se) append 

*

mlogit mar_birth ib2.mlthw_edu  agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 i.new299_1new   , rrr cluster(ID)

margins, dydx(*) predict(outcome(3)) at(agedis25new =0) vsquish post 
estimates save ave25_marbirth26
outreg2 using ave25_marbirth_formar.xls, excel dec(6) cttop (mnl1)  stat (coef se) append 




*************

mlogit mar_birth i.blthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984, rrr cluster(ID)

outreg2 using mn25marbirth_b.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*
mlogit mar_birth i.blthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1, rrr cluster(ID)

outreg2 using mn25marbirth_b.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*

mlogit mar_birth i.blthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing, rrr cluster(ID)

outreg2 using mn25marbirth_b.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*
mlogit mar_birth i.blthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin , rrr cluster(ID)

outreg2 using mn25marbirth_b.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*
mlogit mar_birth i.blthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  , rrr cluster(ID)

outreg2 using mn25marbirth_b.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*

mlogit mar_birth i.blthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 i.new299_1new   , rrr cluster(ID)

outreg2 using mn25marbirth_b.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

************average marginal effects at age of 25
mlogit mar_birth i.blthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984, rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis25new =0) vsquish post 
estimates save ave25_marbirth11_b
outreg2 using ave25_marbirth.xls, excel dec(6) cttop (mnl1)  stat (coef se) append 

*
mlogit mar_birth i.blthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1, rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis25new =0) vsquish post 
estimates save ave25_marbirth12_b
outreg2 using ave25_marbirth.xls, excel dec(6) cttop (mnl1)  stat (coef se) append 

*

mlogit mar_birth i.blthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing, rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis25new =0) vsquish post 
estimates save ave25_marbirth13_b
outreg2 using ave25_marbirth.xls, excel dec(6) cttop (mnl1)  stat (coef se) append 

*
mlogit mar_birth i.blthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis25new =0) vsquish post 
estimates save ave25_marbirth14_b
outreg2 using ave25_marbirth.xls, excel dec(6) cttop (mnl1)  stat (coef se) append 

*
mlogit mar_birth i.blthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis25new =0) vsquish post 
estimates save ave25_marbirth15_b
outreg2 using ave25_marbirth.xls, excel dec(6) cttop (mnl1)  stat (coef se) append 

*

mlogit mar_birth i.blthw_edu agedis25new c.agedis25new#c.agedis25new ///
c.agedis25new#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new ///
i.mlthw_edu#c.agedis25new#c.agedis25new i.mlthw_edu#c.agedis25new#c.agedis25new#c.agedis25new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 i.new299_1new   , rrr cluster(ID)

margins, dydx(*) predict(outcome(2)) at(agedis25new =0) vsquish post 
estimates save ave25_marbirth16_b
outreg2 using ave25_marbirth.xls, excel dec(6) cttop (mnl1)  stat (coef se) append 



****still see what will happen at age of 18
******************
mlogit mar_birth ib2.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984, rrr cluster(ID)

outreg2 using mn18marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*
mlogit mar_birth ib2.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1, rrr cluster(ID)

outreg2 using mn18marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*

mlogit mar_birth ib2.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing, rrr cluster(ID)

outreg2 using mn18marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*
mlogit mar_birth ib2.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin , rrr cluster(ID)

outreg2 using mn18marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*
mlogit mar_birth ib2.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  , rrr cluster(ID)

outreg2 using mn18marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*

mlogit mar_birth ib2.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 i.new299_1new   , rrr cluster(ID)

outreg2 using mn18marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*****<hs as the ref
******************
mlogit mar_birth i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984, rrr cluster(ID)

outreg2 using mn18marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*
mlogit mar_birth i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1, rrr cluster(ID)

outreg2 using mn18marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*

mlogit mar_birth i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing, rrr cluster(ID)

outreg2 using mn18marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*
mlogit mar_birth i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin , rrr cluster(ID)

outreg2 using mn18marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*
mlogit mar_birth i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  , rrr cluster(ID)

outreg2 using mn18marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*

mlogit mar_birth i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 i.new299_1new   , rrr cluster(ID)

outreg2 using mn18marbirth.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform



*************birth
mlogit mar_birth i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984, rrr cluster(ID)

outreg2 using mn18marbirth_b.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*
mlogit mar_birth i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1, rrr cluster(ID)

outreg2 using mn18marbirth_b.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*

mlogit mar_birth i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing, rrr cluster(ID)

outreg2 using mn18marbirth_b.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*
mlogit mar_birth i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin , rrr cluster(ID)

outreg2 using mn18marbirth_b.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*
mlogit mar_birth i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  , rrr cluster(ID)

outreg2 using mn18marbirth_b.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
*

mlogit mar_birth i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 i.new299_1new   , rrr cluster(ID)

outreg2 using mn18marbirth_b.xls, excel dec(2) cttop (mnl1)  stat (coef tstat) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform


*****
bysort ID: egen orimax_marbirth=max(mar_birth)
bysort ID: egen orimax21=max(orimax2)

drop orimax2
rename orimax21 orimax2

*
gen YMAR_4300_01_2001=.
forvalues i=1/7{
replace YMAR_4300_01_2001=	`i' if YMAR_4300_01_00000`i'_2001==1 & YMAR_4300_01_2001==.
replace YMAR_4300_01_2001=	99 if YMAR_4300_01_000999_2001==1 & YMAR_4300_01_2001==.
}

gen YMAR_4300_01_2002=.
forvalues i=1/7{
replace YMAR_4300_01_2002=	`i' if YMAR_4300_01_00000`i'_2002==1 & YMAR_4300_01_2002==.
replace YMAR_4300_01_2002=	99 if YMAR_4300_01_000999_2002==1 & YMAR_4300_01_2002==.
}

gen YMAR_4300_01_2003=.
forvalues i=1/7{
replace YMAR_4300_01_2003=	`i' if YMAR_4300_01_00000`i'_2003==1 & YMAR_4300_01_2003==.
}
replace YMAR_4300_01_2003=	99 if YMAR_4300_01_000999_2003==1 & YMAR_4300_01_2003==.

forvalue j=4/9{
gen YMAR_4300_01_200`j'=.
forvalues i=1/7{
replace YMAR_4300_01_200`j'=`i' if YMAR_4300_01_00000`i'_200`j'==1 & YMAR_4300_01_200`j'==.

}
}


gen YMAR_4300_01_2010=.
		forvalues i=1/7{
		replace YMAR_4300_01_2010=`i' if YMAR_4300_01_00000`i'_2010==1 & YMAR_4300_01_2010==.
		}



forvalue j=11(2)19{
gen YMAR_4300_01_20`j'=.
forvalues i=1/7{
replace YMAR_4300_01_20`j'=`i' if YMAR_4300_01_00000`i'_20`j'==1 & YMAR_4300_01_20`j'==.

}
}


gen par_r=YMAR_4300_01_1997 if  YMAR_4300_01_1997>0

forvalue j=1998/2010{

replace par_r= YMAR_4300_01_`j' if  YMAR_4300_01_`j'>0 & par_r==.

}

forvalue j=2011(2)2019{

replace par_r= YMAR_4300_01_`j' if  YMAR_4300_01_`j'>0 & par_r==.

}

*
gen par_cohab_age=.
forvalue j=1997/2010{

replace par_cohab_age= YMAR_3200_01_`j' if  YMAR_3200_01_`j'>0 & par_cohab_age==.

}
forvalue j=2011(2)2021{

replace par_cohab_age= YMAR_3200_01_`j' if  YMAR_3200_01_`j'>0 & par_cohab_age==.

}

***
egen cohabage_partner= cut(par_cohab_age), at(14,16,18,20,22,24,26,28,30,32,34,36,38)
*conception 9 months
tab  cohabage_partner  mlthw_edu if  orimax2==1 &  eventage_yr1<=28

tab  cohabage_partner  eventage_yr1 if  orimax2==1 &  eventage_yr1<=28 & mlthw_edu==0
tab  cohabage_partner  eventage_yr1 if  orimax2==1 &  eventage_yr1<=28 & mlthw_edu==1
tab  cohabage_partner  eventage_yr1 if  orimax2==1 &  eventage_yr1<=28 & mlthw_edu==2
tab  cohabage_partner  eventage_yr1 if  orimax2==1 &  eventage_yr1<=28 & mlthw_edu==3
tab  cohabage_partner  eventage_yr1 if  orimax2==1 &  eventage_yr1<=28 & mlthw_edu==4
tab  cohabage_partner  eventage_yr1 if  orimax2==1 &  eventage_yr1<=28 & mlthw_edu==5

bysort mlthw_edu:  tab par_r orimax2


 if   mlthw_edu==0 
tab eventage_yr1  orimax2 if   mlthw_edu==1
tab eventage_yr1  orimax2 if   mlthw_edu==2

tab  eventage_yr1  orimax2 if  mlthw_edu==3
tab  eventage_yr1  orimax2 if  mlthw_edu==4
tab  eventage_yr1  orimax2 if  mlthw_edu==5

*birth first
tab  eventage_yr1  orimax if  mlthw_edu==0 
tab eventage_yr1  orimax if   mlthw_edu==1
tab eventage_yr1  orimax if   mlthw_edu==2

tab  eventage_yr1  orimax if   mlthw_edu==3
tab  eventage_yr1  orimax if   mlthw_edu==4
tab  eventage_yr1  orimax if   mlthw_edu==5 

*
/*SAMPLING_WEIGHT_CC. Provides a weight for everyone who participated in that particular round of surveying, using a special method of combining the cross-sectional and over-sample cases. This method makes the weight of an oversampled person invariant to which sample the person was drawn from. This reduces the variation in weights and hence improves the statistical efficiency of weighted estimators.
*/*
 use "/Users/mx2154/Desktop/Desktop - ADUAEI12760LPMX - 1/nlsy/for pub/oct/mar_cohab_birth_bandw_LT_OCT.dta"
tab orimax2 mlthw_edu1  [w= SAMPLING_PANEL_WEIGHT_1997]
tab orimax2 mlthw_edu1  [aw= SAMPLING_PANEL_WEIGHT_1997]

*birth first
tab orimax1 mlthw_edu1 [w= SAMPLING_PANEL_WEIGHT_1997],m
tab orimax1 mlthw_edu1 [aw= SAMPLING_PANEL_WEIGHT_1997] ,m


*weighted desc tables
/*Types of Weights
Weights are found under the "Sample Design & Screening" Area of Interest in Investigator. Weights also can be found by searching for the word "Weight" in the Word in Title search option. There are two sampling weight variables available in each round:

SAMPLING_WEIGHT_CC. Provides a weight for everyone who participated in that particular round of surveying, using a special method of combining the cross-sectional and over-sample cases. This method makes the weight of an oversampled person invariant to which sample the person was drawn from. This reduces the variation in weights and hence improves the statistical efficiency of weighted estimators.

SAMPLING_PANEL_WEIGHT. This weights only people who are in every round from 1 to N. Those not in every round get a 0 weight. It is used when data are needed on individuals who participated in all rounds.

Rounds 1 and 2 also include two additional sampling weight variables, SAMPLING_WEIGHT and CS_SAMPLING_WEIGHT. Starting in round 3, NLS survey staff created a new more statistically efficient method of calculating survey weights called the "Cumulating Cases" strategy. Because the new method provided better information, weights were recalculated starting with round 1. However, since research had already been published using the original sampling weight variables, the original variables were left in the database to enable older work to be replicated.*/
putexcel set desc1allmonths_whole_weight.xls, replace

local abc  C  
local group  diff2_oct

local inde intact1 bioandstep1 singlemom1 singledad1 foster hhstruother1 gpalessthan2 ///
gpa23 gpa335 gpaabove35 gpamissin incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing enrolled2 ///
reli_ser_2000_0 reli_ser_2000_1 reli_ser_2000_2 reli_ser_2000_3 reli_ser_2000_4

local j=4
local k=5

foreach  y in intact1 bioandstep1 singlemom1 singledad1 foster hhstruother1 gpalessthan2 ///
gpa23 gpa335 gpaabove35 gpamissin incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing  enrolled2 {
forvalue i=1/1{

local var: word `i' of `group'
local n: word `i' of `abc'

qui sum `y' if  `var' ==1  &  mlthw_edu!=. & diff2_oct==1 [aw= weight]

local mean: dis  `r(mean)' , %9.2f
local N: dis  `r(N)' , %9.2f

putexcel B`j'=("`y'") `n'`j'=("`mean'") `n'`k'=("`N'") 
}

local j=`j'+2 
local k=`k'+2
}
*****
*
sum  enrolled2  if agedis18new<0 &  diff2==1 [aw= weight] , d
sum  enrolled2 if agedis22new<0 & diff2==1  [aw= weight] , d
*

putexcel set desc1allmonths_whole.xls, replace

local abc  C  
local group  diff2_oct

local inde intact1 bioandstep1 singlemom1 singledad1 foster hhstruother1 gpalessthan2 ///
gpa23 gpa335 gpaabove35 gpamissin incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing enrolled2 ///
reli_ser_2000_0 reli_ser_2000_1 reli_ser_2000_2 reli_ser_2000_3 reli_ser_2000_4

local j=4
local k=5

foreach  y in intact1 bioandstep1 singlemom1 singledad1 foster hhstruother1 gpalessthan2 ///
gpa23 gpa335 gpaabove35 gpamissin incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing  enrolled2 {
forvalue i=1/1{

local var: word `i' of `group'
local n: word `i' of `abc'

qui sum `y' if  `var' ==1  &  mlthw_edu!=. & diff2_oct==1 

local mean: dis  `r(mean)' , %9.2f
local N: dis  `r(N)' , %9.2f

putexcel B`j'=("`y'") `n'`j'=("`mean'") `n'`k'=("`N'") 
}

local j=`j'+2 
local k=`k'+2
}
*****
**************************************************************************

putexcel set descallmonths_weightedbymomedu.xls, replace

local abc  C D E F G H
local group  mlthw_edunew_0 mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5

local inde intact1 bioandstep1 singlemom1 singledad1 foster hhstruother1 gpalessthan2 ///
gpa23 gpa335 gpaabove35 gpamissin incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing enrolled2 ///
reli_ser_2000_0 reli_ser_2000_1 reli_ser_2000_2 reli_ser_2000_3 reli_ser_2000_4 

local j=4
local g=6

foreach  y in intact1 bioandstep1 singlemom1 singledad1 foster hhstruother1 gpalessthan2 ///
gpa23 gpa335 gpaabove35 gpamissin incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing  enrolled2 ///
reli_ser_2000_0 reli_ser_2000_1 reli_ser_2000_2 reli_ser_2000_3 reli_ser_2000_4 {
forvalue i=1/6 { 

local var: word `i' of `group'
local n: word `i' of `abc'

qui sum `y' if  `var'==1 & diff2_oct==1 [aw= weight]

local mean: dis  `r(mean)' , %9.2f
local N: dis `r(N)', %9.2f

putexcel B`j'=("`y'") `n'`j'=("`mean'") `n'`g'=("`N'")  
 

 }

local j=`j'+3
local g=`g'+3
}
*****
putexcel set descallmonths_bymomedu.xls, replace

local abc  C D E F G H
local group  mlthw_edunew_0 mlthw_edunew_1 mlthw_edunew_2 mlthw_edunew_3 mlthw_edunew_4 mlthw_edunew_5

local inde intact1 bioandstep1 singlemom1 singledad1 foster hhstruother1 gpalessthan2 ///
gpa23 gpa335 gpaabove35 gpamissin incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing enrolled2 ///
reli_ser_2000_0 reli_ser_2000_1 reli_ser_2000_2 reli_ser_2000_3 reli_ser_2000_4 

local j=4
local g=6

foreach  y in intact1 bioandstep1 singlemom1 singledad1 foster hhstruother1 gpalessthan2 ///
gpa23 gpa335 gpaabove35 gpamissin incquar_1 incquar_2 incquar_3 incquar_4 hhinc_missing  enrolled2 ///
reli_ser_2000_0 reli_ser_2000_1 reli_ser_2000_2 reli_ser_2000_3 reli_ser_2000_4 {
forvalue i=1/6 { 

local var: word `i' of `group'
local n: word `i' of `abc'

qui sum `y' if  `var'==1 & diff2_oct==1 

local mean: dis  `r(mean)' , %9.2f
local N: dis `r(N)', %9.2f

putexcel B`j'=("`y'") `n'`j'=("`mean'") `n'`g'=("`N'")  
 

 }

local j=`j'+3
local g=`g'+3
}
*****
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1  ,d 
}
*
********************************************************************
ssc install misum
mi convert flong

foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 [aw= weight] ,d 
}
*
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 [w= weight]  ,d 
}
*
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1  ,d 
}
*

**********
*******************************************************************
count
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 &  agedis18new<0 ,d 
}
*
********************************************************************
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 &  agedis22new<0 [aw= weight] ,d 
}
*
foreach x in noactive_im active_noun_im active_ls10_im active_mt10_im{ 
misum `x' if  diff2==1 &  agedis22new<0  ,d 
}
*

*****************
gen white=1 if  mlthw_edu >=0 &  mlthw_edu <=2
replace white=0 if  mlthw_edu >=3 &  mlthw_edu <=5

gen black=0 if  mlthw_edu >=0 &  mlthw_edu <=2
replace black=1 if  mlthw_edu >=3 &  mlthw_edu <=5

*******SDT and test for the disadvantaged patterns*
*old table a10. a11 (new a2 and a3)
mlogit ori_cohab_birth_exact1_oct ib1.biomomedu  white ib1.biomomedu##white ///
agedis18new c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984   if  diff2_oct==1  , rrr cluster(ID)

outreg2 using psd18.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

mlogit ori_cohab_birth_exact1_oct ib1.biomomedu  white ib1.biomomedu##white ///
agedis18new c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ib1.biomomedunew#c.agedis18new ///
ib1.biomomedu#c.agedis18new#c.agedis18new ///
ib1.biomomedu#c.agedis18new#c.agedis18new#c.agedis18new ///
white#c.agedis18new  white#c.agedis18new#c.agedis18new ///
white#c.agedis18new#c.agedis18new#c.agedis18new   if  diff2_oct==1  , rrr cluster(ID)

outreg2 using psd18.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform


mlogit ori_cohab_birth_exact1_oct ib1.biomomedu  white ib1.biomomedu##white ///
agedis18new c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ib1.biomomedu#c.agedis18new ///
ib1.biomomedu#c.agedis18new#c.agedis18new ///
ib1.biomomedu#c.agedis18new#c.agedis18new#c.agedis18new ///
white#c.agedis18new  white#c.agedis18new#c.agedis18new ///
white#c.agedis18new#c.agedis18new#c.agedis18new white#ib1.biomomedu#c.agedis18new ///
white#ib1.biomomedu#c.agedis18new#c.agedis18new ///
white#ib1.biomomedu#c.agedis18new#c.agedis18new#c.agedis18new  if  diff2_oct==1  , rrr cluster(ID)

outreg2 using psd18.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

mlogit ori_cohab_birth_exact1_oct ib1.biomomedu  black ib1.biomomedu##black ///
agedis18new c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ib1.biomomedu#c.agedis18new ///
ib1.biomomedu#c.agedis18new#c.agedis18new ///
ib1.biomomedu#c.agedis18new#c.agedis18new#c.agedis18new ///
black#c.agedis18new  black#c.agedis18new#c.agedis18new ///
black#c.agedis18new#c.agedis18new#c.agedis18new black#ib1.biomomedu#c.agedis18new ///
black#ib1.biomomedu#c.agedis18new#c.agedis18new ///
black#ib1.biomomedu#c.agedis18new#c.agedis18new#c.agedis18new  if  diff2_oct==1  , rrr cluster(ID)

outreg2 using psd18.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*******center 22
mlogit ori_cohab_birth_exact1_oct ib1.biomomedu  white ib1.biomomedu##white ///
agedis22new c.agedis22new#c.agedis22new  c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984   if  diff2_oct==1  , rrr cluster(ID)

outreg2 using psd22.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

mlogit ori_cohab_birth_exact1_oct ib1.biomomedu  white ib1.biomomedu##white ///
agedis22new c.agedis22new#c.agedis22new  c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  ib1.biomomedu#c.agedis22new ///
ib1.biomomedu#c.agedis22new#c.agedis22new ///
ib1.biomomedu#c.agedis22new#c.agedis22new#c.agedis22new ///
white#c.agedis22new  white#c.agedis22new#c.agedis22new ///
white#c.agedis22new#c.agedis22new#c.agedis22new  if  diff2_oct==1  , rrr cluster(ID)

outreg2 using psd22.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform



mlogit ori_cohab_birth_exact1_oct ib1.biomomedu  white ib1.biomomedu##white ///
agedis22new c.agedis22new#c.agedis22new  c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ib1.biomomedu#c.agedis22new ///
ib1.biomomedu#c.agedis22new#c.agedis22new ib1.biomomedu#c.agedis22new#c.agedis22new#c.agedis22new ///
white#c.agedis22new  white#c.agedis22new#c.agedis22new ///
white#c.agedis22new#c.agedis22new#c.agedis22new ///
white#ib1.biomomedu#c.agedis22new white#ib1.biomomedu#c.agedis22new#c.agedis22new ///
white#ib1.biomomedu#c.agedis22new#c.agedis22new#c.agedis22new if  diff2_oct==1  , rrr cluster(ID)

outreg2 using psd22.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform
**black as the ref

mlogit ori_cohab_birth_exact1_oct ib1.biomomedu  black ib1.biomomedu##black ///
agedis22new c.agedis22new#c.agedis22new  c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ib1.biomomedu#c.agedis22new ///
ib1.biomomedu#c.agedis22new#c.agedis22new ib1.biomomedu#c.agedis22new#c.agedis22new#c.agedis22new ///
black#c.agedis22new  black#c.agedis22new#c.agedis22new ///
black#c.agedis22new#c.agedis22new#c.agedis22new ///
black#ib1.biomomedu#c.agedis22new black#ib1.biomomedu#c.agedis22new#c.agedis22new ///
black#ib1.biomomedu#c.agedis22new#c.agedis22new#c.agedis22new if  diff2_oct==1  , rrr cluster(ID)

outreg2 using psd22.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*identify length of first cohab, fir marraige
*first cohab length
gen f_cohab_length=1 if MAR_COHABITATION_all==101

bysort ID: gen f_cohab_start=1 if f_cohab_length[_n-1]==. & f_cohab_length[_n]==1
gen f_cohab_start_contimonth=contimonth if f_cohab_start==1
bysort ID: egen f_cohab_start_contimonth1=max(f_cohab_start_contimonth)

bysort ID: gen f_cohab_end=1 if f_cohab_length[_n]==1 & f_cohab_length[_n+1]==.
gen f_cohab_end_contimonth=contimonth if f_cohab_end==1
bysort ID: egen f_cohab_end_contimonth1=max(f_cohab_end_contimonth)

order ID contimonth MAR_COHABITATION_all f_cohab_length f_cohab_start f_cohab_start_contimonth f_cohab_end f_cohab_end_contimonth



**mar first
bysort ID: gen ori_cohab_birth1=3 if ori_cohab_birth_n==1 & MAR_STATUS_[_n]==2 & ///
MAR_STATUS_[_n-1]<=0 
bysort ID: gen eventmar=contimonth if ori_cohab_birth1==3 
bysort ID: egen eventmar1=max(eventmar)
bysort ID: egen eventmar2=min(eventmar)

bysort ID: egen ori_cohab_birth2=max(ori_cohab_birth1) if eventmar2<=minmonth2

replace ori_cohab_birth_n=3 if ori_cohab_birth_n==1 & ori_cohab_birth2==3
drop ori_cohab_birth1 ori_cohab_birth2

bysort ID : egen orimax_n=max(ori_cohab_birth_n)

gen f_mar_length=1 if  MAR_STATUS_all==3|MAR_STATUS_all==4
bysort ID: gen f_divorse_start=1 if f_mar_length[_n-1]==. & f_mar_length[_n]==1
gen f_mar_end_contimonth=contimonth if f_divorse_start==1

bysort ID : egen f_mar_end_contimonth1=max(f_mar_end_contimonth)


*cohab first, had a non marital birth within this cohab (weighted and non weighted)
gen conception_contimonth=CV_CHILD_BIRTH_MONTH_01_2021-9 if ///
CV_CHILD_BIRTH_MONTH_01_2021>0 & CV_CHILD_BIRTH_MONTH_01_2021!=.

*first birth
gen firstbirth=0 if conception_contimonth!=.
replace firstbirth=1 if orimax2==2
replace firstbirth=2 if orimax2==1 & ///
f_cohab_start_contimonth1<=conception_contimonth & f_cohab_end_contimonth1>=conception_contimonth
replace firstbirth=3 if orimax2==3 & f_mar_end_contimonth1>=conception_contimonth

tab firstbirth
tab firstbirth [aw= SAMPLING_PANEL_WEIGHT_1997]

tab  mlthw_edu firstbirth
tab mlthw_edu firstbirth [aw= SAMPLING_PANEL_WEIGHT_1997]

gen cohab_firstbirth=0 if CV_CHILD_BIRTH_MONTH_01_2021!=.
replace cohab_firstbirth=1 if f_cohab_start_contimonth1<=CV_CHILD_BIRTH_MONTH_01_2021 & (orimax2==1)&  f_cohab_length==1 & f_cohab_start_contimonth1!=.
*birth in the first cohab

 
 *
 use "/Users/mx2154/Desktop/marriage/cohab_all_f.dta"
  gen first_kid_birth=0 if contimonth==CV_CHILD_BIRTH_MONTH_01_2021 & CV_CHILD_BIRTH_MONTH_01_2021>0
 order ID contimonth CV_CHILD_BIRTH_MONTH_01_2021 first_kid_birth
 replace first_kid_birth=1 if  MAR_STATUS_all==0  & first_kid_birth==0
 *single birth
  replace first_kid_birth=2 if  MAR_STATUS_all==1 & first_kid_birth==0
 *cohab birth
  replace first_kid_birth=3 if  MAR_STATUS_all==2 & first_kid_birth==0
  *marriage birth
 
 . tab first_kid_birth
 . tab first_kid_birth
 bysort ID: egen first_kid_birth_all=max(first_kid_birth)
 
 *
   gen first_kid_con1=0 if contimonth==CV_CHILD_BIRTH_MONTH_01_2021-9 & CV_CHILD_BIRTH_MONTH_01_2021>0
 replace first_kid_con=1 if  MAR_STATUS_all==0  & first_kid_con==0
 *single birth
  replace first_kid_con=2 if  MAR_STATUS_all==1 & first_kid_con==0
 *cohab birth
  replace first_kid_con=3 if  MAR_STATUS_all==2 & first_kid_con==0
  *marriage birth
  
bysort ID: egen orimax2_a9=max(orimax2)

 . merge 1:1 ID using "/Users/mx2154/Desktop/Desktop - ADUAEI12760LPMX - 1/nlsy/for pub/oct/cohab_all_f_allfirstbirth.dta"
(label vlU4943200 already defined)
(label vlU3438100 already defined)
(label vlR1482600 already defined)
(label vlR1235800 already defined)
(label vlR0538700 already defined)
(label vlR0538600 already defined)
(label vlR0536401 already defined)
(label vlR0536300 already defined)
(label vlE7024210 already defined)
(label vlE7014210 already defined)

    Result                      Number of obs
    -----------------------------------------
    Not matched                         1,272
        from master                         0  (_merge==1)
        from using                      1,272  (_merge==2)

    Matched                             3,061  (_merge==3)

	

 
first_kid_birth_all first_kid_con_all

 use "/Users/mx2154/Desktop/Desktop - ADUAEI12760LPMX - 1/nlsy/cohab-birth/for pub/oct/mar_cohab_birth_bandw_OCT.dta", replace
replace first_kid_con=1 if first_kid_con==0 & orimax2_a9==2

*****table a9
 /*not precedded by any event 
 *single birth, no cohab/marriage before +single birth,  cohab/mar  before*/
 tab first_kid_con orimax2_a9 [aw=SAMPLING_PANEL_WEIGHT_1997]
*cohab birth, and from first cohab  
 tab first_kid_con orimax2_a9 if f_cohab_length==1 [aw=SAMPLING_PANEL_WEIGHT_1997]
 *cohab birth, and from later cohab or marriage=cohab birth and cohab is first event-
 *first kid is cohab birth and cohab is the first event

bysort black: tab first_kid_con orimax2_a9
bysort black: tab first_kid_con orimax2_a9 if f_cohab_length==1
 

bysort ID: egen orimax2_a9birth=max(orimax)
tab first_kid_birth orimax2_a9birth  [aw=SAMPLING_PANEL_WEIGHT_1997]
tab first_kid_birth orimax2_a9birth if f_cohab_length==1 [aw=SAMPLING_PANEL_WEIGHT_1997]

bysort black: tab first_kid_birth orimax2_a9birth
bysort black: tab first_kid_birth orimax2_a9birth if f_cohab_length==1
 
/*
 . tab first_kid_con_all
 . tab first_kid_con_all black [aw=SAMPLING_PANEL_WEIGHT_1997]
  . tab first_kid_con_all orimax2  [aw=SAMPLING_PANEL_WEIGHT_1997]
  . tab first_kid_con_all black 
 
 . tab first_kid_birth_all
 . tab first_kid_birth_all [aw=SAMPLING_PANEL_WEIGHT_1997]
 . tab first_kid_birth_all black [aw=SAMPLING_PANEL_WEIGHT_1997]
  . tab first_kid_birth_all black 
*/


*****table A10 
use "/Users/mx2154/Desktop/Desktop - ADUAEI12760LPMX - 1/nlsy/cohab-birth/for pub/oct/mar_cohab_birth_bandw_LT_OCT.dta"
*single birth, no cohab/marriage before
tab black if first_kid_con==1 & orimax2_a9==2 [aw=SAMPLING_PANEL_WEIGHT_1997]
sum momedi_yr if first_kid_con==1 & orimax2_a9==2 [aw=SAMPLING_PANEL_WEIGHT_1997]
tab  biomomedu if first_kid_con==1 & orimax2_a9==2 [aw=SAMPLING_PANEL_WEIGHT_1997] 
sum cv_income_gross_yr_1997 if first_kid_con==1 & orimax2_a9==2 [aw=SAMPLING_PANEL_WEIGHT_1997]
tab incquar_1 if first_kid_con==1 & orimax2_a9==2 [aw=SAMPLING_PANEL_WEIGHT_1997]
tab incquar_2 if first_kid_con==1 & orimax2_a9==2 [aw=SAMPLING_PANEL_WEIGHT_1997]
tab incquar_3 if first_kid_con==1 & orimax2_a9==2 [aw=SAMPLING_PANEL_WEIGHT_1997]
tab incquar_4 if first_kid_con==1 & orimax2_a9==2 [aw=SAMPLING_PANEL_WEIGHT_1997]
sum age_firstbirth if first_kid_con==1 & orimax2_a9==2 [aw=SAMPLING_PANEL_WEIGHT_1997]
 
 
tab black if first_kid_con==1 & orimax2_a9==1 [aw=SAMPLING_PANEL_WEIGHT_1997]
sum momedi_yr if first_kid_con==1 & orimax2_a9==1 [aw=SAMPLING_PANEL_WEIGHT_1997]
tab  biomomedu if first_kid_con==1 & orimax2_a9==1 [aw=SAMPLING_PANEL_WEIGHT_1997] 
sum cv_income_gross_yr_1997 if first_kid_con==1 & orimax2_a9==1 [aw=SAMPLING_PANEL_WEIGHT_1997]
tab incquar_1 if first_kid_con==1 & orimax2_a9==1 [aw=SAMPLING_PANEL_WEIGHT_1997]
tab incquar_2 if first_kid_con==1 & orimax2_a9==1 [aw=SAMPLING_PANEL_WEIGHT_1997]
tab incquar_3 if first_kid_con==1 & orimax2_a9==1 [aw=SAMPLING_PANEL_WEIGHT_1997]
tab incquar_4 if first_kid_con==1 & orimax2_a9==1 [aw=SAMPLING_PANEL_WEIGHT_1997]
sum age_firstbirth if first_kid_con==1 & orimax2_a9==1 [aw=SAMPLING_PANEL_WEIGHT_1997]


tab black if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length==1 [aw=SAMPLING_PANEL_WEIGHT_1997]
sum momedi_yr if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length==1  [aw=SAMPLING_PANEL_WEIGHT_1997]
tab  biomomedu if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length==1  [aw=SAMPLING_PANEL_WEIGHT_1997] 
sum cv_income_gross_yr_1997 if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length==1  [aw=SAMPLING_PANEL_WEIGHT_1997]
tab incquar_1 if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length==1  [aw=SAMPLING_PANEL_WEIGHT_1997]
tab incquar_2 if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length==1  [aw=SAMPLING_PANEL_WEIGHT_1997]
tab incquar_3 if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length==1  [aw=SAMPLING_PANEL_WEIGHT_1997]
tab incquar_4 if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length==1  [aw=SAMPLING_PANEL_WEIGHT_1997]
sum age_firstbirth if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length==1  [aw=SAMPLING_PANEL_WEIGHT_1997]


tab black if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length!=1 [aw=SAMPLING_PANEL_WEIGHT_1997]
 sum momedi_yr if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length!=1  [aw=SAMPLING_PANEL_WEIGHT_1997]
tab  biomomedu if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length!=1   [aw=SAMPLING_PANEL_WEIGHT_1997] 
sum cv_income_gross_yr_1997 if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length!=1   [aw=SAMPLING_PANEL_WEIGHT_1997]
tab incquar_1 if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length!=1 [aw=SAMPLING_PANEL_WEIGHT_1997]
tab incquar_2 if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length!=1  [aw=SAMPLING_PANEL_WEIGHT_1997]
tab incquar_3 if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length!=1  [aw=SAMPLING_PANEL_WEIGHT_1997]
tab incquar_4 if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length!=1   [aw=SAMPLING_PANEL_WEIGHT_1997]
sum age_firstbirth if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length!=1  [aw=SAMPLING_PANEL_WEIGHT_1997]

 tab black if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length!=1 [aw=SAMPLING_PANEL_WEIGHT_1997]
 sum momedi_yr if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length!=1  [aw=SAMPLING_PANEL_WEIGHT_1997]
tab  biomomedu if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length!=1   [aw=SAMPLING_PANEL_WEIGHT_1997] 
sum cv_income_gross_yr_1997 if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length!=1   [aw=SAMPLING_PANEL_WEIGHT_1997]
tab incquar_1 if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length!=1 [aw=SAMPLING_PANEL_WEIGHT_1997]
tab incquar_2 if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length!=1  [aw=SAMPLING_PANEL_WEIGHT_1997]
tab incquar_3 if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length!=1  [aw=SAMPLING_PANEL_WEIGHT_1997]
tab incquar_4 if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length!=1   [aw=SAMPLING_PANEL_WEIGHT_1997]
sum age_firstbirth if first_kid_con==2 & orimax2_a9==1 &  f_cohab_length!=1  [aw=SAMPLING_PANEL_WEIGHT_1997]

 
 
 
 
 
 
gen momedi_yr= cv_hgc_bio_mom_1997 if  cv_hgc_bio_mom_1997>0 &  cv_hgc_bio_mom_1997!=.

gen age_firstbirth=(CV_CHILD_BIRTH_MONTH_01_2021- birthday_conti)/12 if CV_CHILD_BIRTH_MONTH_01_2021> 0 & CV_CHILD_BIRTH_MONTH_01_2021!=.

tab orimax2 black, r
tab orimax2 black [aw=SAMPLING_PANEL_WEIGHT_1997] , r

sum momedi_yr if orimax2==2 & black==1
sum momedi_yr if orimax2==2 & black==1 [aw=SAMPLING_PANEL_WEIGHT_1997] 

sum cv_income_gross_yr_1997 if orimax2==2 & black==1
sum cv_income_gross_yr_1997 if orimax2==2 & black==1 [aw=SAMPLING_PANEL_WEIGHT_1997] 

sum  age_firstbirth if orimax2==2 & black==1
sum  age_firstbirth if orimax2==2 & black==1 [aw=SAMPLING_PANEL_WEIGHT_1997] 
**
sum momedi_yr if orimax2==2 
sum momedi_yr if orimax2==2 [aw=SAMPLING_PANEL_WEIGHT_1997] 

sum cv_income_gross_yr_1997 if orimax2==2 
sum cv_income_gross_yr_1997 if orimax2==2  [aw=SAMPLING_PANEL_WEIGHT_1997] 

sum  age_firstbirth if orimax2==2 
sum  age_firstbirth if orimax2==2  [aw=SAMPLING_PANEL_WEIGHT_1997] 

*****
 use "/Users/mx2154/Desktop/Desktop - ADUAEI12760LPMX - 1/nlsy/cohab-birth/for pub/oct/mar_cohab_birth_bandw_OCT.dta"
 
 gen first_nonmbirth=1 if  orimax2_a9==1 &  first_kid_con ==1
 replace first_nonmbirth=1 if  orimax2_a9==2 &  first_kid_con ==1
 replace  first_nonmbirth=1 if  orimax2_a9==1 & first_kid_con ==2 
 
 tab  first_nonmbirth black, r
  tab  first_nonmbirth black [aw=SAMPLING_PANEL_WEIGHT_1997] , r

sum momedi_yr if first_nonmbirth==1 & black==1
sum momedi_yr if first_nonmbirth==1 & black==1 [aw=SAMPLING_PANEL_WEIGHT_1997] 

sum cv_income_gross_yr_1997 if first_nonmbirth==1 & black==1
sum cv_income_gross_yr_1997 if first_nonmbirth==1 & black==1 [aw=SAMPLING_PANEL_WEIGHT_1997] 

sum  age_firstbirth if first_nonmbirth==1 & black==1
sum  age_firstbirth if first_nonmbirth==1 & black==1 [aw=SAMPLING_PANEL_WEIGHT_1997] 

*
sum momedi_yr if first_nonmbirth==1 
sum momedi_yr if first_nonmbirth==1 [aw=SAMPLING_PANEL_WEIGHT_1997] 

sum cv_income_gross_yr_1997 if first_nonmbirth==1
sum cv_income_gross_yr_1997 if first_nonmbirth==1  [aw=SAMPLING_PANEL_WEIGHT_1997] 

sum  age_firstbirth if first_nonmbirth==1 
sum  age_firstbirth if first_nonmbirth==1  [aw=SAMPLING_PANEL_WEIGHT_1997] 

foreach x in incquar_1 incquar_2 incquar_3 incquar_4{
	 bysort ID: egen `x'1=max(`x')
	 drop `x'
	 rename `x'1 `x'
}
 

***
tab black if CV_CHILD_BIRTH_MONTH_01_2021> 0 & CV_CHILD_BIRTH_MONTH_01_2021!=.
tab black if CV_CHILD_BIRTH_MONTH_01_2021> 0 & CV_CHILD_BIRTH_MONTH_01_2021!=. [aw=SAMPLING_PANEL_WEIGHT_1997] 

sum momedi_yr if  CV_CHILD_BIRTH_MONTH_01_2021> 0 & CV_CHILD_BIRTH_MONTH_01_2021!=. & black==1
sum momedi_yr if  CV_CHILD_BIRTH_MONTH_01_2021> 0 & CV_CHILD_BIRTH_MONTH_01_2021!=. & black==1 [aw=SAMPLING_PANEL_WEIGHT_1997] 

sum cv_income_gross_yr_1997 if  CV_CHILD_BIRTH_MONTH_01_2021> 0 & CV_CHILD_BIRTH_MONTH_01_2021!=. & black==1
sum cv_income_gross_yr_1997 if  CV_CHILD_BIRTH_MONTH_01_2021> 0 & CV_CHILD_BIRTH_MONTH_01_2021!=. & black==1 [aw=SAMPLING_PANEL_WEIGHT_1997] 

sum  age_firstbirth if black==1
sum  age_firstbirth if  black==1 [aw=SAMPLING_PANEL_WEIGHT_1997] 

*
sum momedi_yr if  CV_CHILD_BIRTH_MONTH_01_2021> 0 & CV_CHILD_BIRTH_MONTH_01_2021!=. 
sum momedi_yr if  CV_CHILD_BIRTH_MONTH_01_2021> 0 & CV_CHILD_BIRTH_MONTH_01_2021!=. [aw=SAMPLING_PANEL_WEIGHT_1997] 

sum cv_income_gross_yr_1997 if  CV_CHILD_BIRTH_MONTH_01_2021> 0 & CV_CHILD_BIRTH_MONTH_01_2021!=.
sum cv_income_gross_yr_1997 if  CV_CHILD_BIRTH_MONTH_01_2021> 0 & CV_CHILD_BIRTH_MONTH_01_2021!=. [aw=SAMPLING_PANEL_WEIGHT_1997] 

sum  age_firstbirth 
sum  age_firstbirth  [aw=SAMPLING_PANEL_WEIGHT_1997] 




*underlying regs with coef and se for rr***
mlogit ori_cohab_birth_exact1_oct i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2_oct==1  , rrr cluster(ID)

outreg2 using mn18cohab_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform


*
mlogit ori_cohab_birth_exact1_oct i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 if  diff2_oct==1   , rrr cluster(ID)

outreg2 using mn18cohab_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform


*
mlogit ori_cohab_birth_exact1_oct i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
if  diff2_oct==1  , rrr cluster(ID)

outreg2 using mn18cohab_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

*
mlogit ori_cohab_birth_exact1_oct i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin if  diff2_oct==1  , rrr cluster(ID)

outreg2 using mn18cohab_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

*
 mlogit ori_cohab_birth_exact1_oct  i.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2  if  diff2_oct==1  , rrr cluster(ID)

outreg2 using mn18cohab_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform



**at age 18 for birth 
*
mlogit ori_cohab_birth_exact1_oct i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if diff2_oct==1  , rrr cluster(ID)

outreg2 using mn18birth_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

*
mlogit ori_cohab_birth_exact1_oct i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1  if diff2_oct==1  , rrr cluster(ID)

outreg2 using mn18birth_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

*
mlogit ori_cohab_birth_exact1_oct i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
if diff2_oct==1  , rrr cluster(ID)

outreg2 using mn18birth_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

*
mlogit ori_cohab_birth_exact1_oct i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin  if diff2_oct==1  , rrr cluster(ID)

outreg2 using mn18birth_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

*
mlogit ori_cohab_birth_exact1_oct i.blthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new ///
i.blthw_edu#c.agedis18new#c.agedis18new i.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin  i.enrolled2 if diff2_oct==1  , rrr cluster(ID)

outreg2 using mn18birth_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

*****at age 22 for cohab 
*
mlogit ori_cohab_birth_exact1_oct i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if diff2_oct==1 , rrr cluster(ID)

outreg2 using mn22cohab_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

*
mlogit ori_cohab_birth_exact1_oct i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 if  diff2_oct==1 , rrr cluster(ID)

outreg2 using mn22cohab_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform


*
mlogit ori_cohab_birth_exact1_oct i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
if diff2_oct==1 , rrr cluster(ID)

outreg2 using mn22cohab_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform


*
mlogit ori_cohab_birth_exact1_oct i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin if diff2_oct==1 , rrr cluster(ID)

outreg2 using mn22cohab_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform


*
mlogit ori_cohab_birth_exact1_oct i.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin  i.enrolled2  if diff2_oct==1 , rrr cluster(ID)

outreg2 using mn22cohab_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1)  symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform


*age 22 for birth
mlogit ori_cohab_birth_exact1_oct  i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ////
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984   if  diff2_oct==1  , rrr cluster(ID)

outreg2 using mn22birth_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*
mlogit ori_cohab_birth_exact1_oct  i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ////
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 if  diff2_oct==1  , rrr cluster(ID)

outreg2 using mn22birth_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*
mlogit ori_cohab_birth_exact1_oct  i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
if  diff2_oct==1  , rrr cluster(ID)

outreg2 using mn22birth_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*
mlogit ori_cohab_birth_exact1_oct  i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new ///
i.blthw_edu#c.agedis22new#c.agedis22new i.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin if  diff2_oct==1  , rrr cluster(ID)

outreg2 using mn22birth_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform

*
mlogit ori_cohab_birth_exact1_oct i.blthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.blthw_edu#c.agedis22new ///
ib0.blthw_edu#c.agedis22new#c.agedis22new ib0.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin i.enrolled2 if  diff2_oct==1  , rrr cluster(ID)

outreg2 using mn22birth_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N), "chi sqrd",e(chi2)) append eform



*********************
use "/Users/mx2154/Desktop/Desktop - ADUAEI12760LPMX - 1/nlsy/cohab-birth/for pub/oct/imp_oct.dta", clear

mi estimate, post: mlogit ori_cohab_birth_exact1_oct i.mlthw_edu agedis18new ///
c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new ///
i.mlthw_edu#c.agedis18new#c.agedis18new i.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 bioandstep1 singlemom1 singledad1 foster hhstruother1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin enrolled2 active_noun_im active_ls10_im active_mt10_im  if  diff2==1  , rrr cluster(ID) 

outreg2 using mn18bim_cohab_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

**
mi estimate, post: mlogit ori_cohab_birth_exact1_oct ib0.blthw_edu agedis18new ///
c.agedis18new#c.agedis18new c.agedis18new#c.agedis18new#c.agedis18new ib0.blthw_edu#c.agedis18new ///
ib0.blthw_edu#c.agedis18new#c.agedis18new ib0.blthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 bioandstep1 singlemom1 singledad1 foster hhstruother1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin enrolled2 active_noun_im active_ls10_im active_mt10_im  if  diff2==1, rrr cluster(ID) 
outreg2 using mn18bim_birth_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform


***********************
mi estimate, post: mlogit ori_cohab_birth_exact1_oct   i.mlthw_edu agedis22new ///
c.agedis22new#c.agedis22new c.agedis22new#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new ///
i.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
bioandstep1 singlemom1 singledad1 foster hhstruother1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin active_noun_im active_ls10_im active_mt10_im enrolled2   if  diff2==1  , rrr cluster(ID) 

outreg2 using mn22bim_cohab_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

/*mimrgns , dydx(*) predict(outcome(1)) at(agedis22new =0) vsquish post 
estimates save ave22_imp1_onrvar
outreg2 using impuave_cohab_onrvar.xls, excel dec(6) cttop (mnl1)  stat (coef se) append
*/

*******
mi estimate, post: mlogit ori_cohab_birth_exact1_oct   ib0.blthw_edu agedis22new c.agedis22new#c.agedis22new c.agedis22new#c.agedis22new#c.agedis22new ///
ib0.blthw_edu#c.agedis22new  ib0.blthw_edu#c.agedis22new#c.agedis22new ///
ib0.blthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 ///
bioandstep1 singlemom1 singledad1 foster hhstruother1 incquar_2 incquar_3 incquar_4 hhinc_missing ///
gpa23 gpa335 gpaabove35 gpamissin active_noun_im active_ls10_im active_mt10_im  enrolled2 if  diff2==1  , rrr cluster(ID)

outreg2 using mn22bim_birth_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

/*mimrgns , dydx(*) predict(outcome(2)) at(agedis22new =0) vsquish post 
estimates save ave22_imp2_onrvar
outreg2 using impuave_birth_onrvar.xls, excel dec(6) cttop (mnl1)  stat (coef se) append
*/
*******

*marriage rr***
*age 18
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if diff2_oct==1   , rrr cluster(ID)

outreg2 using mn18marraige_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 if  diff2_oct==1  , rrr cluster(ID)

outreg2 using mn18marraige_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
if  diff2_oct==1  , rrr cluster(ID)

outreg2 using mn18marraige_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform
*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis18new c.agedis18new#c.agedis18new ///
c.agedis18new#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new ///
ib0.mlthw_edu#c.agedis18new#c.agedis18new ib0.mlthw_edu#c.agedis18new#c.agedis18new#c.agedis18new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing  ///
ib0.reli_ser_2000 ib0.reli_conserve if  diff2_oct==1 , rrr cluster(ID)

outreg2 using mn18marraige_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform

*****at age 22
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 if  diff2_oct==1  , rrr cluster(ID)

outreg2 using mn22marraige_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform
*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984  i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 if  diff2_oct==1  , rrr cluster(ID)

outreg2 using mn22marraige_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform
*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new i.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
if diff2_oct==1  , rrr cluster(ID)

outreg2 using mn22marraige_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform
*
mlogit ori_cohab_birth_exact1 ib0.mlthw_edu agedis22new c.agedis22new#c.agedis22new ///
c.agedis22new#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new ///
ib0.mlthw_edu#c.agedis22new#c.agedis22new ib0.mlthw_edu#c.agedis22new#c.agedis22new#c.agedis22new ///
i.census_2 i.census_3 i.census_4  i.censusmissing ib0.msa12 ///
i.birthyr_1981 i.birthyr_1982 i.birthyr_1983 i.birthyr_1984 i.bioandstep1 i.singlemom1 ///
i.singledad1 i.foster i.hhstruother1 i.incquar_2 i.incquar_3 i.incquar_4  i.hhinc_missing ///
ib0.reli_ser_2000 ib0.reli_conserve if  diff2_oct==1  , rrr cluster(ID)

outreg2 using mn22marraige_rr.xls, excel dec(2) cttop (mnl1)  stat (coef se) ///
alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, +) nor2 addstat ("No. of subjects",e(N)) append eform


