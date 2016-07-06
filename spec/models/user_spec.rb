require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do

    it "is valid with a firstname, lastname, email and password" do
      u = build(:user)
      expect(u).to be_valid
    end

    it "is invalid without a first name" do
      u = build(:user, first_name: nil)
      u.valid?
      expect(u.errors[:first_name]).to include("can't be blank")
    end

    it "is invalid without a last name" do
      u = build(:user, last_name: nil)
      u.valid?
      expect(u.errors[:last_name]).to include("can't be blank")
    end

    it "is invalid without an email address" do
      u = build(:user, email: nil)
      u.valid?
      expect(u.errors[:email]).to include("can't be blank")
    end

    it "is an invalid email if it doesn't have a (dot) domain" do
      u = build(:user, email: "test@test")
      u.valid?
      expect(u.errors[:email]).to include("is invalid")
    end

    it "is an invalid email if it doesn't have an @" do
      u = build(:user, email: "test.com")
      u.valid?
      expect(u.errors[:email]).to include("is invalid")
    end

    it "is invalid with a duplicate email address" do
      u = create(:user)
      u2 = build(:user, email: u.email)
      u2.valid?
      expect(u2.errors[:email]).to include("has already been taken")
    end

    it "is invalid without a password" do
      u = build(:user, password: nil, password_confirmation: nil)
      u.valid?
      expect(u.errors[:password]).to include("can't be blank", "is too short (minimum is 8 characters)")
    end

    it "is invalid with a short password" do
      u = build(:user, password: 'short', password_confirmation: 'short')
      u.valid?
      expect(u.errors[:password]).to include("is too short (minimum is 8 characters)")
    end

    it "is invalid with a password confirmation mismatch" do
      u = build(:user, password: 'P4SSw0rd', password_confirmation: 'dr0wSS4P')
      expect(u).to be_invalid
    end

  end

  describe "full_name method" do
    it "returns a concatenated first and last name" do
      u = User.new attributes_for(:user).merge({first_name: "John", last_name: "Doe"})
      expect(u.full_name).to eq("John Doe")
    end
  end

  describe "hashing the password method" do
    it "generates a password digest" do
      u = User.new attributes_for(:user)
      u.save
      expect(u.password_digest).to be
    end
  end

end
