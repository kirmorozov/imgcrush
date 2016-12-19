imgcrush
========

Recursively, losslessly and quickly compress JPG, PNG, GIF images.

Requirements:

* [mozjpeg](https://github.com/mozilla/mozjpeg)
* [pngcrush](http://pmt.sourceforge.net/pngcrush/)
* [gifsicle](http://www.lcdf.org/gifsicle/)

Usage:

```
Recursively, losslessly and quickly compress JPG, PNG, GIF images.

Usage: imgcrush [-c 2] [-o done] [DIRECTORY] ...
  -c <num>     concurrency from 1 to 8, defaults to 2
  -o <dir>     output directory, defaults to done
  --old-style  print results using old style

If no input directory provided, it will use current directory.
Images in output directory will not be used as input images.
You can set TERM_WIDTH environment variable if there's no tty.
```

Install:

If you have installed `go` already, run:

```
go get -u -v github.com/caiguanhao/imgcrush
```

Or run `imgcrush` in a Docker container:

```
# build the image first:
docker build -t imgcrush .

# run imgcrush in your current directory
docker run --rm -v="$(pwd):/imgcrush" -e "TERM_WIDTH=$(tput cols)" imgcrush -c 4 .

# or you can make an alias for the long Docker command
# alias imgcrush='docker run --rm -v="$(pwd):/imgcrush" -e "TERM_WIDTH=$(tput cols)" imgcrush'
```

Usage docker-based version recursive in-place replacements:
```
cd ./magento/media
wget https://raw.githubusercontent.com/kirmorozov/imgcrush/master/recomress_all.sh
sh recomress_all.sh > recomression.log
```

Usage gainst Magento media directory:
```
cd ./magento
mkdir -p ./optimizied/media
mkdir -p ./optimizied/skin
docker run --rm --user=33:33 -v="$(pwd):/imgcrush" komplizierte/imgcrush -c 4 -o ./optimized/media ./media > media85.log
docker run --rm --user=33:33 -v="$(pwd):/imgcrush" komplizierte/imgcrush -c 4 -o ./optimized/skin ./skin > skin85.log
```
Magento 1 media directory setup:
```
    location ~* \.(jpe?g|gif|css|png|js|ico|pdf|zip|tar|t?gz|mp3|wav|swf)$ {
	      try_files /optimized/$uri $uri $uri/;
        expires max;
    }
```


References:

* [Comparison of JPEG Lossless Compression Tools](
http://blarg.co.uk/blog/comparison-of-jpeg-lossless-compression-tools)
* [ImageOptim](https://github.com/pornel/ImageOptim)
* [bounded.go](http://blog.golang.org/pipelines/bounded.go)
