class UsersController < ApplicationController
  def new
    @title = "Sign Up"
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Willkommen bei der SampleApp!"
      sign_in @user
      redirect_to @user
    else
      @title = "Sign Up"
      @user.password = ''
      @user.password_confirmation = ''
      render :action => 'new'
    end
  end
  
  def show
    @user = User.find params[:id]
    @title = "#{@user.name}"
  end

end
