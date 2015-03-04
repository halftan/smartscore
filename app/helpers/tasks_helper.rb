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
end
