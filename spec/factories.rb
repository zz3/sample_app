Factory.define :user do |user|
  user.name                   "Christian"
  user.email                  "christian.cla@web.de"
  user.password               "topsecret"
  user.password_confirmation  "topsecret"
end

Factory.sequence :email do |n|
  "person-#{n}eieei@blad.de"
end

Factory.define :micropost do |micropost|
  micropost.content   "blah blah uhh uhh"
  micropost.association :user
end