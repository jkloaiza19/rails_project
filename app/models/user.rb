class User < ApplicationRecord
    before_save { self.email = email.downcase }
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    validates :username, presence: true, uniqueness: { case_sensitive: true },
                        length: { minimum: 3, maximum: 25 }
                        
    validates :email, presence: true, uniqueness: { case_sensitive: true },
                        length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX }
                        
    has_many :articles
end