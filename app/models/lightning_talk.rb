class LightningTalk < ActiveRecord::Base
  validate :number_of_slots

  belongs_to :user
  belongs_to :day

  private

  def number_of_slots
    unless self.day.lightning_talks.count < self.day.number_of_slots
      self.errors[:base] << "Lightning talks for #{self.day.talk_date.readable_inspect} at max capacity"
    end
  end
end
