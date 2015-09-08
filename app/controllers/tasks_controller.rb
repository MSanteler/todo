class TasksController < ApplicationController

  def new
  	@task = Task.new()
  	@all_tasks = current_user.tasks
  	@parent_id_param = params[:parent]

  	respond_to do |format|
  	  format.js
  	end
  end

  def create
    @task = Task.new(task_params)

    edited_params = task_params
    if task_params[:parental_tasklet_attributes][:task_id].present?
    	@new_parent = Task.find(task_params[:parental_tasklet_attributes][:task_id])
      @task.associate_with_parent(@new_parent)
    else
      @task.parental_tasklet = nil
    end
    edited_params.delete(:parental_tasklet_attributes)

    @task.user_id = current_user.id
    if @task.save!(edited_params)
      redirect_to(root_path, :notice => 'Task was successfully created.')
    else
      render :action => "edit"
    end
  end

  def edit
    @task = Task.find(params[:id])
    @all_tasks = current_user.tasks

    respond_to do |format|
      format.js
    end
  end

  def update
    @task = Task.find(params[:id])

    @parental = @task.parental_tasklet

    edited_params = task_params
    if task_params[:parental_tasklet_attributes][:task_id].present?
      @new_parent = Task.find(task_params[:parental_tasklet_attributes][:task_id])
      @task.associate_with_parent(@new_parent)
    else
      @task.parental_tasklet = nil
    end
    edited_params.delete(:parental_tasklet_attributes)

    @task.user = current_user
    if @task.update_attributes!(edited_params)
      redirect_to(root_path, :notice => 'Task was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    @tasks = current_user.tasks.root_tasks
    respond_to do |format|
      format.js
    end
  end

  private
  
  # Strong Params
  def task_params
    params.require(:task).permit(:title, :description, :parental_tasklet_attributes => [:id, :task_id, :_destroy])
  end

end
