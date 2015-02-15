#!/usr/bin/env python

def read_temp():
	raw = float(open('/sys/bus/iio/devices/iio:device0/in_temp0_raw').read())
	offset = float(open('/sys/bus/iio/devices/iio:device0/in_temp0_offset').read())
	scale  = float(open('/sys/bus/iio/devices/iio:device0/in_temp0_scale').read())
	return (raw + offset)*scale/1000

temp = read_temp()
print "%.1f" % temp
