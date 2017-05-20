FROM cabeceo/debunk

RUN echo 'deb http://lib.stat.cmu.edu/R/CRAN/bin/linux/debian jessie-cran34/' >> /etc/apt/sources.list.d/cran.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF' && \
    apt-get -qqy update && \
    apt-get install -y -q \
    curl \
    libssl-dev \
    libcurl4-openssl-dev \
    r-base \
    libopenblas-base \
    r-base-dev \
    r-recommended \
    r-cran-rcurl \
    gdebi-core

RUN Rscript -e 'install.packages("dplyr", repos="http://cran.us.r-project.org")' && \
    Rscript -e 'install.packages("stringr", repos="http://cran.us.r-project.org")' && \
    Rscript -e 'install.packages("ggplot2", repos="http://cran.us.r-project.org")' && \
    Rscript -e 'install.packages("lubridate", repos="http://cran.us.r-project.org")' && \
    Rscript -e 'install.packages("data.table", repos="http://cran.us.r-project.org")' && \
    Rscript -e 'install.packages("knitr", repos="http://cran.us.r-project.org")'

ENV LATEST rstudio-server-1.0.143-amd64.deb
RUN curl --silent -O "https://download2.rstudio.org/$LATEST" && \
    gdebi -n $LATEST && \
    rm $LATEST && \
    (adduser --disabled-password --gecos "" guest && echo "guest:guest"|chpasswd)

WORKDIR /app
COPY 'run-wait' .
EXPOSE 8787
CMD [ "./run-wait" ]
