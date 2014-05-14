HTTP Interface
==============

Adding A Datum
--------------

__URL:__
/data
    
__Type:__
post
    
__Post data:__
    
    datum[uuid]=the36charuuid
    datum[data]=the binary data url encoded.  

__Response:__
Currently undefined.  Caller should assume success if http status is something other than 4xx or 5xx
    
__example:__
  
    curl --data "datum[uuid]=theuuidhere&datum[data]=the data" http://bioturk:3008/data


Viewing A Datum
---------------

__URL:__
/data/\<id\>[.json]

__Type:__
get

__Response:__

\<id\>.json: gives a JSON hash/dictionary object with the uuid, data, id, creation date, 
and modification date in epoch time format

\<id\>: gives the human readable webpage.  Format is not defined and may change or be arbitrary or incorrect.

__example:__

    curl http://bioturk:3008/data/3.json
    
Retrieving Recent Data
----------------------
Retrieves the most recent 100 data rows.  

__URL:__
/data[.json]

__Type:__
get

__Response:__

/data.json: gives a JSON array of objects as described above

/data: gives a human readable list.  As above format is undefined.

__example:__

    curl http://bioturk:3008/data.json

Searching Data by device and time
---------------------------------

__URL:__
/devices/\<uuid\>/data[.json][?opt1=<opt1>[&opt2=<opt2>...]]

__Type:__
get

__Options:__

start: limits the data to newer than start (formated as epoch time)

end: limits the data to older than end (formatted as epoch time)

limit: the max number of records to return (default 100)

order: ASC or DESC (default), order by ascending or descending chronological order


__Response:__

data.json: gives a JSON array of objects as described above

data: gives a human readable list.  As above format is undefined.

__example:__

    curl http://bioturk:3008/devices/oeui/data.json?limit=25&start=1234567890

Sending commands to a device
----------------------------

__URL:__
/devices/\<uuid\>/command[?opt1=<opt1>[&opt2=<opt2>...]]

__Type:__
get, post

__Options:__

Variable.  The query string is forwarded exactly to the device.

__Post Data:__

Variable.  The post data is forwarded exactly to the device.

__Response:__

The message body from the device.  HTML headers are not preserved.

__example:__

    curl http://bioturk:3008/devices/85fcf1ce-ca46-53e0-be4c-1f4b5c24790d/command?cmd=info
