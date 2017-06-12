# Database Backup Resource

Simple [Concourse CI](http://concourse.ci/) resource to dump entire databases or specified database schemas to a compressed file (``.tar.bz2``).

To ensure that jobs are run and not cached, ``check`` always returns that a new version is available. Using ``trigger: false`` is advisable.

## Database Support

Engine|Database|Method
---|---|---
postgres|Postgres 9.x|``pg_dump``

## Source Configuration

### Required

* ``engine``: ``postgres`` (see database support above)
* ``host``: Host name or IP of the database
* ``port``: Port of the database
* ``user``: Authentication user name
* ``password``: Authentication password
* ``database``: Name of the database to backup

## Params Configuration

* ``schemas``: An array of schemas to backup in the database

## Example Pipeline

```yml
resource_types:
- name: db-backup
  type: docker-image
  source:
    repository: [..]/database-backup-resource
    tag: latest

resources:
- name: example-db-backup
  type: db-backup
  source:
    engine: postgres
    host: 10.10.1.100
    port: 5432
    user: example
    password: example
    database: the_database

jobs:
- name: database-backup
  build_logs_to_retain: 60 # Prune logs
  serial: true
  plan:
  - get: example-db-backup # Backup entire database
    trigger: false
    # on_failure: [..] Warn backup failed

  - get: example-db-backup # Backup specified schemas
    trigger: false
    params:
      schemas:
        - first_schema
        - second_schema
        - third_schema
    # on_failure: [..] Warn backup failed

  # Do something with the files created, upload to S3 for example
```
