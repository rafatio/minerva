class UserService
    def initialize
    end

    def assign_ambassador(user_email, ambassador_id)
        user = User.find_by_email(user_email)
        if user.nil?
            return { success: false, message: "Usuário não encontrado" }
        end

        ambassador = Ambassador.find_by_id(ambassador_id)
        if ambassador.nil?
            return { success: false, message: "Embaixador não encontrado" }
        end

        user.ambassador = ambassador
        user.save
        return { success: true, message: "OK" }
    end
end