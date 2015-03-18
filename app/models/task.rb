class Task < ActiveRecord::Base
  belongs_to :task_config
  belongs_to :datum

  validates_presence_of :status, :content, :task_config

  def queue
    data = {
      taskType:   task_config.param_hash[:task_type],
      modelType:  task_config.param_hash[:model_type],
      input:      datum.path,
      return_key: "#{Time.now.to_i}-#{SecureRandom.uuid}",
    }
    redis.publish(Rails.configuration.x.redis_key_smartscore_rpc, data.to_json)
    Kernel.sleep(2)
    # TODO: implement return_key at java side.
    redis.get(data[:return_key])
  end

  def status
    if valid_status?
      status = read_attribute :status
    else
      status = -1
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
    status.present? and [-1, 0, 1, 2, 3].find_index(status).present?
  end

  def fetch_status_code status
    case status
      when :preparing
        0
      when :queueing
        1
      when :ongoing
        2
      when :finished
        3
      when :error
        -1
      else
        -1
    end
  end

  def fetch_status_sym status
    case status
      when 0
        :preparing
      when 1
        :queueing
      when 2
        :ongoing
      when 3
        :finished
      when -1
        :error
      else
        :error
    end
  end

end
