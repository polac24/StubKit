#!/usr/bin/env bash

bundle install
bundle exec pod --version
bundle exec pod lib lint
bundle exec pod trunk push
