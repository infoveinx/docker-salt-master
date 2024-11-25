#!/bin/bash

# turn on bash's job control
set -m

# Start salt-master and put it in the background
su -s /bin/bash -c '/usr/bin/salt-master --log-level=info' salt &

# Start salt-minion
if [ ! -z "$SALT_MINION_ENABLE" ] && [ "$SALT_MINION_ENABLE" == "True" ]; then
  /usr/bin/salt-minion --log-level=info
fi

# bring salt-master process back into the foreground
# and leave it there
fg %1