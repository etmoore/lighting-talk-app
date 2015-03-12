class TalkIdea < ActiveRecord::Base
  validates :name, presence: true
end
