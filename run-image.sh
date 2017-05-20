docker run \
       -it \
       -v $(pwd):/home/guest/work \
       --rm \
       -p 49000:8787 \
       $USER/rstudio .
