require "rails_helper"

describe TalkIdea do
  describe "validations" do
    let(:valid_attributes) {
      {
        name: "How to build a cabin by the sea"
      }
    }

    it "is valid" do
      talk_idea = TalkIdea.new(valid_attributes)

      expect(talk_idea.valid?).to eq true
    end

    it "is invalid without a name" do
      valid_attributes.delete(:name)
      talk_idea = TalkIdea.new(valid_attributes)

      expect(talk_idea.valid?).to eq false
      expect(talk_idea.errors[:name]).to eq ["can't be blank"]
    end
  end
end
