class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    # on vérifie si l'utilisateur existe bien ET si on arrive à l'authentifier (méthode bcrypt) avec le mot de passe
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        log_in(user)
        remember(user)
      else
        session[:user_id] = user.id
      end
      redirect_to root_path, notice: "Vous êtes maintenant connecté."
    # redirige où tu veux, avec un flash ou pas
    else
     flash.now[:danger] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
    log_out(current_user)
    redirect_to root_path
  end
end
