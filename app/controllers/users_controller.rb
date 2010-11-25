class UsersController < ApplicationController
  
  before_filter :authenticate, :only => [ :edit, :update ]
  before_filter :correct_user, :only => [ :edit, :update ]
    
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
  
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
      @user.password = @user.password_confirmation = ''
      render :action => 'new'
    end
  end

  def show
    @user = User.find params[:id]
    @title = "#{@user.name}"
  end

  def edit
    @title = "Profil bearbeiten"
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profil erfolgreich aktualisiert"
      redirect_to @user
    else
      @title = "Profil bearbeiten"
      render(:action => :edit)   
    end
  end
  
  private 
  
  def authenticate
    deny_access unless signed_in?
  end

end
