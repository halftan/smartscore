class Task < ActiveRecord::Base

  def  status
    status = read_attribute :status
    I18n.t "tasks.status.#{status}"
  end

  def status= status
    write_attribute :status, fetch_status_code(status)
  end

  private

  def fetch_status_code status
    case status
      when :preparing
        0
      when :ongoing
        1
      when :finished
        2
      when :error
        3
      else
        3
    end
  end

end
