class StudentsTutor < ActiveRecord::Base
  belongs_to :student
  belongs_to :tutor
  has_many :questions, dependent: :destroy
  has_many :meetings, dependent: :destroy
  has_many :homeworks, dependent: :destroy
end
