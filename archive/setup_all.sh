#!/bin/bash

# Run all the setup files
find . -type f -name 'setup.sh' -exec /bin/bash {} \;
