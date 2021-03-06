class JobsController < ApplicationController
  TOKEN = ENV['API_KEY']
  require './lib/email_api.rb'
  include ObjCreation
  include ErrorMessages
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate
  before_action :set_job, only: [:show, :update, :submission]
  before_action :set_keywords, :set_category, only: [:create, :update]
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
    @job = Job.new(job_params)
    @job.category = @category
    @job.keywords.concat @keywords
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
      email_api = Email_api.new
      if email_api.email(@application)
        render json: @application, status: :OK
      else
        render json: @application.errors, status: :bad_request
      end
    else
      render plain: job_not_active, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jobs/1
  #update/activate/deactivate jobs
  def update
    if @job.update(job_params)
      @job.update(category: @category)
      @job.update(keywords: @keywords)
      render json: @job, status: :accepted
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  private
    def set_job
      @job = Job.find(params[:id])
    end

    def application_params
      params.require(:application).permit(:name, :email, :cover, :cv)
    end

    def job_params
      params.require(:job).permit(:title, :description, :permanent, :category_id,
      :status)
    end

    def set_keywords
      @keywords = check_keyword(params[:keywords])
    end

    def set_category
      @category = check_category(params[:category_id])
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
