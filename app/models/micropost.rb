class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
#  default_scope :order => 'created_at DESC'
end
