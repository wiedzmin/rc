#!/bin/bash

telegram-cli --json -P 9009 -v 0 &
ruby telegram-history-dump.rb --kill-tg

