FROM rabbitmq:3.6.5-management
MAINTAINER peer60

RUN set -x \
      && export PLUGIN_BUILD_TOOLS="ca-certificates erlang-dev erlang-src git make python rsync xmlto xsltproc zip" \
      && export PLUGIN_HOME="$(mktemp -d)" \
      && export PLUGIN_TAG="$(echo rabbitmq_v$RABBITMQ_VERSION | sed -e 's/\./_/g')" \
      && apt-get update && apt-get install -y --no-install-recommends $PLUGIN_BUILD_TOOLS && rm -rf /var/lib/apt/lists/* \
      && git clone https://github.com/rabbitmq/rabbitmq-clusterer.git $PLUGIN_HOME \
      && git -C $PLUGIN_HOME checkout $PLUGIN_TAG \
      && VERSION=$RABBITMQ_VERSION make -C $PLUGIN_HOME/ rabbitmq-components-mk all dist \
      && mv $PLUGIN_HOME/plugins/rabbitmq_clusterer-$RABBITMQ_VERSION.ez /usr/lib/rabbitmq/lib/rabbitmq_server-$RABBITMQ_VERSION/plugins/ \
      && rm -r $PLUGIN_HOME \
      && apt-get purge -y --auto-remove $PLUGIN_BUILD_TOOLS

RUN rabbitmq-plugins enable --offline rabbitmq_clusterer

COPY docker-entrypoint.sh /usr/local/bin/
