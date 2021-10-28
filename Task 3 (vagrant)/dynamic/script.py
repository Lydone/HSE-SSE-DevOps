#!/usr/bin/python3

import os
from datetime import datetime

print("")
print("DateTime:", datetime.now())
print("User agent:", os.environ["HTTP_USER_AGENT"])
print("Remote address:", os.environ["REMOTE_ADDR"])
