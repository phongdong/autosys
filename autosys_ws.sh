#!/bin/bash

#BPname
BPname=FIG_SFTPget_CIS_To_PC_Inbound
LogFile=/si/si5241/base/autosys_scripts/log/$Bpname.log
echo "Gentran Job Triggers via AutoSys" &> $LogFile
echo "Bussiness Process Name" $BPname &> $LogFile

# switch to the workflowLauncher.sh directory
workflow=/si/si5241/base/bin
cd $workflow

sh workflowLauncher.sh -t -d /si/si5241/base/autosys_scripts/log -n $BPname >> $LogFile 2>&1

FILE=$LogFile
if grep -q '0' $FILE;
 then
     echo "Business Process Ran Successfully:"
     echo -e "$(grep $FILE)\n"
 else
     kill $(ps aux | grep '[w]orkflowLauncher.sh -n $Bpname' | awk '{print $2}')
     echo "Error: The Business Process Errored out"
     echo "Exiting..."
     exit 0
fi



