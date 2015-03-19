class Task < ActiveRecord::Base
  belongs_to :task_config
  belongs_to :datum

  validates_presence_of :status, :content, :task_config

  def queue
    if datum.nil? or datum.path.nil?
      return 1
    elsif not self.status? :preparing
      return 2
    end
    data = {
      taskType:  task_config.param_hash[:task_type],
      modelType: task_config.param_hash[:model_type],
      input:     datum.path,
      output:    Rails.configuration.x.default_output_path,
      taskId:    id,
    }
    redis.publish(Rails.configuration.x.redis_key_smartscore_rpc, data.to_json)
    self.status = :queueing
    0
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
    if status.is_a? Symbol
      write_attribute :status, fetch_status_code(status)
    else
      write_attribute :status, status
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
