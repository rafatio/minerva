#!/bin/bash
rake assets:precompile
rails db:migrate
rake tmp:clear
rake log:clear
puma -C /app/config/puma.rb
