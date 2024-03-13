# Run PostgreSQL inside a Docker container

This is a super basic sample on how you can create a PostgreSQL database inside a docker container. 

## Overview

I'll simply go throught the process of: 

1. Creating the image
2. Copy an SQL file into this image

```shell
docker buildx build -t postgresdb .

❯ $ docker images

REPOSITORY   TAG       IMAGE ID       CREATED         SIZE
postgresdb   latest    e8c3077ea60e   2 minutes ago   425MB
```

3. Build a container from this image with some exposing ports


```shell
❯ $ docker run -d --name postgresdb_container -p 5432:5432 postgresdb
1a4f1e6b2e9f84aa20d8c1182597ab8cdec2a4a97d74b708d77b99bbb703b35a

❯ $ docker container ls
CONTAINER ID   IMAGE        COMMAND                  CREATED              STATUS              PORTS                                       NAMES
1a4f1e6b2e9f   postgresdb   "docker-entrypoint.s…"   About a minute ago   Up About a minute   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   postgresdb_container
```

4. And we are going throught into the running container
   - Take a look at the data just to make sure everything is setup correctly
   - Indirectly whe doing this we're going to be exposing our database using a port locally
   - We will connect to this container and get access to the terminal inside the container

```shell
❯ $ docker exec -it 1a4f1e6b2e9f /bin/bash

root@1a4f1e6b2e9f:/# ls
bin  boot  dev  docker-entrypoint-initdb.d  etc  home  lib  lib32  lib64  libx32  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
```

5. We can notice that we have this docker entry point initialized, the one we defined previously: docker-entrypoint-initdb.d this is where we have copied our user.sql into:

```shell
root@1a4f1e6b2e9f:/# cd docker-entrypoint-initdb.d/
root@1a4f1e6b2e9f:/docker-entrypoint-initdb.d# ls
user.sql
```

6. Now that we are into the container, we can access the postgreSQL: 

```shell
root@1a4f1e6b2e9f:/docker-entrypoint-initdb.d# psql -U postgres
psql (16.1 (Debian 16.1-1.pgdg120+1))
Type "help" for help.

postgres=# 
```

7. We can get the list of the running databases: 

```shell
                                                      List of databases
   Name    |  Owner   | Encoding | Locale Provider |  Collate   |   Ctype    | ICU Locale | ICU Rules |   Access privileges   
-----------+----------+----------+-----------------+------------+------------+------------+-----------+-----------------------
 postgres  | postgres | UTF8     | libc            | en_US.utf8 | en_US.utf8 |            |           | 
 template0 | postgres | UTF8     | libc            | en_US.utf8 | en_US.utf8 |            |           | =c/postgres          +
           |          |          |                 |            |            |            |           | postgres=CTc/postgres
 template1 | postgres | UTF8     | libc            | en_US.utf8 | en_US.utf8 |            |           | =c/postgres          +
           |          |          |                 |            |            |            |           | postgres=CTc/postgres
 user      | postgres | UTF8     | libc            | en_US.utf8 | en_US.utf8 |            |           | 
(4 rows)
```

8. Let's switch to our user and start quering our tables:

```shell
postgres-# \c user
You are now connected to database "user" as user "postgres".

user-# \dt
          List of relations
 Schema |   Name   | Type  |  Owner   
--------+----------+-------+----------
 public | accounts | table | postgres
(1 row)

user=# SELECT * FROM accounts;
 user_id | username | password |     email      |         created_on         | last_login 
---------+----------+----------+----------------+----------------------------+------------
       1 | user     | pass     | test@email.com | 2024-01-17 05:27:12.872434 | 
(1 row)

```

## Some known issues

- As of January, 2024 you might see this error: exec: "docker-credential-desktop.exe": executable file not found in $PATH

Short answer: Delete the line with credStore from ~/.docker/config.json.

Long explanation:

The property credsStore specifies an external binary to serve as the default credential store. When this property is set, docker login will attempt to store credentials in the binary specified by docker-credential-<value> which is visible on $PATH. If this property is not set, credentials will be stored in the auths property of the config.

Read more about it https://docs.docker.com/engine/reference/commandline/cli/#credential-store-options
