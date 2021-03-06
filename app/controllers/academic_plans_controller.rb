# frozen_string_literal: true

# controller for AcademicPlans class
class AcademicPlansController < ApplicationController
  before_action :set_student
  before_action :set_academic_plan, only: %i[show edit update destroy]

  # GET /academic_plans or /academic_plans.json
  def index
    @academic_plans = @student.academic_plans
  end

  # GET /academic_plans/1 or /academic_plans/1.json
  def show; end

  # GET /academic_plans/new
  def new
    # binding.pry
    @academic_plan = @student.academic_plans.build
    7.times { @academic_plan.courses.build }
    @academic_plan.build_advised_term
  end

  # GET /academic_plans/1/edit
  def edit
    7.times { @academic_plan.courses.build }
  end

  # POST /academic_plans or /academic_plans.json
  def create
    @academic_plan = @student.academic_plans.create(student_academic_plan_params)
    respond_to do |format|
      if @academic_plan.save
        format.html { redirect_to student_academic_plan_path(@student, @academic_plan), notice: 'Academic plan was successfully created.' }
        format.json { render :show, status: :created, location: @academic_plan }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @academic_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /academic_plans/1 or /academic_plans/1.json
  def update
    # binding.pry
    respond_to do |format|
      if @academic_plan.update(student_academic_plan_params)
        format.html { redirect_to student_academic_plan_path(@student, @academic_plan), notice: 'Academic plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @academic_plan }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @academic_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /academic_plans/1 or /academic_plans/1.json
  def destroy
    @academic_plan.destroy
    respond_to do |format|
      format.html { redirect_to student_academic_plans_path, notice: 'Academic plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_student
    @student = Student.find(params[:student_id])
  end

  def set_academic_plan
    # @student = Student.find(params[:id])
    @academic_plan = @student.academic_plans.find(params[:id])
    # @academic_plan.build_advised_term
  end

  # Only allow a list of trusted parameters through.
  def student_academic_plan_params
    params.require(:academic_plan).permit(:academic_plan_note, :id,
                                          courses_attributes: %i[id course_code _destroy advised_term],
                                          advised_term_attributes: %i[id academic_term_code _destroy])
  end
end
