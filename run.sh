#!/bin/bash

# RVM if it's there.
if [ -s $HOME/.rvm/scripts/rvm ]; then
  source $HOME/.rvm/scripts/rvm
  export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
fi

# Change to wherever this script it located.
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Fire it up.
#bundle exec ruby invoice.rb
rackup -p 4567
