#!/bin/bash

#must be run once after ECL D4 deployment
#./scriptname cycle_date


function initial_copy () {
CYCLE_DT=$1
TMP_DT=$(echo "$CYCLE_DT" | cut -c1-6)"01"
OPTARG="$TMP_DT -1 days"
PREV_EOM=$(date --date="$OPTARG" +"%Y%m%d")
PREV_CYCLE_DT=$(date  --date="$CYCLE_DT -1 day" +"%Y%m%d")
echo "CYCLE_DT: "$CYCLE_DT
echo "PREV_EOM: "$PREV_EOM
echo "PREV_CYCLE_DT: "$PREV_CYCLE_DT 
#}

DT=$(date '+%Y-%m-%d_%H.%M.%S')
LOG_PATH=/project/tfrs9/logs/sys_log
LOG_NAME=POST_DEPLOY_INT_${DT}.log

echo "Begin Log">$LOG_PATH/$LOG_NAME

libary_location=/data/tfrs9/02_staging/data

[ -d ${libary_location}/stgtemp ] || mkdir -p ${libary_location}/stgtemp
mkdir -p /data/tfrs9/05_export/data/export/ecl/ 

sl_location=/data/tfrs9/05_export/data/export

[ -d ${sl_location}/ecl ] || mkdir -p ${sl_location}/ecl

## link_inst_ecl 
echo "copying link_inst_ecl.sas7bdat stgrm > stgtemp..." >> $LOG_PATH/$LOG_NAME
cp -rp ${libary_location}/stgrm/link_inst_ecl.sas7bdat ${libary_location}/stgtemp/link_inst_ecl_d4_${PREV_EOM}.sas7bdat
#cp -rp ${libary_location}/stgrm/link_inst_ecl.sas7bdat ${libary_location}/stgtemp/link_inst_ecl_d4_${CYCLE_DT}.sas7bdat

## link_inst_prepmt_rt
echo "copying link_inst_prepmt_rt.sas7bdat stgrm > stgtemp..." >> $LOG_PATH/$LOG_NAME
cp -rp ${libary_location}/stgrm/link_inst_prepmt_rt.sas7bdat ${libary_location}/stgtemp/link_inst_prepmt_rt_d4_${PREV_EOM}.sas7bdat
cp -rp ${libary_location}/stgrm/link_inst_prepmt_rt.sas7bdat ${libary_location}/stgtemp/


## map_necl_config_sys
echo "copying map_necl_config_sys.sas7bdat stgrm > stgtemp..." >> $LOG_PATH/$LOG_NAME
cp -rp ${libary_location}/map_necl_config_sys.sas7bdat ${libary_location}/stgtemp/map_necl_config_sys_d4_${PREV_EOM}.sas7bdat


## link_inst_ecl_pit
echo "copying link_inst_ecl_pit stgrm > stgtemp..." >> $LOG_PATH/$LOG_NAME
cp -rp ${libary_location}/stgrm/link_inst_ecl_pit.sas7bdat ${libary_location}/stgtemp/link_inst_ecl_pit_d1_${PREV_EOM}.sas7bdat

## sl_inst_ecl
echo "copying sl_inst_ecl  /data/tfrs9/05_export/data/export/ > /data/tfrs9/05_export/data/export/ecl..." >> $LOG_PATH/$LOG_NAME
cp -rp ${sl_location}/sl_inst_ecl_thb_rc_${PREV_CYCLE_DT}.sas7bdat ${sl_location}/ecl/sl_inst_ecl_thb_rc.sas7bdat
cp -rp ${sl_location}/sl_inst_ecl_fcy_rc_${PREV_CYCLE_DT}.sas7bdat ${sl_location}/ecl/sl_inst_ecl_fcy_rc.sas7bdat

cp -rp ${sl_location}/sl_inst_ecl_thb_rc_${PREV_CYCLE_DT}.sas7bdat ${sl_location}/sl_inst_ecl_thb_rc.sas7bdat
cp -rp ${sl_location}/sl_inst_ecl_fcy_rc_${PREV_CYCLE_DT}.sas7bdat ${sl_location}/sl_inst_ecl_fcy_rc.sas7bdat


## Link_modify_access NECL to ECL D1
echo "copying link_modified_assets.sas7bdat stgrm >>> stgtemp.." >> $LOG_PATH/$LOG_NAME
cp -rp ${libary_location}/stgrm/link_modified_assets.sas7bdat ${libary_location}/stgtemp/


echo "Completed"
exit 0
exit 0

}


[ ! -z $1 ] && {

        [[ $1 == [2][0][0-9][0-9][0-1][0-9][0-3][0-9] ]] && {
        # Call function
	echo "Starting Copy..."
        initial_copy $1
        } || {
	
	echo "bad parameter :[$0] [CYCLE_DT]"
	exit 1;
		
	}

} || {
echo "bad parameter :[$0] [CYCLE_DT]"
exit 1;
}
