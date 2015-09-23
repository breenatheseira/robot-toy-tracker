class RobotsController < ApplicationController
  before_action :set_robot, only: [:show, :edit, :update, :destroy]
  include RobotsHelper
  # GET /robots
  # GET /robots.json
  def index
    @robots = Robot.all
    redirect_to new_robot_path if @robots.empty?
  end

  # GET /robots/1
  # GET /robots/1.json
  def show
  end

  # GET /robots/new
  def new
    @robot = Robot.new
  end

  # GET /robots/1/edit
  def edit
  end

  # POST /robots
  # POST /robots.json
  def create
    @robot = Robot.new(robot_params)

    report_exists = transform_command_to_movement(@robot, params[:command])    
    respond_to do |format|
      if @robot.save
        format.html { 
          flash[:notice] = 'Robot was successfully created.'
          select_route(report_exists)
        }
        format.json { render :show, status: :created, location: @robot }
      else
        format.html { render :new }
        format.json { render json: @robot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /robots/1
  # PATCH/PUT /robots/1.json
  def update
    report_exists = transform_command_to_movement(@robot, params[:command])
    respond_to do |format|
      if @robot.update(robot_params)
        format.html { 
          flash[:notice] = 'Robot was successfully updated.' 
          select_route(report_exists)
        }
        format.json { render :show, status: :ok, location: @robot }
      else
        format.html { render :edit }
        format.json { render json: @robot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /robots/1
  # DELETE /robots/1.json
  def destroy
    @robot.destroy
    respond_to do |format|
      format.html { redirect_to robots_url, notice: 'Robot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_robot
      @robot = Robot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def robot_params
      params[:robot].permit(:name, :x_coordinate, :y_coordinate, :position, :command)
    end

    def select_route(report)
      if report
        redirect_to robot_path(@robot)
      else 
        redirect_to edit_robot_path(@robot)
      end
    end
end
