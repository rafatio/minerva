# Getting started

You can test payments with 4901720080344448 - this is a fake credit card. Use it moderately.

To cause a payment error, use a CVC number beginning with 6.

## Mac Setup

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
```

## Docker
```
# build image
docker build -t minerva_fundo .

# run the app
docker run -v `pwd`:/app -p 3000:3000 -d minerva_fundo
```
