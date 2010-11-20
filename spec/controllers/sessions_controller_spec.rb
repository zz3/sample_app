require 'spec_helper'

describe SessionsController do

  integrate_views
  #Delete these examples and add some real ones
  it "should use SessionsController" do
    controller.should be_an_instance_of(SessionsController)
  end
  
  describe "DELETE 'destroy'" do
    it "sollte signout für einen User ausführen" do
      test_sign_in(Factory(:user))
      controller.should be_signed_in
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end
  end


  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    it "sollte den Seitentitel Login haben" do
      get :new
      response.should have_tag("title", /Login/i)
    end
  end
  
  describe "POST 'create'" do
    describe "login schlägt fehl" do
      before(:each) do
        @attr = {:name => "beispiel", :email => "beispiel@beispiel.com", 
                  :password => "geheim", :password_confirmation => "geheim"}
        User.should_receive(:authenticate).
          with(@attr[:email], @attr[:password]).
          and_return(nil)
      end
    end
    describe "login funktioniert" do
      before(:each) do
        @attr = {:name => "Hein Blöd", :email => "hein@hein.de", 
                  :password => "gehein", :password_confirmation => "gehein"}
        User.should_receive(:authenticate).
          with(@attr[:email], @attr[:password]).
          and_return(@user)
       end
    end
    describe "mit gültigen Email und Passwort" do
      before(:each) do
        @user = Factory(:user)
        @attr = { :email => @user.email, :password => @user.password }
        User.should_receive(:authenticate).
            with(@user.email, @user.password).
            and_return(@user)
      end
       it "sollte den User einloggen" do
         post :create, :session => @attr
         controller.current_user.should  == @user
         controller.should be_signed_in
       end
       it "sollte ein redirect auslösen zur Seite users show" do
         post :create, :session => @attr
         response.should redirect_to(user_path(@user))
       end
     end
  end
end
