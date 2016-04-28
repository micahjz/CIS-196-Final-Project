class Question < ActiveRecord::Base
  belongs_to :students_tutor
  has_many :comments, dependent: :destroy
  validates :text, presence: true
end
