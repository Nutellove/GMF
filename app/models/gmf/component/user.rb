# A User owns at least one Player
class Gmf::Component::User < ActiveRecord::Base
  devise :database_authenticatable, :registerable
  #devise :database_authenticatable, :registerable, :confirmable, :recoverable, :stretches => 20 # some more stuff, not working right now
  attr_accessible :email, :password, :password_confirmation
end
