# Getting started

## Mac

```
# install rbenv
brew install rbenv

# add the following to .bashrc, .bash_profile, .zshrc, whatever
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# install ruby
rbenv install 2.5.1
rbenv rehash

# download the repository
git clone https://github.com/fundominerva/minerva.git
cd minerva

# install project dependencies
gem install bundler
bundle install

# setup database
rails db:migrate

# start the application
rails s

# setup heroku
brew install heroku/brew/heroku
heroku login

# deploy
git remote add production https://git.heroku.com/touts-production.git
git remote add staging https://git.heroku.com/touts-staging.git
staging deploy
```
