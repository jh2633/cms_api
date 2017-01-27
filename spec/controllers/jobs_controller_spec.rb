require 'rails_helper'


RSpec.describe JobsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Job. As you add validations to Job, be sure to
  # adjust the attributes here as well.


  x=Category.create!(title: "engineer")
  let(:valid_attributes) {
    {title: 'junior dev', description: 'we need someone to create a CMS for our job system',
  permanent: true, category_id: Category.find_by(title: 'engineer'), status: true}
  }

  let(:create_attributes) {
    {title: 'junior dev', description: 'we need someone to create a CMS for our job system',
  permanent: true, category_id: 'engineer', status: true}
  }

  let(:invalid_attributes) {
    {title: 'true', description: '123',
    permanent: false, category_id: 1}  }

  let(:inactive_job) {
    {title: 'junior dev', description: 'we need someone to create a CMS for our job system',
  permanent: true, category_id: Category.find_by(title: 'engineer'), status: false}
  }

  let(:valid_app) {
    {name: 'joseph huang', email: 'joseph@dontcrawlmyemail.com',
    cover: 'im an awesome candidate!', cv: 'awesome cv'}
    }


  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all jobs as @jobs" do
      job = Job.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:jobs)).to eq([job])
    end
  end

  describe "GET #show" do
    it "assigns the requested job as @job" do
      job = Job.create! valid_attributes
      get :show, params: {id: job.to_param}, session: valid_session
      expect(assigns(:job)).to eq(job)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Job" do
        expect {
          post :create, params: {job: create_attributes}, session: valid_session
        }.to change(Job, :count).by(1)
      end

      it "assigns a newly created job as @job" do
        post :create, params: {job: create_attributes}, session: valid_session
        expect(assigns(:job)).to be_a(Job)
        expect(assigns(:job)).to be_persisted
      end

      it "redirects to the created job" do
        post :create, params: {job: create_attributes}, session: valid_session
        expect(response).to have_http_status(201)
      end
    end

  end

  describe "POST #submission" do
    context "applicant submit an application to an active job" do
      it "creates and stores a new application" do
        job = Job.create! valid_attributes
        expect {
          post :submission, params: {id: job.to_param, application: valid_app}, session: valid_session
        }.to change(Application, :count).by(1)
      end
    end
    context "applicant submit an application to an inactive job" do
      it "does not create and store a new application" do
        inactive_job = Job.create! inactive_job
        expect {
          post :submission, params: {id: inactive_job.to_param, application: valid_app}, session: valid_session
        }.to change(Application, :count).by(0)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {title: 'senior dev', description: 'top secret project',
      permanent: true, category: 'accounting', status: true}
          }

      it "updates the requested job" do
        job = Job.create! valid_attributes
        put :update, params: {id: job.to_param, job: new_attributes}, session: valid_session
        job.reload
        expect(job.attributes).to include( { "title" => "senior dev" } )
      end

      it "assigns the requested job as @job" do
        job = Job.create! valid_attributes
        put :update, params: {id: job.to_param, job: valid_attributes}, session: valid_session
        expect(assigns(:job)).to eq(job)
      end

      it "gives status 202 accepted when updated successfully" do
        job = Job.create! valid_attributes
        put :update, params: {id: job.to_param, job: valid_attributes}, session: valid_session
        expect(response).to have_http_status(202)
      end
    end

    context "with invalid params" do
      it "assigns the job as @job" do
        job = Job.create! valid_attributes
        put :update, params: {id: job.to_param, job: invalid_attributes}, session: valid_session
        expect(assigns(:job)).to eq(job)
      end

    end
  end



end
