#!/bin/bash

BASE_DIR=$(dirname "$0")
DEST_DIR=/tmp/database-backup-resource/ #This directory is purged

PAYLOAD='
  {
    "source": {
      "engine":   "postgres",
      "host":     "localhost",
      "port":     "5432",
      "user":     "test",
      "password": "test",
      "database": "test_db"
    },
    "params": {
      "schemas": [
        "first_schema", "second_schema"
      ]
    },
    "version": {
      "timestamp": "20170531_145828"
    }
  }
'

[ -d "$DEST_DIR" ] && rm -rf "$DEST_DIR"
mkdir -p "$DEST_DIR"

echo "$PAYLOAD" | "$BASE_DIR"/../assets/in "$DEST_DIR"
