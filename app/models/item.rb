class Item < ApplicationRecord
  belongs_to :place
  # after_update_commit do
  #   ItemUpdateEventBroadcastJobJob.perform_later(self)
  # end
end
