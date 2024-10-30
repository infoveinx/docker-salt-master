#!/bin/bash

# turn on bash's job control
set -m

# Start the primary process and put it in the background
/usr/bin/salt-master --log-level=info &

# Start the helper process
/usr/bin/salt-minion --log-level=info

# now we bring the primary process back into the foreground
# and leave it there
fg %1