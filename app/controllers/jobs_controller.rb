class JobsController < ApplicationController
  include CategoryHelper
  include ActionController::HttpAuthentication::Token::ControllerMethods
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
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jobs/1
  #update
  def update
    @category = check_category(params[:category])
    if @job.update(title: params[:title])
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
      params.require(:job).permit(:title, :description, :permanent, :category_id)
    end

    # def authenticate
    #   authenticate_or_request_with_http_token do |token, options|
    #       token == ENV["API_KEY"] ? self.auth_token = token :
    #   end
    # end


end
