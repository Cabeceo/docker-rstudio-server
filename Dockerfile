FROM debian:10

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -qqy update && \
    apt-get install -y -q \
    r-base r-base-dev \
    curl \
    libssl-dev \
    libcurl4-openssl-dev \
    libopenblas-base \
    r-base-dev \
    r-recommended \
    r-cran-rcurl \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libxml2-dev \
    gdebi-core

RUN Rscript -e 'install.packages("textshaping", repos="http://cran.us.r-project.org")' && \
    Rscript -e 'install.packages("dplyr", repos="http://cran.us.r-project.org")' && \
    Rscript -e 'install.packages("markdown", repos="http://cran.us.r-project.org")' && \
    Rscript -e 'install.packages("stringr", repos="http://cran.us.r-project.org")' && \
    Rscript -e 'install.packages("ggplot2", repos="http://cran.us.r-project.org")' && \
    Rscript -e 'install.packages("lubridate", repos="http://cran.us.r-project.org")' && \
    Rscript -e 'install.packages("data.table", repos="http://cran.us.r-project.org")' && \
    Rscript -e 'install.packages("tidyverse", repos="http://cran.us.r-project.org")' && \
    Rscript -e 'install.packages("knitr", repos="http://cran.us.r-project.org")'

ENV LATEST rstudio-server-2023.03.0-386-amd64.deb
RUN curl --silent -O "https://download2.rstudio.org/server/bionic/amd64/$LATEST" && \
    gdebi -n $LATEST && \
    rm $LATEST && \
    (adduser --disabled-password --gecos "" guest && echo "guest:guest"|chpasswd)

WORKDIR /app
COPY 'run-wait' .
EXPOSE 8787
CMD [ "./run-wait" ]
