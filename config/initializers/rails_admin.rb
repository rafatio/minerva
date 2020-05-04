# frozen_string_literal: true

RailsAdmin.config do |config|
  config.parent_controller = '::ApplicationController'

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.authorize_with do
    redirect_to main_app.authenticated_root_path unless current_user.admin
  end

  config.model 'User' do
    object_label_method do
      :custom_label_method
    end
  end

  config.model 'Ambassador' do
    field :user do
      label 'User (Ambassador)' # Change the label of this field
    end

    field :users do
      label 'Users (Referees)' # Change the label of this field
    end

    field :course
    field :admission_year
    field :is_active

  end


  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end

def custom_label_method
  if custom_name.blank?
    custom_id
  else
    custom_name + " (#{custom_id})"
  end
end