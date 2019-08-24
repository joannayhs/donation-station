class User < ActiveRecord::Base
    has_secure_password

    has_many :donations 
    has_many :charities

    validates :username, presence: true, uniqueness: true, length: {minimum: 5}
    validates :password, presence: true, length: {minimum: 6}
end 