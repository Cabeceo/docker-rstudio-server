docker-rstudio-server
=====================

Docker image that runs rstudio server. Inspired by
[this rstudio-server docker](https://github.com/mgymrek/docker-rstudio-server),
with some philosophical differences:

* Avoid ubuntu mal/bloatware
* Add latest R packages via `cran` [current `R` version: `3.3.0`]
* Add `r-recommended` and other R packages via `apt-get`

## Build

```sh
./build-image.sh
```

## Run

```
./run-image.sh
```

Edit this script to change the port, if needed.

## Visit RStudio

```sh
http://localhost:49000
```

username: `guest`
password `guest`
