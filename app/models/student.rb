require 'bcrypt'

class Student < ActiveRecord::Base
  include BCrypt
	validates :name, presence: true, uniqueness: true
	validates :password_hash, presence: true, length: { minimum: 4 }
	validates :email, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
	has_many :students_tutors, dependent: :destroy
	has_many :tutors, through: :students_tutors
	validate :capital_name

  def capital_name
    if !name.nil?
      unless /[[:upper:]]/.match(name[0])
        errors.add(:name, 'name is not capitalized')
      end
      errors.add(:name, "name can't be empty") if name.empty?
    end
  end

  def password
    if !password_hash.nil?
      @password_hash ||= Password.new(password_hash)
    else
      @password_hash = ''
    end
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def meetings
    st = StudentsTutor.where(student_id: id)
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
