require 'bcrypt'
class Tutor < ActiveRecord::Base
	include BCrypt
	validates :name, presence: true, uniqueness: true
	validates :password_hash, presence: true, length: { minimum: 4 }
	validates :email, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
	has_many :students_tutors, dependent: :destroy
	has_many :students, through: :students_tutors
	validate :capital_name
	validates :field, presence: true
	validate :capital_name
	validate :capital_field

	def capital_name
    if !name.nil?
      unless /[[:upper:]]/.match(name[0])
        errors.add(:name, 'name is not capitalized')
      end
      errors.add(:name, "name can't be empty") if name.empty?
    end
  end

  def capital_field
    if !field.nil?
      unless /[[:upper:]]/.match(field[0])
        errors.add(:field, 'field is not capitalized')
      end
      errors.add(:field, "field can't be empty") if field.empty?
    end
  end

  def meetings
    st = StudentsTutor.where(tutor_id: id)
    meetings = []
    st.each do |s|
      (meetings << s.meetings).flatten!
    end
    meetings.sort! { |a, b| a.start <=> b.start }
  end
  
  def conflict?(dt)
    boo = true
    meetings.each do |meeting|
      if meeting.start.to_date === dt.to_date && meeting.start.hour == dt.hour
        boo = false
      end
    end
    boo
  end
end
