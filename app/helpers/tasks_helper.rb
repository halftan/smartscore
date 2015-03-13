module TasksHelper

  # @param task Task
  def status_label task
    case task.get_status
      when :preparing
        label_type = 'label-default'
      when :ongoing
        label_type = 'label-info'
      when :finished
        label_type = 'label-success'
      when :error
        label_type = 'label-danger'
    end
    "<span class=\"label #{label_type}\">#{task.status}</span>".html_safe
  end

  def get_related_task_configs
    TaskConfig.all.collect do |tc|
      [tc.name, tc.id]
    end
  end

  def link_to_task_config task
    if task.task_config.nil?
      t 'None'
    else
      link_to task.task_config.name, task_config_path(task.task_config)
    end
  end
end
