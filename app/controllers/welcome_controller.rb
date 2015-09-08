class WelcomeController < ApplicationController
  def index
    @tasks = current_user.tasks.root_tasks
  end
end
