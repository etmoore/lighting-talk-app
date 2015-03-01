class LightningTalk < ActiveRecord::Base
  validate :number_of_slots
  validates :name, :user_id, :day_id, presence: true

  belongs_to :user
  belongs_to :day

  private

  def number_of_slots
    unless self.day.lightning_talks.count < self.day.number_of_slots
      self.errors[:base] << "Lightning talks for #{self.day.talk_date.readable_inspect} at max capacity"
    end
  end
end
