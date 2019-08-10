class User < ActiveRecord::Base
    has_secure_password
    
    has_many :donations 
    has_many :charities, through: :donations
end 