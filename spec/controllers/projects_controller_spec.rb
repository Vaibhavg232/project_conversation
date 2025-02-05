require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:project) { create(:project) }

  let(:valid_attributes) {
    {
      title: "Test Project",
      description: "Test Description",
      current_status: "pending"
    }
  }

  let(:invalid_attributes) {
    {
      title: "",
      description: "",
      current_status: ""
    }
  }

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    let(:project) { create(:project) }

    before do
      # Create a comment to ensure conversation events exist
      comment = create(:comment, project: project)
      create(:project_event, project: project, eventable: comment)
    end

    it "returns a successful response" do
      get :show, params: { id: project.id }
      expect(response).to be_successful
    end

    it "assigns conversation events" do
      get :show, params: { id: project.id }
      expect(assigns(:conversation_events)).to be_present
    end
  end

  describe "GET #new" do
    it "returns a successful response" do
      get :new
      expect(response).to be_successful
    end

    it "assigns a new project" do
      get :new
      expect(assigns(:project)).to be_a_new(Project)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new Project" do
        expect {
          post :create, params: { project: valid_attributes }
        }.to change(Project, :count).by(1)
      end

      it "redirects to projects path" do
        post :create, params: { project: valid_attributes }
        expect(response).to redirect_to(projects_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Project" do
        expect {
          post :create, params: { project: invalid_attributes }
        }.not_to change(Project, :count)
      end

      it "renders new template" do
        post :create, params: { project: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "POST #add_comment" do
    let(:project) { Project.create!(valid_attributes) }
    let(:valid_comment_params) { { body: "Test comment" } }
    let(:invalid_comment_params) { { body: "" } }

    context "with valid parameters" do
      it "creates a new comment" do
        expect {
          post :add_comment, params: { id: project.id, comment: valid_comment_params }
        }.to change(Comment, :count).by(1)
      end

      it "creates a project event" do
        expect {
          post :add_comment, params: { id: project.id, comment: valid_comment_params }
        }.to change(ProjectEvent, :count).by(1)
      end
    end

    context "with invalid parameters" do
      it "does not create a comment" do
        expect {
          post :add_comment, params: { id: project.id, comment: invalid_comment_params }
        }.not_to change(Comment, :count)
      end

      it "renders show template" do
        post :add_comment, params: { id: project.id, comment: invalid_comment_params }
        expect(response).to render_template(:show)
      end
    end
  end

  describe "POST #change_status" do
    let(:project) { Project.create!(valid_attributes) }
    let(:valid_status_params) {
      {
        old_status: project.current_status,
        new_status: "in_progress"
      }
    }

    context "with valid parameters" do
      it "creates a new status change" do
        expect {
          post :change_status, params: { id: project.id, status_change: valid_status_params }
        }.to change(StatusChange, :count).by(1)
      end

      it "updates project status" do
        post :change_status, params: { id: project.id, status_change: valid_status_params }
        expect(project.reload.current_status).to eq "in_progress"
      end

      it "creates a project event" do
        expect {
          post :change_status, params: { id: project.id, status_change: valid_status_params }
        }.to change(ProjectEvent, :count).by(1)
      end
    end
  end

  describe "PATCH #update" do
    let(:project) { create(:project) }
    let(:new_attributes) { { current_status: 'completed' } }

    context "with valid parameters" do
      it "updates the project" do
        patch :update, params: { id: project.id, project: new_attributes }
        project.reload
        expect(project.current_status).to eq 'completed'
      end

      it "redirects to the project" do
        patch :update, params: { id: project.id, project: new_attributes }
        expect(response).to redirect_to(project_path(project))
      end
    end

    context "with invalid parameters" do
      it "renders edit template" do
        patch :update, params: { id: project.id, project: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end
end
