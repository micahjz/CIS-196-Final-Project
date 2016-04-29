class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    @meeting = Meeting.find(params[:id])
  end

  # POST /meetings
  # POST /meetings.json
  def create
    students_tutor_id = StudentsTutor.where(student_id: params[:id], tutor_id: params[:tutor_id]).first.id
    begin 
      date = DateTime.parse(params[:meeting][:start])
    rescue
      back_to_show("not valid date format")
      return
    end
    @meeting = Meeting.new(start: date, students_tutor_id: students_tutor_id)
    if @meeting.save
      redirect_to "/meetings/#{@meeting.id}"
    else
      back_to_show(@meeting.errors.first.second)
    end
  end

  def back_to_show(s)
    @student = Student.find(params[:id])
    @meeting = Meeting.new
    @meeting.errors.add(:start, s)
    @tutor = Tutor.find(params[:tutor_id])
    respond_to do |format|
      format.html { render :"students/show" }
      format.json { render json: @meeting.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

end
