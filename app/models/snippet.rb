class Snippet < ApplicationRecord
  belongs_to :user
  belongs_to :language

  validates :name, presence: true, uniqueness: { scope: :language_id }
  validates :body, presence: true, length: { minimum: 10 }
end
