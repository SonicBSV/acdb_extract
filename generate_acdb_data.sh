#!/bin/bash

if [ ! -f $1 ]; then
    echo "You need to specify the target lib"
    exit 1
fi

devices=`strings $1 | grep -E "^(SND_DEVICE_OUT|SND_DEVICE_IN)"`

echo -ne "" > acdb_data.h

echo "enum {" >> acdb_data.h
echo "    SND_DEVICE_NONE = 0," >> acdb_data.h

for device in $devices; do
    echo "    $device," >> acdb_data.h
done

echo "    SND_DEVICE_MAX," >> acdb_data.h
echo "};" >> acdb_data.h

echo >> acdb_data.h

echo "static char * faux_device_table[SND_DEVICE_MAX] = {" >> acdb_data.h
echo "    [SND_DEVICE_NONE] = \"SND_DEVICE_NONE\"," >> acdb_data.h
for device in $devices; do
    echo "    [$device] = \"$device\"," >> acdb_data.h
done
echo "};" >> acdb_data.h
