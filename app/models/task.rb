class Task < ActiveRecord::Base
  belongs_to :task_config
  belongs_to :data

  validates_presence_of :status, :content, :task_config

  def status
    if valid_status?
      status = read_attribute :status
    else
      status = 3
    end
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
    fetch_status_sym read_attribute :status
  end

  # Check if the task is at status [ preparing, ongoing, finished, error]
  def status? status
    read_attribute(:status) == fetch_status_code(status)
  end

  private

  def valid_status?
    status = read_attribute :status
    status.present? and [0, 1, 2, 3].find_index(status).present?
  end

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

  def fetch_status_sym status
    case status
      when 0
        :preparing
      when 1
        :ongoing
      when 2
        :finished
      when 3
        :error
      else
        :error
    end
  end

end
