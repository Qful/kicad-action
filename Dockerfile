FROM setsoft/kicad_auto:latest
LABEL MAINTAINER nerdyscout <nerdyscout@posteo.de>
LABEL DESCRIPTION="export various files from KiCad projects"

RUN apt-get update && apt-get install -y apt-transport-https
RUN apt-get install -y --no-install-recommends git python3-tk
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/INTI-CMNB/kicad-git-filters.git /opt/git-filters/
RUN git clone https://github.com/Gasman2014/KiCad-Diff.git /opt/kicad-diff/

COPY config/ /opt/kibot/config/

ARG BUILD_DATE
ARG BUILD_COMMIT
ENV BUILD="$BUILD_COMMIT - $BUILD_DATE"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
