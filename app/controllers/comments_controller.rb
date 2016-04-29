class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.question = Question.find(params[:question_id])
    @comment.user = current_user.name

    @comment.save
    redirect_to "/questions/#{StudentsTutor.find(params[:students_tutor_id]).student_id}/field/#{params[:students_tutor_id]}"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:text, :question_id)
  end
end
