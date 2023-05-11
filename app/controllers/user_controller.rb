class UserController < ApplicationController
  def index
  end

  def create
    user = User.create(first_name: params[:first_name], last_name: params[:last_name], description: params[:description], age: params[:age], city_id: params[:city_id], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if user.save
      session[:user_id] = user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def new
  end

  def edit
  end

  def show
    @current_user = User.find(params[:id].to_i)
  end

  def update
  end

  def destroy
  end
end
