class EmployeesController < ApplicationController
  before_filter :require_login
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET /employees
  # GET /employees.json
  def index
    @employees = FullTimeEmployee.all + PartTimeEmployee.all
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)
    @employee.update_neccessary_fields

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render action: 'show', status: :created, location: @employee }
      else
        format.html { render action: 'new' }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.update_attribute(:is_deleted, true)
    respond_to do |format|
      format.html { redirect_to employees_url }
      format.json { head :no_content }
    end
  end

  def new_project
    @employee = Employee.where(["id = ?", params[:to]]).first
  end

  def create_project
    @employee = Employee.where(["id = ?", params[:employee][:to]]).first

    if @employee
      @employee.projects = []
      if params[:project_ids].present?
        params[:project_ids].each do |project_id|
          @employee.projects << Project.find(project_id)
        end
      end

      redirect_to @employee
    else
      redirect_to employees_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      allowed_params = [:name, :designation, :degree, :university, :college, :city, :experience, :address, :type]
      if params[:employee]
        params[:employee][:experience] = params[:employee][:experience].to_f
        params.require(:employee).permit(allowed_params)
      elsif params[:full_time_employee]
        params[:full_time_employee][:experience] = params[:full_time_employee][:experience].to_f
        params.require(:full_time_employee).permit(allowed_params)
      elsif params[:part_time_employee]
        params[:part_time_employee][:experience] = params[:part_time_employee][:experience].to_f 
        params.require(:part_time_employee).permit(allowed_params)
      end
    end
end
