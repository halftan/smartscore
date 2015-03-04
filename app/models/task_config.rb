class TaskConfig < ActiveRecord::Base
  validates_presence_of :name

  AVAILABLE_TASK_TYPE = %i(clustering classification)
  AVAILABLE_MODEL_TYPE = {
      clustering: [ :canopy, :kmeans, :fuzzy_kmeans ],
      classification: [ :random_forest ]
  }

  after_initialize do
    param_json = read_attribute :param
    if param_json.blank?
      @param_hash = {}
    else
      @param_hash = ::JSON.parse(param_json)
    end
  end

  validate :validate_types

  before_save do
    write_attribute :param, @param_hash.as_json
  end

  def param
    @param_hash
  end

  def task_type
    @param_hash[:task_type]
  end

  def task_type= type
    if AVAILABLE_TASK_TYPE.has_key?(type.to_s.to_sym).nil?
      @param_hash[:task_type] = type
    end
  end

  def model_type
    @param_hash[:model_type]
  end

  def model_type= type
    if @param_hash[:task_type].nil? or
        AVAILABLE_MODEL_TYPE.has_key?(type.to_s.to_sym).nil?
      @param_hash[:model_type] = type
    end
  end

  private
  def validate_types
    if @param_hash[:task_type].blank? or @param_hash[:model_type].blank?
      errors.add :base, I18n.t("activerecord.errors.models.task_config.base.task_model.blank")
    elsif not model_valid?
      errors.add :base, I18n.t("activerecord.errors.models.task_config.base.task_model.incorrect")
    end
  end

  def model_valid?
    AVAILABLE_MODEL_TYPE[@param_hash[:task_type]].present? and
        AVAILABLE_MODEL_TYPE[@param_hash[:task_type]].has_key? @param_hash[:model_type]
  end

  def param=
  end

end
