class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :require_correct_user, only: [:edit, :show, :update, :destroy]

  def index
  end

  def show
    puts 'In Show'
    @user = User.find(session[:user_id])
    @mySecrets = Secret.all.where(user: @user)
    @secretsLiked = @user.secrets_liked.all
    #binding.pry
  end

  def create
    #POST from form, does the create
    puts 'In Create'
    formParams = params[:user]

    #@user = User.new(name: formParams[:name], email: formParams[:email], password: formParams[:password], password_confirmation: formParams[:password_confirmation])
    @user = User.new(user_params)
    binding.pry

    if @user.save
      #user created, hve them logon now
      redirect_to "/sessions/new"
    else
      puts 'Create Error'
      flash[:errors] = @user.errors.full_messages
      # redirect_to :back
      redirect_to "/users/new"
    end
  end

  def new
    #shows form
  end

  private

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def require_correct_user
      if current_user != User.find(params[:id])
        redirect_to "/users/#{session[:user_id]}"
      end
    end

end
