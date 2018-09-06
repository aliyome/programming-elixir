@echo off
docker run --rm -it -v %CD%:/root -w /root elixir:latest %*
