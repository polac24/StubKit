#!/usr/bin/env bash

source ~/.rvm/scripts/rvm
rvm use default
bundle exec pod trunk push --allow-warnings
