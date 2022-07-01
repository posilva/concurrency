#!/bin/bash

cd elixir && mix do deps.get, compile, release && cd ..
cd go && go build main.go & cd ..
cd rust && cargo build --release && cd ..



