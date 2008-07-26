class StatusCode < ActiveRecord::Base
  belongs_to :status_type
  
  def code_description
    "#{code} #{description}"
  end
end