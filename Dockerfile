FROM ubuntu:16.04
RUN apt-get update
RUN apt-get install -y ghc
RUN apt-get install -y cabal-install
RUN cabal update
RUN cabal install HUnit

# docker build -t haskell_img .
# docker run -v $PWD:/root/haskell_tutorial --name haskell --entrypoint /bin/bash -i haskell_img
# docker start -i haskell
