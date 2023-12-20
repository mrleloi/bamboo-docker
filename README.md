# bamboo

---
Please be sure to upgrade to the latest version(8.7.1 or 8.5.4), as this [bug](https://bamboo.atlassian.com/security/cve-2023-22518-improper-authorization-vulnerability-in-bamboo-data-center-and-server-1311473907.html).

Related issues:
+ [#38](https://github.com/haxqer/bamboo/issues/38)
+ [#39](https://github.com/haxqer/bamboo/issues/39)
+ [#46](https://github.com/haxqer/bamboo/issues/46) (Thanks to: [pldavid2](https://github.com/pldavid2))

---
[README](README.md) | [中文文档](README_zh.md)

default port: 8090

+ Latest Version: v8(8.7.1)
+ LTS Version: v8(8.5.4)
+ Latest Chinese Version: [v7](https://github.com/haxqer/bamboo/tree/latest-zh) (Thanks to: [sunny1025g](https://github.com/sunny1025g) for the `zh` image. [#issues/16](https://github.com/haxqer/bamboo/issues/16) )

## Requirement
- docker-compose: 17.09.0+

## How to run with docker-compose

- start bamboo & mysql

```
git clone https://github.com/haxqer/bamboo.git \
    && cd bamboo \
    && docker-compose up
```

- start bamboo & mysql daemon

```
docker-compose up -d
```

- default db(mysql8.0) configure:

```bash
driver=mysql
host=mysql-bamboo
port=3306
db=bamboo
user=root
passwd=123456
```

## How to run with docker

- start bamboo

```
docker volume create bamboo_home_data && docker network create bamboo-network && docker run -p 8090:8090 -v bamboo_home_data:/var/bamboo --network bamboo-network --name bamboo-srv -e TZ='Asia/Shanghai' haxqer/bamboo:8.7.1
```

- config your own db:


## How to hack bamboo

```
docker exec bamboo-srv java -jar /var/agent/atlassian-agent.jar \
    -d \
    -p conf \
    -m Hello@world.com \
    -n Hello@world.com \
    -o your-org \
    -s you-server-id-xxxx
```

## How to hack bamboo plugin

- .eg I want to use BigGantt plugin
1. Install BigGantt from bamboo marketplace.
2. Find `App Key` of BigGantt is : `eu.softwareplant.biggantt`
3. Execute :

```
docker exec bamboo-srv java -jar /var/agent/atlassian-agent.jar \
    -d \
    -p eu.softwareplant.biggantt \
    -m Hello@world.com \
    -n Hello@world.com \
    -o your-org \
    -s you-server-id-xxxx
```

4. Paste your license


## How to upgrade

```shell
cd bamboo && git pull
docker pull haxqer/bamboo:latest && docker-compose stop
docker-compose rm
```

enter `y`, then start server

```shell
docker-compose up -d
```

