class SessionsController < ApplicationController
 
  def new
    @title = "Login"
  end
  
  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    if user.nil?
      flash.now[:error] = "Ungültige Kombination von Email und Passwort"
      @title = "Login"
      render :action => :new
    else
      sign_in user
      redirect_to user
    end
  end
  
  def destroy
    sign_out
    redirect_to(root_path)
  end

end
