class User < ApplicationRecord
  has_secure_password

  has_many :snippets, dependent: :nullify

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :password, length: { minimum: 8 }

  def full_name
    "#{first_name} #{last_name}"
  end

end
