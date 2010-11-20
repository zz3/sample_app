require 'spec_helper'

describe UsersController do
  
  integrate_views
  
  #Delete these examples and add some real ones
  it "should use UsersController" do
    controller.should be_an_instance_of(UsersController)
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
        @attr = {:name => "Heiner Bloeder", :email => "xy@xy.de", :password => "sehrgehein", :password_confirmation => "sehrgehein" }
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
end
