class Datum < ActiveRecord::Base
  has_many :task

  def display_name
    label || path
  end
end
