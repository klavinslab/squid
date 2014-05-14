Device HTTP Interface
=====================
All Devices that talk to SQUID use this HTTP interface.
All commands are sent via GET requests with the following format:

    http://<IP|addr>:<port>/?cmd=<command>[&<arg1>=<val1>[&<arg2>=<val2> ... ]]

Mandatory Commands
==================

Info
----
__command string:__ info

__arguments:__ none.

__response:__

_Header:_
Must always respond with HTTP 200 status.

_Body:_
A JSON object with the following fields

    {
      uuid   : <the uuid string>,
      status : <human readable status string 50 chars max>,
      state  : <machine state object.  readable by app <1k>>,
      name   : <the device name 50 chars max>,
    }
Note: state may be empty.  All other fields must contain information.  UUID must be a standard 
36 character __lowercase__ uuid string, preferably version 5 generated from some unique attribute
of the device (eg SHA1(mac address + listen port)).  When Generating a UUID the author must 
be contientios of the fact that multiple divices may run on the same physical computer.

Optional Commands
=================

Acquire
-------
Acquire is maditory if the device generates data.  Without being aquired the device will have no
information about where to send data.

__command string:__ acquire

__arguments:__ 

    &port=<port>

port: The TCP port that SQUID is listening on.

__response:__ 

_Header:_

HTTP 2xx if acquired.
HTTP 4xx or 5xx if not acquired.
The code should roughly match the reason.

_Body:_

May be empty or contain error/info messages.
