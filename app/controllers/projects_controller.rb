class ProjectsController < ApplicationController
  before_action :set_project, only: [ :show, :edit, :update, :destroy, :add_comment, :change_status ]

  def index
    @projects = Project.all
    respond_to do |format|
      format.html
      format.turbo_stream { render turbo_stream: turbo_stream.update("projects", partial: "projects/list", locals: { projects: @projects }) }
    end
  end

  def show
    @conversation_events = @project.conversation_history.includes(eventable: :replies)
    @new_comment = Comment.new
    @new_status_change = StatusChange.new
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      respond_to do |format|
        format.html { redirect_to projects_path, notice: "Project was successfully created." }
        format.turbo_stream { redirect_to projects_path }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream { render partial: "projects/edit_status_form", locals: { project: @project } }
      format.html # Fallback for non-Turbo requests
    end
  end

  def update
    if @project.update(project_params)
      respond_to do |format|
        format.html { redirect_to project_path(@project), notice: "Project was successfully updated." }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_path, notice: "Project was successfully deleted." }
      format.turbo_stream
    end
  end

  def add_comment
    @new_comment = @project.comments.new(comment_params)
    if @new_comment.save
      @project.project_events.create!(eventable: @new_comment) unless @new_comment.parent_id.present?
      respond_to do |format|
        format.html { redirect_to project_path(@project) }
        format.turbo_stream do
          if @new_comment.parent_id.present?
            render turbo_stream: [
              turbo_stream.append("replies_#{@new_comment.parent_id}",
                partial: "reply",
                locals: { reply: @new_comment }),
              turbo_stream.update("reply_form_#{@new_comment.parent_id}",
                partial: "reply_form",
                locals: { comment: @new_comment.parent, project: @project }),
              turbo_stream.update("new_comment_form",
                partial: "comment_form",
                locals: { new_comment: Comment.new, project: @project })
            ]
          else
            render turbo_stream: [
              turbo_stream.append("conversation_items",
                partial: "comment",
                locals: { comment: @new_comment }),
              turbo_stream.update("new_comment_form",
                partial: "comment_form",
                locals: { new_comment: Comment.new, project: @project })
            ]
          end
        end
      end
    else
      render :show, status: :unprocessable_entity
    end
  end

  def change_status
    @new_status_change = @project.status_changes.new(status_change_params)
    @new_status_change.old_status = @project.current_status

    if @new_status_change.save
      @project.project_events.create!(eventable: @new_status_change)
      @project.update!(current_status: @new_status_change.new_status)

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("project_status", partial: "projects/status", locals: { project: @project }),
            turbo_stream.append("conversation_items", partial: "projects/status_change", locals: { status_change: @new_status_change })
          ]
        end
        format.html { redirect_to project_path(@project) }
      end
    else
      @new_comment = Comment.new
      @conversation_events = @project.conversation_history
      render :show, status: :unprocessable_entity
    end
  end

  def conversation_history
    project_events
      .includes(:eventable)
      .where.not(eventable_type: "Comment", eventable: { parent_id: present? })
      .order(created_at: :desc)
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :current_status)
  end

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end

  def status_change_params
    params.require(:status_change).permit(:new_status)
  end
end
