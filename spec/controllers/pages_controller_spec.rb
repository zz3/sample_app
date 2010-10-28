require 'spec_helper'

describe PagesController do
  
  integrate_views
  
  before :each do
    @base_title = "Die Sample App, ein Rails-Tutorium"
  end
  
  #Delete these examples and add some real ones
#  it "should use PagesController" do
#    controller.should be_an_instance_of(PagesController)
#  end


  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'home'
      response.should(have_tag("title", "#{@base_title} | home"))
      end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'contact'
      response.should(have_tag("title", "#{@base_title} | contact"))
    end
  end
  
  describe("GET 'list'") do
    it "should be successful" do
      get 'list'
      response.should(be_success)
    end
    
    it "should have the right title" do
      get 'list'
      response.should(have_tag("title", "#{@base_title} | list"))
    end
  end
  
  describe("GET 'about'") do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    it "should have the right title" do
      get 'about'
      response.should(have_tag("title", "#{@base_title} | Über uns"))
    end
  end
  
  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'help'
      response.should(have_tag("title", "#{@base_title} | Hilfe"))
    end
  end
end
