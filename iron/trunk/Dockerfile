FROM eiffel/iron:latest
MAINTAINER Jocelyn Fiat

RUN /bin/bash $EIF_IRON_DIR/scripts/iron_fill_trunk.sh $EIF_IRON_DIR $EIF_IRON_PORT "ironman" "eiffel123"

# Entrypoint 
USER eiffel
WORKDIR $EIF_IRON_DIR/www
CMD $EIF_IRON_DIR/bin/irond

