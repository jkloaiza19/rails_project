class Article < ApplicationRecord
    validates :title, presence: true, length: { minimum: 8, maximum: 72 }
    validates :description, presence: true, length: { minimum: 16, maximum: 300 }
    
    scope :recent, -> { order(created_at: :desc) }
    scope :author, -> (author) { where('author == ?', author) }
    scope :category, -> (cat) { where('category == ?', cat) }
    
     belongs_to :user
end
