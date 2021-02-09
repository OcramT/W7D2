class User < ApplicationRecord
    attr_reader :password
    before_validation :ensure_session_token

    validates :email, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :session_token, presence: true, uniqueness: true
    validates :password, length: { minimum: 6, allow_nil: true}

    def self.generate_session_token
        SecureRandom::urlsafe_base64
    end

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
        #self._ calls a setter method defined for us in ActiveRecord
    end

    def is_password?(password)
        pass_check = BCrypt::Password.new(self.password_digest)
        pass_check.is_password?(password)
    end

    def self.find_by_credentials(email,password)
        user = User.find_by(email: email)
        if user && is_password?(password)
            user
        end
        nil
    end

end
