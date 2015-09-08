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

    if task_params[:parental_tasklet_attributes][:task_id].present?
    	@new_parent = Task.find(task_params[:parental_tasklet_attributes][:task_id])
      @task.associate_with_parent(@new_parent)
    else
      @task.parental_tasklet = nil
    end

    if @task.save(task_params)
      redirect_to(root_path, :notice => 'Task was successfully created.')
    else
      format.html { render :action => "edit" }
    end
  end

  def edit
    @task = Task.find(params[:id])
    @all_tasks = current_user.all_tasks

    respond_to do |format|
      format.js
    end
  end

  def update
    @task = Task.find(params[:id])

    @parental = @task.parental_tasklet

    if task_params[:parental_tasklet_attributes][:task_id].present?
      @new_parent = Task.find(task_params[:parental_tasklet_attributes][:task_id])
      @task.associate_with_parent(@new_parent)
    else
      @task.parental_tasklet = nil
    end

    if @task.update_attributes(task_params)
      redirect_to(root_path, :notice => 'Task was successfully updated.')
    else
      format.html { render :action => "edit" }
    end
  end

  private
  
  # Strong Params
  def task_params
    params.require(:task).permit(:title, :description, :parental_tasklet_attributes => [:id, :task_id, :_destroy]).merge(user_id: current_user.id)
  end

end
