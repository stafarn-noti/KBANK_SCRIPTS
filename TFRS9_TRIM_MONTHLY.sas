




%macro trim_journal_inst_ecl(lib=, table=, month_trim=, month_field=);

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

				data &lib..&table.;
                		set &lib..&table.;    
            			run;

		%end;
%else
        %do;

/*				proc sql;
				delete from &lib..&table. where put(&month_field., yymmn6.) = "&yearmonth.";
				quit;
*/
				%put "There is table exists";


		 %end;

%mend;

/*Purge table older than 2 month*/

%trim_journal_inst_ecl(lib=stg, table=stg_actual_payment, month_trim=2, month_field=DATE);
/* %trim_journal_inst_ecl(lib=result, table=post_journal_inst_ecl, month_trim=2, month_field=EFFECTIVE_DT); */
