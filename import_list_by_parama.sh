#!/bin/bash
cd /data/tfrs9/02_staging/script
JDATE=$(date "+%Y%m%d")
mkdir -p backup/${JDATE}
cp -f *_backup*.txt backup_ecl_for_necl.txt backup_necl_for_ecl.txt backup/${JDATE}
./xlsx2csv.py -n DAY1 TFRS9_BACKUP_LIST.xlsx ecl_backup_d1.txt
./xlsx2csv.py -n DAY2 TFRS9_BACKUP_LIST.xlsx ecl_backup_d2.txt
./xlsx2csv.py -n DAY3 TFRS9_BACKUP_LIST.xlsx ecl_backup_d3.txt
./xlsx2csv.py -n DAY4INIT TFRS9_BACKUP_LIST.xlsx ecl_backup_init.txt
./xlsx2csv.py -n DAY4 TFRS9_BACKUP_LIST.xlsx ecl_backup_d4.txt
./xlsx2csv.py -n DAY5 TFRS9_BACKUP_LIST.xlsx ecl_backup_d5.txt
./xlsx2csv.py -n NECL TFRS9_BACKUP_LIST.xlsx necl_backup.txt

./xlsx2csv.py -n RPT_DAY1 TFRS9_BACKUP_LIST.xlsx rpt_day1_backup.txt
./xlsx2csv.py -n RPT_DAY2 TFRS9_BACKUP_LIST.xlsx rpt_day2be_backup.txt
./xlsx2csv.py -n RPT_DAY2 TFRS9_BACKUP_LIST.xlsx rpt_day2af_backup.txt
./xlsx2csv.py -n RPT_DAY3 TFRS9_BACKUP_LIST.xlsx rpt_day3_backup.txt
./xlsx2csv.py -n RPT_DAY4 TFRS9_BACKUP_LIST.xlsx rpt_day4_backup.txt
./xlsx2csv.py -n RPT_DAY5 TFRS9_BACKUP_LIST.xlsx rpt_day5_backup.txt
./xlsx2csv.py -n RPT_DAY4 TFRS9_BACKUP_LIST.xlsx rpt_init_backup.txt

./xlsx2csv.py -n IMA TFRS9_BACKUP_LIST.xlsx ima_backup.txt
./xlsx2csv.py -n RPT_IMA TFRS9_BACKUP_LIST.xlsx rpt_ima_backup.txt

# Add backup_ecl_for_necl, backup_necl_for_ecl
./xlsx2csv.py -n backup_ecl_for_necl TFRS9_BACKUP_LIST.xlsx backup_ecl_for_necl.txt
./xlsx2csv.py -n backup_necl_for_ecl TFRS9_BACKUP_LIST.xlsx backup_necl_for_ecl.txt

#sed -i -e 's/puatlrtfrsdb01/puatlrtfrsmip01/g' ./*_backup*.txt










