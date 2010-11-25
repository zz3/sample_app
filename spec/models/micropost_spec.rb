require 'spec_helper'

describe Micropost do
  before(:each) do
    @user = Factory(:user)
    @attr = {
      :content => "value for content",
    }
  end

  it "should create a new instance given valid attributes" do
    @user.microposts.create!(@attr)
  end
  
  describe "Verknüpfung mit User" do
    before(:each) do
      @micropost = @user.microposts.create!(@attr)
    end
    it "sollte das Attribut User haben" do
      @micropost.should respond_to(:user)
    end
    it "sollte mit dem richtigen User-Objekt verknüpft sein" do
      @micropost.user_id.should == @user.id
      @micropost.user.should == @user
    end
    
  end
end
