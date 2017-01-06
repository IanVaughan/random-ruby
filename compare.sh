#!/bin/bash
# http://psung.blogspot.co.uk/2008/06/comparing-directory-trees-with-diff-or.html
# sync -rvnc --delete /share/Shared/ /share/Restored-Share/Shared/ > /root/rsync2.txt

RSYNC_FILE=`cat /root/rsync.txt`
RESULTS_FILE='/root/results.csv'

BASE_PATH_A='/share/Restored-Share/Shared'
BASE_PATH_B='/share/MD0_DATA/Shared'

echo "file,cksum_a,size_a,cksum_b,size_b," > $RESULTS_FILE

function do_cksum {
  # CKSUM = `cksum /share/Restored-Share/Shared/HR\ and\ Documentation/Admin/Phone\ Rota.doc`
  RESULT=$(cksum "$1")
  chsum=$(echo $RESULT | cut -d ' ' -f1)
  size=$(echo $CKSUM | cut -d ' ' -f2)
  echo "$chsum,$size"
}

function do_ls {
  LS=`ls -l $"1"`
  user=$(echo $LS | awk '{print $3}')
  group=$(echo $LS | awk '{print $4}')
  month_day=$(echo $LS | awk '{print $6, 7}')
  time_stamp=$(echo $LS | awk '{print $8}')
  echo "$user,$group,month_day,time_stamp"
}

#for file in RSYNC_FILE; do
  file="Analysis Tool/Debug/Files/bs/2013-08-02_bs_bsbs432.xlsx"

file_a="$BASE_PATH_A/$file"
file_b="$BASE_PATH_B/$file"

  cksum_a=$(do_cksum "$file_a")
  cksum_b=$(do_cksum "$file_b")

  if [ "$cksum_a" != "$cksum_b" ]; do
    ls_result=$(do_ls($file_a))
    echo "$file,$cksum_a,$cksum_b,$ls_result" >> $RESULTS_FILE
  done
#done
