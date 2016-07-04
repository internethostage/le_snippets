class Snippet < ApplicationRecord
  belongs_to :user
  belongs_to :language

  validates :name, presence: true, uniqueness: true
  validates :body, presence: true, length: { minimum: 10 }
end
