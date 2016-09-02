# silver-train : A suite of tools to help check security of Raspberry Pi#

##What it does?##

At the moment, pre-1.0.0, it does not yet do anything sane, except report
the unique logon shell names found in /etc/passwd file

This is essentially *work in progress*.

In 1.0.0 it will
- check the logon shells in /etc/passwd
- check that unnecessary services are turned off
- hopefully also understand how and whether the PAM affects 'passwd'

Note: at the moment, all checks are static, ie. silver-train
does NOT do live system checks, like a real probe / IDS would do.
Silver-train only checks configuration files. 

The intent is that silver-train will be a nice (set of) tool(s)
to check the "software side" of a Raspberry Pi -- or any other
Linux-using device; perhaps pre-deployment, at the stage of
deploying the image onto a SD card, or it can be run periodically
on a live system. 

##Background of the project##

The idea got started when I was deploying a Pi3B to be a
web server. I wanted to make sure everything is "ok". Ie.
if I put the device 24/7 to serve into public Internet,
I won't get hacked immediately. ;-)
