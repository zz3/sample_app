require 'spec_helper'
require 'user'

describe User do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :email => "name@email.de"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
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
