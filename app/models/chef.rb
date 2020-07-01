class Chef < ApplicationRecord
    before_save { self.email = email.downcase }

    validates :chefname, presence: true, length: { maximum: 30 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX },
              uniqueness: { case_sensitive: false }
    has_secure_password
    # has_secure_password makes password required on creation always, allow_nil makes it optional on update
    validates :password, presence: true, length: { minimum: 5 }, allow_nil: true

    has_many :recipes
end
