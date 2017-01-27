class JobsController < ApplicationController
  TOKEN = ENV['API_KEY']
  include CategoryHelper
  include ErrorHelper
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate
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
    render json: @job
  end

  # POST /jobs
  #create
  def create
    @category = check_category(params[:category_id])
    @job = Job.new(job_params)
    @job.category = @category
    if @job.save
      render json: @job, status: :created, location: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  #POST /jobs/:id job application submission via API
  def submission
    if @job.status?
      @application = Application.new(application_params)
      if @application.save
        render json: @application, status: :created
      else
        render json: @application.errors, status: :unprocessable_entity
      end
    else
      render plain: not_active, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jobs/1
  #update
  def update
    @category = check_category(params[:category])
    if @job.update(job_params)
      @job.update(category_id: @category)
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

    def application_params
      params.require(:application).permit(:name, :email, :cover, :cv)
    end
    # Only allow a trusted parameter "white list" through.
    def job_params
      params.require(:job).permit(:title, :description, :permanent, :category_id, :status)
    end


    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        ActiveSupport::SecurityUtils.secure_compare(
          ::Digest::SHA256.hexdigest(token),
          ::Digest::SHA256.hexdigest(TOKEN)
        )
      end
    end


end
