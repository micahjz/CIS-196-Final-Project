class Meeting < ActiveRecord::Base
  belongs_to :students_tutor
  def start_time
  	start
  end
end
