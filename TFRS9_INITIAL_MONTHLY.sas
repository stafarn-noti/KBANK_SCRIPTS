



%MACRO INITIAL_MONTH(lib=, table=, month_field=);

%let start='31JAN2020';
%let end=&ecl_cycle_dt.;
%let COUNT=%sysfunc(intck(month,&start.d,&end.d));
%put &COUNT.;

%DO month_trim = 3 %TO &COUNT.;
 
			
 	%let yearmonth=%sysfunc(intnx(month,&ecl_cycle_dt.d,-&month_trim.,s));
	%let yearmonth=%sysfunc(putn(&yearmonth.,yymmn6.));
	
	%if %sysfunc(exist(&lib..&table._&yearmonth.)) eq 0 %then
		%do;
				proc sql;
                create table &lib..&table._&yearmonth.
				as select * from &lib..&table. where &month_field. ^=. and put(&month_field., yymmn6.) = "&yearmonth.";
				quit;

				proc sql;
				delete from &lib..&table. where put(&month_field., yymmn6.) = "&yearmonth.";
				quit;

		%end;
	%else
        %do;

/*              proc sql;
                delete from &lib..&table. where put(&month_field., yymmn6.) = "&yearmonth.";
                quit;
*/
                %put "There is table exists";

		 %end;

%END;
%MEND INITIAL_MONTH;


/*Purge table older than 3 month*/

%INITIAL_MONTH(lib=stg, table=stg_actual_payment, month_field=DATE);
/* %INITIAL_MONTH(lib=result, table=post_journal_inst_ecl, month_field=EFFECTIVE_DT); */
