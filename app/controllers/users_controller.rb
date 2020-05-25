class UsersController < Devise::RegistrationsController

private

def sign_up_params
   params.require(:user).permit(:name,:gender,:email,:password,:password_confirmation)
end
end
