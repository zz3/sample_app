require 'User'

class PagesController < ApplicationController
  def home
    @title = 'home'
    @user = User.new(:name => 'c', :email => 'c')
  end

  def contact
    @title = 'contact'
    @user = User.new(:name => 'c', :email => 'c')
  end
  
  def list
    @title = 'list'
  end
  
  def about
    @title = 'Über uns'
  end
  
  def help
    @title = 'Hilfe'
  end

end
