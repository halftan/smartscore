class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :queue, :reset]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    # update_association
    respond_to do |format|
      if @task.save
        format.html { flash[:success] = I18n.t('task.create.notice.success'); redirect_to @task }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      # update_association
      if @task.update(task_params)
        format.html { flash[:success] = I18n.t('task.update.notice.success'); redirect_to @task }

        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { flash[:danger] = I18n.t('task.destroy.notice.success'); redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  # POST /tasks/1/queue
  def queue
    ret = @task.queue
    case ret.to_i
    when 0
      flash[:info] = I18n.t('task.queue.notice.success')
    else
      flash[:danger] = I18n.t('task.queue.notice.error')
    end
    respond_to do |format|
      format.html { redirect_to tasks_url }
    end
  end

  # POST /tasks/1/reset
  def reset
    @task.status = :preparing
    @task.save!
    respond_to do |format|
      format.html { flash[:info] = I18n.t('task.reset.notice.success'); redirect_to tasks_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # TODO: check task_config_id & datum_id's validity.
    def task_params
      params.require(:task).permit(:content, :task_config_id, :datum_id)
    end

    def update_association
      @task.task_config = TaskConfig.find params[:task][:task_config] unless params[:task][:task_config].nil?
      @task.datum = Datum.find params[:task][:datum] unless params[:task][:datum].nil?
    end
end
