require 'spec_helper'
require 'user'

describe User do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :email => "name@email.de",
      :password => "secret",
      :password_confirmation => "secret"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
  
  describe "Password encryption" do
    before(:each) do
      @user = User.create!(@valid_attributes)
    end
    
    describe "has_password? method" do
      it "should return true if the submitted password matches the existing" do
        @user.has_password?(@valid_attributes[:password]).should be_true
      end
      
      it "should return false if the submitted password doesn't matche the existing" do
        @user.has_password?("invalid").should be_false
      end
    end
    
#    it "should have a password encryption method" do
#      @user.respond_to?("encrypt_password").should be_true # same as...
#      @user.should respond_to(:encrypt_password)
#    end
    
    it "should have an encrypted_password attribute" do
      @user.respond_to?("encrypted_password").should be_true # same as...
      @user.should respond_to(:encrypted_password)
    end
    
    it "should set attribute encrypted_password, so it's not blank" do
      @user.encrypted_password.should_not be_blank
    end
    
  end
  
  describe "Password validations" do
    it "should reject an empty password" do
        User.create(@valid_attributes.merge(:password => "", :password_confirmation => "")).
          should_not be_valid
      end
    
    it "should require a matching password confirmation" do
      User.create(@valid_attributes.merge(:password => "secret1", :password_confirmation => "secret2")).
        should_not be_valid
    end
    
    it "should reject a password shorter than 5 characters" do
      short = "a" * 4
      User.create(@valid_attributes.merge(:password => short, :password_confirmation => short)).
      should_not be_valid
    end
    
    it "should reject a password longer than 30 characters" do
      long = "a" * 31
      User.create(@valid_attributes.merge(:password => long, :password_confirmation => long)).
        should_not be_valid
    end
    
  end
  
  
  it "should require a name" do
    no_name_user = User.new(@valid_attributes.merge(:name => ""))
    no_name_user.should_not be_valid # renders same result as
    no_name_user.valid?().should_not == true
  end
    
  it "should require an email-address" do
    no_email_user = User.new(@valid_attributes.merge(:email => ""))
    no_email_user.should_not be_valid # renders same result as
    no_email_user.valid?().should_not == true
  end
   
  it "should not have a name longer than 50 characters" do
    too_long_user = User.new(@valid_attributes.merge(:name => ("a" * 51)))
    too_long_user.should_not be_valid
  end
  
  it "should accept valid email address formats" do
    addresses = %w(name@somewhere.tl vorname.name@irgendwo.tl VORNAME_NAME@huhu.de name@subdom.dom.top)
    addresses.each do |address|
      valid_address_user = User.new(@valid_attributes.merge(:email => address))
      valid_address_user.should be_valid
    end
  end
    
  it "should reject invalid email address formats" do
    emails = ["name@somewhere,tl", "name@irgendwo VORNAME_NAME@huhu.", "name@subdom.dom.", "VORNAME_nochnvorname_NAME@huhu"]
    emails.each do |email|
      invalid_address_user = User.new(@valid_attributes.merge(:email => email))
      invalid_address_user.should_not be_valid
    end
  end
  
  it "should have a unique email" do
    User.create!(@valid_attributes)
    user_with_duplicate_emails = User.new(@valid_attributes)
    user_with_duplicate_emails.should_not be_valid
  end
  
  it "should reject user with email identical to existing upcase email" do
    User.create!(@valid_attributes)
    user_with_duplicate_upcase_email = User.new(@valid_attributes.merge(:email => @valid_attributes[:email].upcase))
    user_with_duplicate_upcase_email.should_not be_valid
  end
end
