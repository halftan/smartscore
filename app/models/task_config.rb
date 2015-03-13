class TaskConfig < ActiveRecord::Base
  has_many :task

  validates_presence_of :name

  AVAILABLE_TASK_TYPE = %i(clustering classification)
  AVAILABLE_MODEL_TYPE = {
      clustering: [:canopy, :kmeans, :fuzzy_kmeans],
      classification: [:random_forest]
  }

  after_initialize do
    if @param_hash.blank?
      param_json = read_attribute :param
      if param_json.blank?
        @param_hash = {}
      else
        @param_hash = ::JSON.parse(param_json).symbolize_keys
      end
    end
  end

  validate :validate_types

  before_save do
    write_attribute :param, @param_hash.to_json
  end

  def param_hash
    if @param_hash.nil?
      @param_hash = {}
    else
      @param_hash
    end
  end

  def param_hash= param
    @param_hash = param
  end

  def task_type
    # I18n.t "task_config.task_type.#{param_hash[:task_type]}"
    param_hash[:task_type]
  end

  def task_type= type
    param_hash[:task_type] = type.to_s.to_sym
  end

  def model_type
    return '' if param_hash[:model_type].nil?
    param_hash[:model_type]
  end

  def model_type= type
    param_hash[:model_type] = type.to_sym
  end

  private
  def validate_types
    if param_hash[:task_type].blank? or param_hash[:model_type].blank?
      errors.add :base, I18n.t("activerecord.errors.models.task_config.base.task_model.blank")
    elsif not model_valid?
      errors.add :base, I18n.t("activerecord.errors.models.task_config.base.task_model.incorrect")
    end
  end

  def model_valid?
    not (
      AVAILABLE_TASK_TYPE.index(param_hash[:task_type].to_sym).nil? or
      AVAILABLE_MODEL_TYPE[param_hash[:task_type].to_sym].index(
          param_hash[:model_type].to_sym
      ).nil?
    )
  end

  def param=
  end

end
