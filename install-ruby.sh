#!/bin/bash

if test $(uname) = 'Linux'; then
    apt-get install rubygems1.8
fi

gem install interactive_editor
gem install rails
gem install wirble
gem install plist

