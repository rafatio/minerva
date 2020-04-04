# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w(vendor/card-js.min.js)
Rails.application.config.assets.precompile += %w(mask/jquery.maskMoney.min.js)
Rails.application.config.assets.precompile += %w(mask_currency_field.js)
Rails.application.config.assets.precompile += %w(bootstrap-table/bootstrap-table.js)
Rails.application.config.assets.precompile += %w(jquery-mask/jquery.mask.min.js)
Rails.application.config.assets.precompile += %w(mask_profile.js)
Rails.application.config.assets.precompile += %w(table_secondary_mail.js)
