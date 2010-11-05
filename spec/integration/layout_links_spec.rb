require 'spec_helper'
require "webrat"

  Webrat.configure do |config|
    config.mode = :rails
  end

describe "LayoutLinks" do
  it "should have a home page at /" do
    get "/"
    response.should render_template "pages/home"
  end
  
  it "should have a contact page at /contact" do
    get "/contact"
    response.should render_template "pages/contact"
  end
  
  it "should have a about page at /about" do
    get "/about"
    response.should render_template "pages/about"
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
