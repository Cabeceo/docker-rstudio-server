FROM debian:latest
MAINTAINER max thomas <max@hidden>
RUN echo 'deb http://lib.stat.cmu.edu/R/CRAN/bin/linux/debian jessie-cran3/' >> /etc/apt/sources.list.d/cran.list && \
    apt-key adv --keyserver keys.gnupg.net --recv-key 381BA480 && \
    apt-get -qqy update && \
    apt-get install -y -q \
    wget \
    curl \
    libssl-dev \
    libcurl4-openssl-dev \
    r-base \
    libopenblas-base \
    r-base-dev \
    r-recommended \
    r-cran-rcurl \
    gdebi-core \
    supervisor \
    git

RUN Rscript -e 'install.packages("dplyr", repos="http://cran.us.r-project.org")' && \
    Rscript -e 'install.packages("stringr", repos="http://cran.us.r-project.org")' && \
    Rscript -e 'install.packages("ggplot2", repos="http://cran.us.r-project.org")' && \
    Rscript -e 'install.packages("lubridate", repos="http://cran.us.r-project.org")' && \
    Rscript -e 'install.packages("data.table", repos="http://cran.us.r-project.org")' && \
    Rscript -e 'install.packages("knitr", repos="http://cran.us.r-project.org")'

ENV LATEST rstudio-server-1.0.143-amd64.deb
RUN wget "https://download2.rstudio.org/$LATEST" && \
    gdebi -n $LATEST && \
    rm $LATEST && \
    (adduser --disabled-password --gecos "" guest && echo "guest:guest"|chpasswd) && \
    mkdir -p /var/log/supervisor

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 8787
CMD ["/usr/bin/supervisord"]
