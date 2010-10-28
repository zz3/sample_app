# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # gebe title jeweils für jede Seite zurück
  def title
    base_title = "Die Sample App, ein Rails-Tutorium"
    if @title.nil?()
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
