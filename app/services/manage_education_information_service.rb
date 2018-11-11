class ManageEducationInformationService
    def initialize(user)
        @user = user
    end

    def call(graduation_institution, graduation_course, graduation_year)
        any_information = (!graduation_institution.presence.nil?) || (!graduation_course.presence.nil?) || (!graduation_year.presence.nil?)
        education_information = @user.education_information

        if education_information.nil?
            if any_information
                education_information = EducationInformation.new(
                    graduation_institution: graduation_institution.presence,
                    graduation_course: graduation_course.presence,
                    graduation_year: graduation_year.presence)
                @user.education_information = education_information
            end
        else
            if any_information
                education_information.graduation_institution = graduation_institution.presence
                education_information.graduation_course = graduation_course.presence
                education_information.graduation_year = graduation_year.presence
                education_information.save
            else
                education_information.delete
            end
        end

    end
end