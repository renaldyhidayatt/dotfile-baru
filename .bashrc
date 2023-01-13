## Path Dart lang
export DART_SDK=$HOME/Android/flutter/bin/cache/dart-sdk/bin/
export PATH=$DART_SDK:$PATH

## Path Flutter
export FLUTTER_PATH=$HOME/Android/flutter
export PATH=$FLUTTER_PATH/bin:$PATH

## package manager php
export COMPOSER_HOME=$HOME/.config/composer/vendor
export PATH=$COMPOSER_HOME/bin:$PATH

## package manager rust
export CARGO_HOME=$HOME/.cargo
export PATH=$CARGO_HOME/bin:$PATH

## Path Rust
export RUST_SRC_PATH=/usr/lib/rustlib/src/rust/library
export PATH=$RUST_SRC_PATH:$PATH 

## Path BUN
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

## Path golang
export PATH="$PATH:$(go env GOPATH)/bin"
export GO111MODULE=on