/* Problem Statement 2 SAS Code*/


/* Pre-Processing */
/* import data 'crashes' */

filename MVCc 
	'/folders/myfolders/group project/Motor Vehicle Collisions - Crashes.json';
libname MVCc JSON fileref=MVCc;
libname gp '/folders/myfolders/group project';

data gp.crash; set MVCc.data;
run;



/* run every time open the file */

libname gp '/folders/myfolders/group project';
data gp.preprocess_crash ; set gp.crash;
run;


data gp.try_crash; set gp.preprocess_crash;
run;


/* drop the columns*/
data gp.try_crash; set gp.try_crash;
	drop ordinal_root ordinal_data element1 element2 element3 element4 element5 element6 element7 element8
	element12 element15 element16 element17 element18;
run;

/* change the form of the colomns and rename */
data gp.try_crash; set gp.try_crash;
	format time time. ;
	time = input(element10,time.);
	drop element10;
	
	format collision_ID 8.;
	collision_ID = input(element32,8.);
	drop element32;
	
	format ppl_injured ppl_killed pedes_injured pedes_killed cyc_injured
	cyc_killed motor_injured motor_killed 4.;
	ppl_injured = input(element19, 4.);
	ppl_killed = input(element20, 4.);
	pedes_injured = input(element21, 4.);
	pedes_killed= input(element22, 4.);
	cyc_injured= input(element23, 4.);
	cyc_killed = input(element24, 4.);
	motor_injured= input(element25, 4.);
	motor_killed= input(element26, 4.);	
	drop element19 element20 element21 element22 element23 element24 element25 element26 ;
	
 	rename element9=date element11=BOROUGH element13=LATITUDE element14=LONGITUDE 
 	element27=contributing_vehicle_1 element28=contributing_vehicle_2 element29=contributing_vehicle_3 
 	element30=contributing_vehicle_4 element31=contributing_vehicle_5
 	element33=vehicle_type_1 element34=vehicle_type_2 element35=vehicle_type_3 
 	element36=vehicle_type_4 element37=vehicle_type_5;
run;

/* form the date and time variables */
data gp.try_crash; set gp.try_crash;
	date_year = substr(date,1,4);
	date_month = substr(date,6,2);
	date_day = substr(date,9,2);
	drop date;
	format date2 MMDDYY10.;
	date2 = input(cats(date_month,date_day,date_year), MMDDYY10.);
	drop date_month date_day date_year;
	rename date2 = date;
run;


/* count the number of vehicles involved based on the contributing_vehicle */


data gp.try_crash_count; set gp.try_crash;
	do;
	if contributing_vehicle_1='' then contributing_vehicle_1_2=0;
	else contributing_vehicle_1_2 = 1;
	end;
	drop contributing_vehicle_1;
	rename contributing_vehicle_1_2 = contributing_vehicle_1;
run ;
data gp.try_crash_count; set gp.try_crash_count;
	do;
	if contributing_vehicle_2='' then contributing_vehicle_2_2=0;
	else contributing_vehicle_2_2 = 1;
	end;
	drop contributing_vehicle_2;
	rename contributing_vehicle_2_2 = contributing_vehicle_2;
run ;
data gp.try_crash_count; set gp.try_crash_count;
	do;
	if contributing_vehicle_3='' then contributing_vehicle_3_2=0;
	else contributing_vehicle_3_2 = 1;
	end;
	drop contributing_vehicle_3;
	rename contributing_vehicle_3_2 = contributing_vehicle_3;
run ;
data gp.try_crash_count; set gp.try_crash_count;
	do;
	if contributing_vehicle_4='' then contributing_vehicle_4_2=0;
	else contributing_vehicle_4_2 = 1;
	end;
	drop contributing_vehicle_4;
	rename contributing_vehicle_4_2 = contributing_vehicle_4;
run ;
data gp.try_crash_count; set gp.try_crash_count;
	do;
	if contributing_vehicle_5='' then contributing_vehicle_5_2=0;
	else contributing_vehicle_5_2 = 1;
	end;
	drop contributing_vehicle_5;
	rename contributing_vehicle_5_2 = contributing_vehicle_5;
run ;

data data gp.try_crash_count; set gp.try_crash_count;
	DO i = 1 to contributing_vehicle_1;
		vehicle_num_1 = contributing_vehicle_1 + contributing_vehicle_2 +contributing_vehicle_3+contributing_vehicle_4+contributing_vehicle_5;
	end;
	drop i contributing_vehicle_1 contributing_vehicle_2 contributing_vehicle_3 contributing_vehicle_4 contributing_vehicle_5;
run;

/* count the number of vehicles involved based on the contributing_vehicle */

data gp.try_crash_count; set gp.try_crash_count;
	do;
	if vehicle_type_1='' then vehicle_type_1_2=0;
	else vehicle_type_1_2 = 1;
	end;
	drop vehicle_type_1;
	rename vehicle_type_1_2 = vehicle_type_1;
