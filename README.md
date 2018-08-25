# TODO:

- [x] permitir que usuário crie uma conta com email e senha
- [x] permitir que usuário faça contribuições
- [x] permitir que usuário consulte seu histórico de contribuições
- [ ] auto formatar o campo valor no form de pagamento (jquery mask)
- [ ] no dashboard, mostrar um gráfico do histórico total de contribuições do fundo
- [ ] permitir que usuário contribua sem estar conectado (guest checkout)

# Getting started

You can test payments with 4901720080344448 - this is a fake credit card. Use it moderately.

To cause a payment error, use a CVC number beginning with 6.

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

