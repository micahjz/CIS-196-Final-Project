require 'date'

class TutorsController < ApplicationController
  before_action :set_tutor, only: [:show, :edit, :update, :destroy]

  # GET /tutors
  # GET /tutors.json
  def index
    @tutors = Tutor.all
  end

  # GET /shop
  def choose
    @tutors = Tutor.all
    render :choose
  end

  def drop
    @tutor = Tutor.find(params[:id])
    current_user.tutors.delete @tutor
    current_user.save
    redirect_to '/shop'
  end

  def search
    if params[:q].nil?
      @tutors = Tutor.all
      render :choose
    else
      @tutors = Tutor.where(field: params[:q])
      @tutors = Tutor.all if params[:q].empty?
      render :choose
    end
  end

  def book
    @tutor = Tutor.find(params[:id]) 
    current_user.tutors.append @tutor
    redirect_to "/shop"
  end

  # GET /tutors/1
  # GET /tutors/1.json
  def show
    if logged_in? && tutor?
      if current_user == @tutor
        str = "Th, 14 April 2016, 01:20:00 (UTC)"
        date = DateTime.parse str
        @meetings = []
        @meetings.append Meeting.new(students_tutor_id: 1, start: date)
      end
    end
  end

  # GET /tutors/new
  def new
    @tutor = Tutor.new
  end

  # GET /tutors/1/edit
  def edit
  end

  # POST /tutors
  # POST /tutors.json
  def create
    @tutor = Tutor.new(tutor_params)

    respond_to do |format|
      if @tutor.save
        session[:user_id] = @tutor.id
        session[:tutor] = true
        format.html { redirect_to @tutor, notice: 'Tutor was successfully created.' }
        format.json { render :show, status: :created, location: @tutor }
      else
        format.html { render :new }
        format.json { render json: @tutor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tutors/1
  # PATCH/PUT /tutors/1.json
  def update
    respond_to do |format|
      if @tutor.update(tutor_params)
        format.html { redirect_to @tutor, notice: 'Tutor was successfully updated.' }
        format.json { render :show, status: :ok, location: @tutor }
      else
        format.html { render :edit }
        format.json { render json: @tutor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tutors/1
  # DELETE /tutors/1.json
  def destroy
    @tutor.destroy
    respond_to do |format|
      format.html { redirect_to tutors_url, notice: 'Tutor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tutor
      @tutor = Tutor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tutor_params
      params.require(:tutor).permit(:name, :password_hash, :email, :field)
    end
end
