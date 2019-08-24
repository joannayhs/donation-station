class User < ActiveRecord::Base
    has_secure_password

    has_many :donations 
    has_many :charities

    validates :username, presence: true, uniqueness: true, length: {is: 5}
    validates :password, :presence => true
end 