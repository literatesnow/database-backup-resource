#!/bin/bash

BASE_DIR=$(dirname "$0")

PAYLOAD='
  {
    "source": {},
    "version": {
      "timestamp": "20170531_145828"
    }
  }
'

echo "$PAYLOAD" | "$BASE_DIR"/../assets/check
