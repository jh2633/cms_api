class JobsController < ApplicationController
  before_action :set_job, only: [:show, :update, :destroy]
#features: read all, read one, create, update, deactivate, activate

  # GET /jobs
  # read all
  def index
    if params[:status] == "activated"
      @jobs = Job.activated
    else
      @jobs = Job.deactivated
    end
    render json: @jobs
  end

  # GET /jobs/1
  #read one
  def show
    #
    render json: @job
  end

  # POST /jobs
  #create
  def create
    @job = Job.new(job_params)

    if @job.save
      render json: @job, status: :created, location: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jobs/1
  #update
  def update
    if @job.update(job_params)
      render json: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def job_params
      params.require(:job).permit(:title, :description, :permanent)
    end
end