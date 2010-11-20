require 'spec_helper'
require "webrat"

  Webrat.configure do |config|
    config.mode = :rails
  end

describe "LayoutLinks" do
  
  describe "wenn user nicht angemeldet" do
    
    it "sollte einen login link haben" do
      visit root_path
      response.should have_tag("a[href=?]", login_path, "Login")
    end
    
  end
    
    describe "solange der User angemeldet ist" do
      
      before(:each) do
        @user = Factory(:user)
        visit login_path
        fill_in :email, :with => @user.email
        fill_in :password, :with => @user.password
        click_button
      end
      it "sollte ein Logout-Link angezeigt werden" do
        visit root_path
        response.should have_tag("a[href=?]", logout_path, "Logout")
      end
      it "sollte ein Profil-Link angezeigt werden" do
        visit root_path
        response.should have_tag("a[href=?]", user_path(@user), "Profile")
      end
      
    end
  
  it "should have a home page at /" do
    get "/"
    response.should render_template("pages/home")
  end
  
  it "should have a contact page at /contact" do
    get "/contact"
    response.should render_template("pages/contact")
  end
  
  it "should have a about page at /about" do
    get "/about"
    response.should render_template("pages/about")
  end
  
  it "should have a help page at /help" do
    get "/help"
    response.should render_template "pages/help"
  end
  
  it "should have a help signup page at /users/new" do
     get "/signup"
     response.should render_template "users/new"
   end
   
   it "should have the right links on the layout" do
     visit root_path
     click_link "About"
     response.should render_template "pages/about"
     
     visit root_path
     click_link "Help"
     response.should render_template "pages/help"
   end
end
