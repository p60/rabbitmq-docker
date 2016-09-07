# rabbitmq-docker

Build steps for the RabbitMQ image for docker which includes the management & clusterer plugin

## Running

```
docker run -d -p 5672:5672 -p 15672:15672 peer60/rabbitmq
```

## Configuration

Use environment variables `-e KEY=VALUE`

- `RABBITMQ_ERLANG_COOKIE`[required] the cookie to allow multiple nodes to
  communicate with each other
  - Example `RABBITMQ_ERLANG_COOKIE="GUZMZGPBZMBJZCAVMIELroot@12caa020b0a7"`

- `RABBITMQ_CLUSTERER_DISC_NODES`[required] the expected node names that makes
  up the cluster
  - Example `RABBITMQ_ERLANG_COOKIE="sauron-staging-rabbitmq-1,
    sauron-staging-rabbitmq-2"`
  - If running under Docker Cloud, each container will have a host name of the
    service name suffixed by the containers index. For example, if a third
    container was started for a RabbitMQ service name "bunny", then the
    container will have a host name of "bunny-3".
