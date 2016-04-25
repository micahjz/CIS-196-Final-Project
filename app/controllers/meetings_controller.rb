class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  # GET /meetings
  # GET /meetings.json
  def index
    @meetings = Meeting.all
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    @meeting = Meeting.find(params[:id])
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings
  # POST /meetings.json
  def create
    students_tutor_id = StudentsTutor.where(student_id: params[:id], tutor_id: params[:tutor_id]).first.id
    begin 
      date = params[:meeting][:start]
      @meeting = Meeting.new(start: DateTime.parse(date), students_tutor_id: students_tutor_id)
        if DateTime.parse(date).future? && Tutor.find(params[:tutor_id]).conflict?(DateTime.parse(date)) && Student.find(params[:id]).conflict?(DateTime.parse(date))
          if @meeting.save
            redirect_to meeting_path(@meeting.id)
          else
            back_to_show
          end
        else
          back_to_show
        end
    rescue
      back_to_show
    end
  end

  def back_to_show
    @student = Student.find(params[:id])
    @meeting = Meeting.new
    @tutor = Tutor.find(params[:tutor_id])
    redirect_to "/students/#{params[:id]}/tutors/#{params[:tutor_id]}"
  end


  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
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
