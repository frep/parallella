#!/bin/bash

# CONKY
killall conky
sleep 5
conky --config=.conky/.conkyrc -d &

exit 0
