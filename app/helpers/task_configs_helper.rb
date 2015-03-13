module TaskConfigsHelper

  def task_type_data task_config=nil
    TaskConfig::AVAILABLE_TASK_TYPE.map do |val|
      [t("task_config.task_type.#{val.to_s}"), val.to_s]
    end
  end

  def model_type_data task_config=nil
    if task_config.nil? or
        TaskConfig::AVAILABLE_MODEL_TYPE[@task_config.task_type.try :to_sym].nil?
      _, model = TaskConfig::AVAILABLE_MODEL_TYPE.first
    else
      model = TaskConfig::AVAILABLE_MODEL_TYPE[@task_config.task_type.to_sym]
    end
    model.map do |val|
      [t("task_config.model_type.#{val}"), val.to_s]
    end
  end

  def get_task_model_map
    ret = {}
    TaskConfig::AVAILABLE_MODEL_TYPE.each_pair  do |k, v|
      ret[k] = v.collect do |val|
        {text: t('task_config.model_type.' + val.to_s), value: val.to_s}
      end
    end
    ret
  end

end
