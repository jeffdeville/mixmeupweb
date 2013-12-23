#!/bin/bash

log () {
  echo
  echo "** $@"
}

set -e

log "Installing necessary system packages"
if [ "$(uname)" == "Darwin" ]; then
  brew update
  brew install mongodb || log "They are already installed. Skipping."
fi

log "Installing gems"
gem install bundler
bundle install

log "Running the tests"
bundle exec rake
