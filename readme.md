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
  - Example `RABBITMQ_ERLANG_COOKIE="GUZMZGPBZMBJZCAVMIEL"`

- `RABBITMQ_CLUSTERER_DISC_NODES`[required] the expected node names that makes
  up the cluster
  - Example `RABBITMQ_ERLANG_COOKIE="sauron-staging-rabbitmq-1,
    sauron-staging-rabbitmq-2"`
  - If running under Docker Cloud, each container will have a host name of the
    service name suffixed by the containers index. For example, if a third
    container was started for a RabbitMQ service named "bunny", then the
    container will have a host name of "bunny-3".

## High Availability Queues

By default, queues are not mirrored across all nodes in the cluster. To enable
this, a policy needs to be created for the queues with a specific (which can be
done through RabbitMQ's Management interface).

RabbitMQ policies consists of a name of the policy, a resource type it applies
to (exchange, queues, or both), a pattern used to match which resources it will
affect (leave blank to match all resources), and a list of definitions (each
definition being a key-value pair of options to apply on each matching
resource).

For example, to create a policy that will mirror queues across all nodes in the
cluster and automatically sync messages to new slave nodes, it will need to
apply to only queue types, to have an empty pattern to match all queues, to
have a definition of `ha-mode` set to `all` to mirror matching queues across
all nodes in the cluster, and to have another definition of `ha-sync-mode` set
to `automatic` to have new nodes added to the cluster automatically sync the
messages from the master node.

Refer to the [HA docs](https://www.rabbitmq.com/ha.html) for more detail.
