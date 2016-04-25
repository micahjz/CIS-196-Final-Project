class HomeworksController < ApplicationController
  def index
  	@students_tutor = StudentsTutor.where(student_id: params[:student_id], tutor_id: params[:tutor_id]).first
  	@files = @students_tutor.homeworks
  	render :index
  end

  def new
  	@students_tutor = StudentsTutor.where(student_id: params[:student_id], tutor_id: params[:tutor_id]).first
  	@file = Homework.new
  	render :new
  end

  def create
  	@file = Homework.new(homework_params)
  	@students_tutor = StudentsTutor.where(student_id: params[:student_id], tutor_id: params[:tutor_id]).first
  	@file.students_tutor = @students_tutor
  	@file.name = current_user.name

  	if @file.save
      redirect_to "/students/#{@students_tutor.student_id}/tutors/#{@students_tutor.tutor_id}/files", notice: "The file #{@file.name} has been uploaded."
    else
      render :new
    end
  end

  def destroy
  	@students_tutor = StudentsTutor.where(student_id: params[:student_id], tutor_id: params[:tutor_id]).first
  	@file = Homework.find(params[:file_id])
  	@file.destroy
  end

  private

  def homework_params
    params.require(:homework).permit(:name, :attachment, :description)
  end
end
