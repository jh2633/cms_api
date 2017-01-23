class JobsController < ApplicationController::API
  include CategoryHelper
  before_action :set_job, only: [:show, :update, :submission]
#features: read all, read one, create, update, deactivate, activate

  # GET /jobs
  # read all
  def index
    @jobs = Job.all

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
    @category = check_category(params[:category])
    @job = Job.new(title: params[:title], description: params[:description],
    permanent: params[:permanent], category: @category)
    if @job.save
      render json: @job, status: :created, location: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  def submission
    if @job.active?

    else

    end
  end

  # PATCH/PUT /jobs/1
  #update
  def update
    @category = check_category(params[:category])
    if @job.update(title: params[:title], description: params[:description],
      permanent: params[:permanent], category: @category)
      render json: @job, status: :accepted
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
      params.require(:job).permit(:title, :description, :permanent, :category_id)
    end

    def category_params
      params.require(:category).permit(:title)
    end


end
