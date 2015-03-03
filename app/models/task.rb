class Task < ActiveRecord::Base
  validates_presence_of :status, :content

  def status
    status = read_attribute :status
    I18n.t "task.status.#{status}"
  end

  def status= status
    if not status.is_a? Symbol
      write_attribute :status, status
    else
      write_attribute :status, fetch_status_code(status)
    end
  end

  def get_status
    fetch_status_code read_attribute :status
  end

  # Check if the task is at status [ preparing, ongoing, finished, error]
  def status? status
    read_attribute(:status) == fetch_status_code(status)
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
