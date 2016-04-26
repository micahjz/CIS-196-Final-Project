class Meeting < ActiveRecord::Base
  belongs_to :students_tutor
  validate :conflict_student?
  validate :conflict_tutor?
  validate :future?

  def conflict_student?
  	unless students_tutor.student.conflict?(start)
  	  errors.add(:start, "Date conflicts with the student's meeting")
  	end
  end

  def conflict_tutor?
  	unless students_tutor.tutor.conflict?(start)
  	  errors.add(:start, "Date conflicts with the tutor's meeting")
  	end
  end

  def future?
  	unless start.future?
  	  errors.add(:start, "Date must be a future date")
  	end
  end

  def capital_name
    if !name.nil?
      unless /[[:upper:]]/.match(name[0])
        errors.add(:name, 'name is not capitalized')
      end
      errors.add(:name, "name can't be empty") if name.empty?
    end
  end

  def start_time
  	start
  end
end
