class SchedulesController < ApplicationController
  before_action :set_schedule, only: %i[ show edit update destroy update_datetime]
  before_action :authenticate_user!

  # GET /schedules or /schedules.json
  def index
    @schedules = current_user.schedules.all
    @schedule = Schedule.new
  end

  # GET /schedules/1 or /schedules/1.json
  def show
    render layout: false
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
  end

  # GET /schedules/1/edit
  def edit
    render layout: false
  end

  # POST /schedules or /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.user_id = current_user.id
      if @schedule.save
        redirect_to schedules_path
      end
  end

  # PATCH/PUT /schedules/1 or /schedules/1.json
  def update
      if @schedule.update(schedule_params)
        redirect_to schedules_path
      end
  end

  def update_datetime
    @schedule.update(start: params[:start], end: params[:end])
  end

  # DELETE /schedules/1 or /schedules/1.json
  def destroy
    @schedule.destroy
    respond_to do |format|
      format.html { redirect_to schedules_url, notice: "Schedule was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = current_user.schedules.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def schedule_params
      params.require(:schedule).permit(:title, :description, :start, :end)
    end
end
