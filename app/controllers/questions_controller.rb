class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def qa
    @questions = StudentsTutor.find(params[:students_tutor_id]).questions.all.reverse
    @students_tutor = StudentsTutor.find(params[:students_tutor_id])
    @student = @students_tutor.student
    @comment = Comment.new
    render :qa
  end

  def delete
    @question = Question.find(params[:question_id])
    @question.destroy
    qa
  end

  # GET /questions/new
  def new
    @question = Question.new
    @students_tutor = StudentsTutor.find(params[:students_tutor_id])
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.students_tutor = StudentsTutor.find(params[:students_tutor_id])
    if @question.save
      redirect_to "/questions/#{current_user.id}/field/#{params[:students_tutor_id]}"
    else
      @question = Question.new
      @students_tutor = StudentsTutor.find(params[:students_tutor_id])
      render :new
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:text, :students_tutor_id)
  end
end
