class UsersController < ApplicationController
  def new
    @title = "Sign Up"
    @user = User.new
  end
  
  def show
    @user = User.find params[:id]
    @title = "#{@user.name}"
  end

end
