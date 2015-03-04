class TaskConfigsController < ApplicationController
  before_action :set_task_config, only: [:show, :edit, :update, :destroy]

  # GET /task_configs
  # GET /task_configs.json
  def index
    @task_configs = TaskConfig.all
  end

  # GET /task_configs/1
  # GET /task_configs/1.json
  def show
  end

  # GET /task_configs/new
  def new
    @task_config = TaskConfig.new
  end

  # GET /task_configs/1/edit
  def edit
  end

  # POST /task_configs
  # POST /task_configs.json
  def create
    @task_config = TaskConfig.new(task_config_params)

    respond_to do |format|
      if @task_config.save
        format.html { flash[:success] = I18n.t('task_config.create.notice.success'); redirect_to @task_config }
        format.json { render :show, status: :created, location: @task_config }
      else
        format.html { render :new }
        format.json { render json: @task_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_configs/1
  # PATCH/PUT /task_configs/1.json
  def update
    respond_to do |format|
      if @task_config.update(task_config_params)
        format.html { flash[:success] = I18n.t('task_config.update.notice.success'); redirect_to @task_config }
        format.json { render :show, status: :ok, location: @task_config }
      else
        format.html { render :edit }
        format.json { render json: @task_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_configs/1
  # DELETE /task_configs/1.json
  def destroy
    @task_config.destroy
    respond_to do |format|
      format.html { flash[:danger] = I18n.t('task_config.destroy.notice.success'); redirect_to task_configs_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_task_config
    @task_config = TaskConfig.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_config_params
    params.require(:task_config).permit(:name)
  end
end
