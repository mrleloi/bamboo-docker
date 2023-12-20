# bamboo

## Requirement
- docker-compose: 17.09.0+

## How to run with docker-compose

- start bamboo & mysql

```
git clone https://github.com/mrleloi/bamboo-docker.git \
    && cd bamboo-docker \
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
docker exec bamboo-server java -jar /var/agent/atlassian-agent.jar \
    -d \
    -p bamboo \
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
docker exec bamboo-server java -jar /var/agent/atlassian-agent.jar \
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