run ;
data gp.try_crash_count; set gp.try_crash_count;
	do;
	if vehicle_type_2='' then vehicle_type_2_2=0;
	else vehicle_type_2_2 = 1;
	end;
	drop vehicle_type_2;
	rename vehicle_type_2_2 = vehicle_type_2;
run ;
data gp.try_crash_count; set gp.try_crash_count;
	do;
	if vehicle_type_3='' then vehicle_type_3_2=0;
	else vehicle_type_3_2 = 1;
	end;
	drop vehicle_type_3;
	rename vehicle_type_3_2 = vehicle_type_3;
run ;
data gp.try_crash_count; set gp.try_crash_count;
	do;
	if vehicle_type_4='' then vehicle_type_4_2=0;
	else vehicle_type_4_2 = 1;
	end;
	drop vehicle_type_4;
	rename vehicle_type_4_2 = vehicle_type_4;
run ;
data gp.try_crash_count; set gp.try_crash_count;
	do;
	if vehicle_type_5='' then vehicle_type_5_2=0;
	else vehicle_type_5_2 = 1;
	end;
	drop vehicle_type_5;
	rename vehicle_type_5_2 = vehicle_type_5;
run ;

data gp.try_crash_count; set gp.try_crash_count;
	DO i = 1 to vehicle_type_1;
		vehicle_num_2 = vehicle_type_1 + vehicle_type_2 +vehicle_type_3+vehicle_type_4+vehicle_type_5;
	end;
	drop i vehicle_type_1 vehicle_type_2 vehicle_type_3 vehicle_type_4 vehicle_type_5;
run;


/* calculatet the maximum number of vehicles involved */
data gp.try_crash_count; set gp.try_crash_count;
	vehicle_num = max(vehicle_num_1,vehicle_num_2);
	drop vehicle_num_1 vehicle_num_2;
run;

proc export 
  data=GP.TRY_CRASH_COUNT
  dbms=csv 
  outfile="/folders/myfolders/group project/20200310/crash_count.csv" 
  replace;
run;

/* Pre-processing Done*/






/* check the multiple collison in 2019*/
data gp.multi_collision; set gp.try_crash_count;
	where vehicle_num > 2;
run;

data gp.multi_collision2019; set gp.multi_collision;
	where year(date) = 2019;
run;



/* load vehicle dataset in 2019 */
libname gpvehi '/folders/myfolders/group project/20200310';

FILENAME REFFILE '/folders/myfolders/group project/20200310/19 data/vehicles19.xlsx';

PROC IMPORT DATAFILE=REFFILE
	DBMS=XLSX
	OUT=GPVEHI.VEHICLE_2019;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=GPVEHI.VEHICLE_2019; RUN;



/* do inner join and keep variables we want: cars involved in multi-vehicle-collisions*/
PROC SQL; 
CREATE TABLE GPVEHI.MULTI_VEHICLE_COLLISION_2019 
AS 
SELECT MULTI_COLLISION2019.collision_ID, MULTI_COLLISION2019.vehicle_num, MULTI_COLLISION2019.time, MULTI_COLLISION2019.BOROUGH, VEHICLE_2019.VEHICLE_YEAR, VEHICLE_2019.TRAVEL_DIRECTION, VEHICLE_2019.VEHICLE_OCCUPANTS, VEHICLE_2019.DRIVER_SEX, VEHICLE_2019.PRE_CRASH, VEHICLE_2019.POINT_OF_IMPACT, MULTI_COLLISION2019.ppl_injured, MULTI_COLLISION2019.ppl_killed 
FROM GPVEHI.VEHICLE_2019 VEHICLE_2019 
INNER JOIN GP.MULTI_COLLISION2019 MULTI_COLLISION2019 
ON 
   ( VEHICLE_2019.COLLISION_ID = MULTI_COLLISION2019.collision_ID ) ; 
QUIT;



PROC SORT data=GPVEHI.MULTI_VEHICLE_COLLISION_2019;
	by collision_ID;
run;


/* delete the missing data based on vehicle_occupants */
data GPVEHI.MULTI_VEHICLE_COLLISION_2019 ; set GPVEHI.MULTI_VEHICLE_COLLISION_2019;
	if VEHICLE_OCCUPANTS = '' THEN DELETE;
RUN;

proc export 
  data=GPVEHI.MULTI_VEHICLE_COLLISION_2019 
  dbms=csv 
  outfile="/folders/myfolders/group project/20200310/multi_vehicle_collision_2019.csv" 
  replace;
run;

