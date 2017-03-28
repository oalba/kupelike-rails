class Item < ApplicationRecord
  belongs_to :place
  has_many :votes, dependent: :destroy
  # after_update_commit do
  #   ItemUpdateEventBroadcastJobJob.perform_later(self)
  # end
end
