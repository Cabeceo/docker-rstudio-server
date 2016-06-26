FROM debian:jessie
MAINTAINER max thomas <max@maxthomas.io>
RUN echo 'deb http://cran.rstudio.com/bin/linux/debian jessie-cran3/' >> /etc/apt/sources.list.d/cran.list
RUN apt-key adv --keyserver keys.gnupg.net --recv-key 381BA480
RUN apt-get -qqy update
RUN apt-get install -y -q \
    wget \
    curl \
    libssl-dev \
    libcurl4-openssl-dev \
    r-base \
    r-base-dev \
    r-recommended \
    r-cran-rjava \
    r-cran-rcurl \
    r-cran-xml \
    openjdk-7-jdk \
    libxml2-dev \
    gdebi-core \
    supervisor

RUN Rscript -e 'install.packages("dplyr", repos="http://cran.us.r-project.org")'
RUN Rscript -e 'install.packages("stringr", repos="http://cran.us.r-project.org")'
RUN Rscript -e 'install.packages("ggplot2", repos="http://cran.us.r-project.org")'
RUN Rscript -e 'install.packages("lubridate", repos="http://cran.us.r-project.org")'

RUN apt-get install -y -q git

ENV LATEST rstudio-server-0.99.902-amd64.deb
RUN wget "https://download2.rstudio.org/$LATEST"
RUN gdebi -n $LATEST
RUN rm $LATEST
RUN (adduser --disabled-password --gecos "" guest && echo "guest:guest"|chpasswd)
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 8787
CMD ["/usr/bin/supervisord"]
