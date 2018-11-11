class ManageIntendedRelationshipService
    def initialize(user)
        @user = user
    end

    def call(associate, financial, mentoring, tutoring, remarks)
        if @user.intended_relationship.nil?
            intended_relationship = IntendedRelationship.new
        else
            intended_relationship = @user.intended_relationship
        end

        intended_relationship.associate = associate
        intended_relationship.financial = financial
        intended_relationship.mentoring = mentoring
        intended_relationship.tutoring = tutoring
        intended_relationship.remarks = remarks.presence

        @user.intended_relationship = intended_relationship

    end
end