class User < ApplicationRecord
  acts_as_authentic do |c|
    c.login_field :email
  end
end
