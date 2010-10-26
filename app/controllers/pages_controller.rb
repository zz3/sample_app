class PagesController < ApplicationController
  def home
    @title = 'home'
  end

  def contact
    @title = 'contact'
  end
  
  def list
    @title = 'list'
  end
  
  def about
    @title = 'Über uns'
  end

end
