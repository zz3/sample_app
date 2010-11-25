require 'spec_helper'

describe UsersController do
  
  integrate_views
  
  #Delete these examples and add some real ones
  it "should use UsersController" do
    controller.should be_an_instance_of(UsersController)
  end
  
  describe "Anmeldung zum edit/update" do

    before(:each) do
      @user = Factory(:user)
    end
    describe "für nicht angemeldete User" do
      it "sollte edit nicht zugänglich sein und ein redirect zum Login auslösen" do
        get :edit, :id => @user
        response.should redirect_to(login_path)
      end
      it "sollte update nicht zugänglich sein und ein redirect zum Login auslösen" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(login_path)
      end
    end
    describe "für angemeldete User" do
      before(:each) do
        wrong_user = Factory(:user, :email => "user@example.de")
        test_sign_in(wrong_user)  
      end
      it "sollte edit nur für das eigene Profil möglich sein" do
        get :edit, :id => @user
        response.should redirect_to(root_path)
      end
      it "sollte update nur für das eigene Profil möglich sein" do
        put :update, :id => @user
        response.should redirect_to(root_path)
      end
    end
  end
  
  describe "PUT 'update'" do
    
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
      User.should_receive(:find).with(@user).and_return(@user)
    end
    
    describe "Fehlschlag" do
      before(:each) do
        @invalid_attr = { :email => "", :name => "" }
        @user.should_receive(:update_attributes).and_return(false)
      end
      it "sollte zur Seite 'edit' führen" do
        put :update, :id => @user, :user => @invalid_attr
        response.should render_template(:edit)
      end
      it "sollte den richtigen Titel haben" do
        put :update, :id => @user, :user => @invalid_attr
        response.should have_tag("title", /profil bearbeiten/i)
      end
    end
      
      describe "Erfolg" do
        before(:each) do
          @valid_attr = { :email => "hein2@hein.de", :name => "Hein Blöd junior" }
          @user.should_receive(:update_attributes).and_return(true)
        end
        it "sollte eine Flash-Message habe" do
          put :update, :id => @user, :user => @valid_attr
          flash[:success] =~ /erfolgreich/i
        end
        it "sollte zur Seite User show leiten" do
          put :update, :id => @user, :user => @valid_attr
          response.should redirect_to(user_path(@user))
        end
      end
      
    end
    
  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = {:name => "", :email => "", :password => "", :password_confirmation => "" }
        @user = Factory.build(:user, @attr)
        User.stub!(:new).and_return(@user)
        @user.should_receive(:save).and_return(false)
      end
      it "sie sollte den richtigen Titel haben" do
        post(:create, :user => @attr)
        response.should have_tag("title", /sign up/i)
      end
      it "sie sollte die 'new'-Seite erneut darstellen" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end
      
    describe "success" do
      before(:each) do
        @attr = {:name => "Heiner Bloeder", :email => "xy@xy.de",
                  :password => "sehrgehein", :password_confirmation => "sehrgehein" }
        @user = Factory.build(:user, @attr)
        User.stub!(:new).and_return(@user)
        @user.should_receive(:save).and_return(true)
      end
#      it "sollte ein redirect auslösen zur Seite user show" do
#        post :create, :user => @attr
#        response.should redirect_to(user_path(@user))
#      end
      it "sollte eine Willkommens-Meldung ausgeben" do
        post :create, :user => @attr
        flash[:success].should =~ /willkommen/i
      end
      it "sollte den User einloggen (signed_in == true)" do
        post :create, :user => @attr
        controller.should be_signed_in
      end
    end
    
  end

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
    it "should have the right title" do
      get 'new'
      response.should have_tag("title", /Sign Up/)
    end
    it "sollte ein Eingabe-Feld mit dem Namen user[name] haben" do
      get :new
      response.should have_tag("input[name=?][type=?]", "user[name]", "text")
    end
    it "sollte ein Eingabe-Feld mit dem Namen user[email] haben" do
      get :new
      response.should have_tag("input[name=?][type=?]", "user[email]", "text")
    end
    it "sollte ein Eingabe-Feld mit dem Namen user[password] haben" do
      get :new
      response.should have_tag("input[name=?][type=?]", "user[password]", "password")
    end
    it "sollte ein Eingabe-Feld mit dem Namen user[password_confirmation] haben" do
      get :new
      response.should have_tag("input[name=?][type=?]", "user[password_confirmation]", "password")
    end
  end
  
  describe "GET 'show'" do
    before(:each) do
      @user = Factory(:user)
#      Arrange for User.find(params[:id]) to find the right user.
      User.stub!(:find, @user_id).and_return(@user)
    end
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
    it "should have the right title" do
      get :show, :id => @user
      response.should have_tag("title", /#{@user.name}/)
    end
    it "sollte den Namen des Users beinhalten" do
      get :show, :id => @user
      response.should have_tag("h2", /#{@user.name}/)
    end
    it "sollte ein Bild aus dem User-Profil beinhalten" do
      get :show, :id => @user
      response.should have_tag("h2>img", :class => "gravatar")
    end
  end
  
  describe "GET 'edit'" do
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end
    it "sollte erfolgreich sein" do
      get :edit, :id => @user
      response.should be_success
    end
    it "sollte den richtigen Titel haben" do
      get :edit, :id => @user
      response.should have_tag("title", /Profil bearbeiten/i)
    end
    it "sollte einen Link zum Ändern des Avatar haben" do
      get :edit, :id => @user
      gravatar_url = "http://gravatar.com/emails"
      response.should have_tag("a[href=?]", gravatar_url, /ändern/i)
    end
  end
end
