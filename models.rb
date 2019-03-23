require 'bundler/setup'
Bundler.require
if development?
ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
end


class User < ActiveRecord::Base
  has_secure_password
  has_many :quests
  has_many :frees2

end

class Quest < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
end

class Category < ActiveRecord::Base
  has_many :quests
end

class Frees2 < ActiveRecord::Base
  belongs_to :user
end