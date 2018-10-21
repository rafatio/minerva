class ProfileController < ApplicationController
    before_action :authenticate_user!
    def index
        @person = current_user.person
        @contacts = current_user.contacts
        @address = current_user.address
        @professional_information = current_user.professional_information
        @education_information = current_user.education_information
        @intended_relationship = current_user.intended_relationship

        @countries = Country.all
    end

    def create
        flash[:notice] = 'Perfil atualizado com sucesso'
        redirect_to profile_index_path
    end
end
