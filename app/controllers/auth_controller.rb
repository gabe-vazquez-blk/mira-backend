class AuthController < ApplicationController

    def login
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            token = JWT.encode({user_id: user.id}, 'secret')
            render json: {user: user, token: token}
        else
            render json: {errors: "Invalid Credentials"}
        end
    end

    def auto_login
        if session_user
            render json: session_user
        else
            render json: {errors: "No User Found"}
        end
    end

end