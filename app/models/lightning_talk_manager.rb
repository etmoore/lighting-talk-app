class LightningTalkManager
  def self.build(lightning_talk)
    if lightning_talk.save
      day = lightning_talk.day
      day.update_attributes(number_of_slots: (day.number_of_slots - 1))
      [lightning_talk, true]
    else
      [lightning_talk, false]
    end
  end
end
