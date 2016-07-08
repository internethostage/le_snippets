require 'rails_helper'

RSpec.describe Snippet, type: :model do

  describe "validations" do

    it 'is valid with a name, body, user_id and language_id' do
      s = build(:snippet)
      expect(s).to be_valid
    end

    it 'is invalid without a name' do
      s = build(:snippet, name: nil)
      s.valid?
      expect(s.errors[:name]).to include("can't be blank")
    end

    it 'is invalid with a duplicate name within the same language' do
      l = create(:language)
      s = create(:snippet, language: l)
      s2 = build(:snippet, name: s.name, language: l)
      s2.valid?
      expect(s2.errors[:name]).to include("has already been taken")
    end

    it 'is valid with a duplicate name within a different language' do
      l = create(:language)
      l2 = create(:language)
      s = create(:snippet, language: l)
      s2 = build(:snippet, name: s.name, language: l2)
      s2.valid?
      expect(s2).to be_valid
    end

    it 'is invalid without a body' do
      s = build(:snippet, body: nil)
      s.valid?
      expect(s.errors[:body]).to include("can't be blank")
    end

    it 'is invalid if body is less than 10 characters long' do
      s = build(:snippet, body: "123456789")
      s.valid?
      expect(s.errors[:body]).to include("is too short (minimum is 10 characters)")
    end

    it 'is invalid without a user id' do
      s = build(:snippet, user: nil)
      s.valid?
      expect(s.errors[:user]).to include("can't be blank")
    end

    it 'is invalid without a language id' do
      s = build(:snippet, language: nil)
      s.valid?
      expect(s.errors[:language]).to include("can't be blank")
    end

  end

end
