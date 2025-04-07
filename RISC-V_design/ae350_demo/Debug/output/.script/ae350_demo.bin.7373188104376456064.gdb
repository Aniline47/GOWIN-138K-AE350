set logging file .script/ae350_demo.bin.906414052264176117.log
set logging on
printf "Target remote...\n"
set confirm off
target remote LOCALHOST:9900
monitor set memory mode readwrite
printf "Burning...\n"
restore ae350_demo.bin binary 0x600000
printf "Dump image file...\n"
dump binary memory .script/ae350_demo.bin.6119592676545119367.dump 0x600000 0x600000 + 14648
monitor set memory mode readonly
set logging off
