class Question < ActiveRecord::Base
  belongs_to :students_tutor
  has_many :comments
  validates :text, presence: true
end
