#Example SQUID Session
The following documents outlines two example exchanges

1. Initial association between SQUID and the device.
2. Communication between a client (e.g. Aquarium) and SQUID.

Device association:
==================

1. Device is powered on and sends a multicast packet [alternatively, device is configured with the SQUID address and messages directly] announcing it's presence.  
2. Squid sends an info message and if the device has never been seen creates an entery in known devices table.

eg (SQUID->Device)
```
curl http://example-device.com:8080/?cmd=info
```
3. SQUID sends aquire message and recieves either a 200 response code indicating that the device has been aquired or an error code indicating that the device is present but does not generate data.

eg (SQUID->Device)
```
curl http://example-device.com:8080/?cmd=acquire&port=1234
```
    
4.  Device is aquired  

Communication: Device -> SQUID
============
All data is pushed to SQUID from the device, one request per datum.
see "Adding a Datum" in interface.md

Communication: Machine (eg Aquarium) -> SQUID
============

In this example supposed we have a SQUID compatible thermocycler with uuid ```174ded16-cc17-11e4-8731-1681e6b88ec1```, that takes the command ```start``` and has configuration values: ```Tm``` and ```ExtentionTime```

When initiated by an Aquarium protocol, aquarium will send a device command to SQUID which will mediate communication directly to the device.  So to setup a thermocycler run with a Tm of 67 degrees and extention time of 45 seconds the exchange might look like

Aq->SQUID:
```
curl squid-server.com/devices/174ded16-cc17-11e4-8731-1681e6b88ec1/command?Tm=67&extentionTime=45
```
Response: ```200``` -- OK

User loads thermocycler.

Aq->SQUID:
```
curl squid-server.com/devices/174ded16-cc17-11e4-8731-1681e6b88ec1/command?Tm=67&extentionTime=45
```

