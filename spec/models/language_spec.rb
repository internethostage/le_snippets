require 'rails_helper'

RSpec.describe Language, type: :model do

  describe "validations" do

    it "is valid with a unique name" do
      l = build(:language)
      expect(l).to be_valid
    end

    it "is invalid without a name" do
      l = build(:language, name: nil)
      l.valid?
      expect(l.errors[:name]).to include("can't be blank")
    end

    it "is invalid with a duplicate name" do
      l = create(:language)
      l2 = build(:language, name: l.name)
      l2.valid?
      expect(l2.errors[:name]).to include("has already been taken")
    end

  end

end
