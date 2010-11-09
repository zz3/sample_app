# == Schema Information
# Schema version: 20101108172558
#
# Table name: users
#
#  id                 :integer(4)      not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password , :password_confirmation
  
  before_save :encrypt_password
  
  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates_confirmation_of :password
  validates_length_of :password, :within => 5..30
  validates_presence_of :name, :email, :password
  validates_length_of :name, :maximum => 50
  validates_format_of :email, :with => EmailRegex
  validates_uniqueness_of :email, :case_sensitive => false
  
  def has_password?(submitted_password)
    self.encrypted_password == encrypt(submitted_password)
  end
  
  private
  
  def encrypt_password
    self.salt = make_salt
    self.encrypted_password = encrypt(self.password)
  end 
  
  def encrypt(string)
    secure_hash("#{salt}#{string}")
  end
  
  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
  
  def make_salt
    secure_hash("#{Time.now.utc}#{self.password}")
#    secure_hash("abc")
  end
end
