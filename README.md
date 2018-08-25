# Getting started

4901720080344448 is a fake credit card. Use it moderately.

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
rails db:seed

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

# TODO:

- permitir que doador contribua sem estar logado (guest checkout)
- auto formatar o campo valor no form de pagamento (jquery mask)
