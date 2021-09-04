#!/bin/bash

JOB_NAME="${0##*/}"
JOB_NAME="${JOB_NAME%.*}".sas
/data/tfrs9/02_staging/script/runbatch.sh $JOB_NAME $1
