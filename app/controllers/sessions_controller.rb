class SessionsController < ApplicationController
  def signup
  end
  
  def new_student
    render :new_student
  end

  def new_tutor
    render :new_tutor
  end

  def create_student
    @student = Student.find_by(name: params[:name])
    if !@student.nil?
      if @student.password_hash == params[:password]
        session[:user_id] = @student.id
        session[:tutor] = false
        redirect_to "/students/#{@student.id}"
      else
        render :new_student
      end 
    else
      render :new_student
    end
  end

  def new_student
    render :new_student
  end

  def create_tutor 
    @tutor = Tutor.find_by(name: params[:name])
    if !@tutor.nil?
      if @tutor.password_hash == params[:password]
        session[:user_id] = @tutor.id
        session[:tutor] = true
        redirect_to "/tutors/#{@tutor.id}"
      else
        render :new_tutor
      end
    else
      render :new_tutor
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