/* count the number of crashes in each day in 2019 */
PROC SQL; 
CREATE TABLE gpvehi.VehicleTimeLineByDay 
AS 
SELECT VEHICLE_2019.crash_date, COUNT(DISTINCT VEHICLE_2019.COLLISION_ID) 
AS COLLISION_NUM 
FROM GPVEHI.VEHICLE_2019 VEHICLE_2019 
GROUP BY VEHICLE_2019.crash_date; 
QUIT;




/* all plots used in problem statement 3 in the final report are produced by excel*/
/* plot the vehicle in 2019 by day*/
ods graphics / reset width=6.4in height=4.8in imagemap;

proc sort data=GPVEHI.VEHICLETIMELINEBYDAY out=_SeriesPlotTaskData;
	by CRASH_DATE;
run;

proc sgplot data=_SeriesPlotTaskData;
	title height=14pt "Vehicles involved in crashes in 2019 by day";
	series x=CRASH_DATE y=COLLISION_NUM /;
	xaxis grid;
	yaxis grid;
run;

ods graphics / reset;
title;

proc datasets library=WORK noprint;
	delete _SeriesPlotTaskData;
	run;



/* export it to count the vehecles in each month */

proc export 
  data=gpvehi.VehicleTimeLine 
  dbms=csv 
  outfile="/folders/myfolders/group project/20200310/multi-timeline-2019.csv" 
  replace;
run;

/* Used excel to adjust the date and calculate the number of crashes by month */




/* import the setup data and plot */

FILENAME REFFILE '/folders/myfolders/group project/20200310/plot_vehecle2019.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=GPVEHI.PlotVehicle2019;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=GPVEHI.PlotVehicle2019; RUN;


/* plot the vehicle in 2019 by month*/
ods graphics / reset width=6.4in height=4.8in imagemap;

proc sort data=GPVEHI.PLOTVEHICLE2019 out=_SeriesPlotTaskData;
	by MMYY;
run;

proc sgplot data=_SeriesPlotTaskData;
	title height=14pt "Vehicles involved in crashes in 2019 by month";
	series x=MMYY y=COLLISION_ID /;
	xaxis grid;
	yaxis grid label="Vehicles_involed";
run;

ods graphics / reset;
title;

proc datasets library=WORK noprint;
	delete _SeriesPlotTaskData;
	run;
	
	
	
/* plot bar chart to show different number of vehicles involved
in one crash in different years*/
data GP.TRY_CRASH_COUNT_plot; set GP.TRY_CRASH_COUNT;
	year = year(date);
run;

ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgplot data=GP.TRY_CRASH_COUNT_plot;
	vbar year / group=vehicle_num groupdisplay=cluster datalabel;
	yaxis grid;
run;

ods graphics / reset;


/* plot pie charts to show collision type in different year */
data GP.TRY_CRASH_COUNT_plot; set GP.TRY_CRASH_COUNT;
	year = year(date);
	format collision_type $8.;
	if vehicle_num <3 then collision_type = 'Simple';
	else collision_type = 'Multi';
run;

	/* by changing the year to get percentage in different year*/
proc template;
	define statgraph SASStudio.Pie;
		begingraph;
		layout region;
		piechart category=collision_type / stat=pct;
		endlayout;
		endgraph;
	end;
run;

ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgrender template=SASStudio.Pie 
		data=GP.TRY_CRASH_COUNT_PLOT (where=(year=2019));
run;

ods graphics / reset;



/* plot grams in 2019 by different variables */
/* plot the line gram to show the change of time */	
data GPVEHI.MULTI_VEHICLE_COLLISION_2019_p; set GPVEHI.MULTI_VEHICLE_COLLISION_2019;
	hour = hour(time);
run;

ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgplot data=GPVEHI.MULTI_VEHICLE_COLLISION_2019_p;
	vline hour /;
	yaxis grid;
run;

ods graphics / reset;

	
/* plot the pie chart to show the percentage of driver's gender */
proc template;
	define statgraph SASStudio.Pie;
		begingraph;
		layout region;
		piechart category=DRIVER_SEX / stat=pct;
		endlayout;
		endgraph;
	end;
run;

ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgrender template=SASStudio.Pie data=GPVEHI.MULTI_VEHICLE_COLLISION_2019;
run;

ods graphics / reset;


/* plot the pie chart to show the percentage of travel direction */
proc template;
	define statgraph SASStudio.Pie;
		begingraph;
		layout region;
		piechart category=TRAVEL_DIRECTION / stat=pct;
		endlayout;
		endgraph;
	end;
run;

ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgrender template=SASStudio.Pie data=GPVEHI.MULTI_VEHICLE_COLLISION_2019;
run;

ods graphics / reset;

/* plot the pie chart to show the percentage of borough */
proc template;
	define statgraph SASStudio.Pie;
		begingraph;
		layout region;
		piechart category=BOROUGH / stat=pct;
		endlayout;
		endgraph;
	end;
run;

ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgrender template=SASStudio.Pie data=GPVEHI.MULTI_VEHICLE_COLLISION_2019;
run;

ods graphics / reset;