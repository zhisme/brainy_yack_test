class Story < ApplicationRecord
  validates :name, presence: true

  has_many :articles, dependent: :destroy
end
