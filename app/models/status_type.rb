class StatusType < ActiveRecord::Base
  has_many :status_codes
  STATUSES = self.all
end