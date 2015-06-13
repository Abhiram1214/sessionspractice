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
      session[:user] = User.authenticate(@new_user.name,@new_user.password)
      redirect_to :action=>"welcome"
    else
      redirect_to :action=>"login"
    end
  end

  def login
    puts params
    if request.post?
      session[:user] = User.authenticate(params[:user][:name], params[:user][:password])
      redirect_to :action=>"welcome"
    else
    #  redirect_to :action=>"signup"
    end
  end


  def logout
    session[:user] = nil
    flash[:message] = 'Logged out'
    redirect_to :action => 'login' 
  end

  def change_password

    puts "**********************"
    puts params
    puts "**********************"

    if request.post?
     @pass_change = User.new_password(params[:user][:name], params[:user][:password], params[:user][:new_password])
   end
  end

  def welcome
  end


  def user_register
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

end
