class SecretsController < ApplicationController
  def index
    @theUser = current_user
    #binding.pry
    @secrets = Secret.all
  end

  def create

      #POST from form, does the create
      puts 'In Create Secret'

      @user =  User.find(session[:user_id])
      @secret = Secret.new(content: params[:content], user: @user)
      #binding.pry
      if @secret.save
        redirect_to "/users/#{@user.id}"
      else
        puts 'Create Error'
        flash[:errors] = @user.errors.full_messages

        redirect_to "/users/#{@user.id}"
      end

    end

    def destroy
      #binding.pry
      Secret.find(params[:id]).destroy
      redirect_to "/users/#{session[:user_id]}"
    end



end
