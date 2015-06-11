class UsersController < ApplicationController

  def index
    @user_details = User.all
  end

  def register
    puts "**********************"
    puts params
    @new_user = User.new
  end

  def signup
    @new_user = User.new(user_register)
    if @new_user.save
      session[:user] = User.authenticate(@user.name,@user.password)
      redirect_to :action=>"welcome"
    else
      redirect_to :action=>"login"
    end
  end

  def login
    puts params
    if request.get?
      session[:user] = User.authenticate(params[:user][:name], params[:user][:password])
      redirect_to :action=>"welcome"
    else
      redirect_to :action=>"signup"
    end
  end

  def welcome
  end


  def user_register
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

end
