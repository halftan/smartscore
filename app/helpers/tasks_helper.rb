module TasksHelper

  # @param task Task
  def status_label task
    case task.get_status
      when :preparing
        'label-default'
      when :ongoing
        'label-info'
      when :finished
        'label-success'
      when :error
        'label-danger'
    end
  end
end
