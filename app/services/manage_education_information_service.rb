# frozen_string_literal: true

class ManageEducationInformationService
  def initialize(user)
    @user = user
  end

  def call(education_informations_list)
    current_list = @user.education_informations
    current_list.destroy_all

    if !education_informations_list.empty?
      education_informations_list.each do |value|
        @user.education_informations.push(value)
      end
    end
  end
end
