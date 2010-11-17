require 'spec_helper'

describe UsersController do
  
  integrate_views
  
  #Delete these examples and add some real ones
  it "should use UsersController" do
    controller.should be_an_instance_of(UsersController)
  end


  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new'
      response.should have_tag("title", /Sign Up/)
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
