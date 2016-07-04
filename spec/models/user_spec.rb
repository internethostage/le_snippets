require 'rails_helper'

RSpec.describe User, type: :model do

  context "validations" do

    it "is valid with a firstname, lastname, email and password" do
      u = User.new FactoryGirl.attributes_for(:user)
      expect(u).to be_valid
    end

    it "is invalid without a first name" do
      u = User.new FactoryGirl.attributes_for(:user).merge({first_name: nil})
      expect(u).to be_invalid
    end

    it "is invalid without a last name" do
      u = User.new FactoryGirl.attributes_for(:user).merge({last_name: nil})
      expect(u).to be_invalid
    end

    it "is invalid without an email address" do
      u = User.new FactoryGirl.attributes_for(:user).merge({email: nil})
      expect(u).to be_invalid
    end

    it "is an invalid email if it doesn't have a (dot) domain" do
      u = User.new FactoryGirl.attributes_for(:user).merge({email: "test@test"})
      expect(u).to be_invalid
    end

    it "is an invalid email if it doesn't have an @" do
      u = User.new FactoryGirl.attributes_for(:user).merge({email: "test.com"})
      expect(u).to be_invalid
    end

    it "is invalid with a duplicate email address" do
      u = FactoryGirl.create(:user)
      u2 = User.new FactoryGirl.attributes_for(:user).merge({email: u.email})
      expect(u2).to be_invalid
    end

    it "is invalid without a password" do
      u = User.new FactoryGirl.attributes_for(:user).merge({password: nil, password_confirmation: nil})
      expect(u).to be_invalid
    end

    it "is invalid with a short password" do
      u = User.new FactoryGirl.attributes_for(:user).merge({password: 'short', password_confirmation: 'short'})
      expect(u).to be_invalid
    end

    it "is invalid with a password confirmation mismatch" do
      u = User.new FactoryGirl.attributes_for(:user).merge({password: 'P4SSw0rd', password_confirmation: 'dr0wSS4P'})
      expect(u).to be_invalid
    end

  end

  context "full_name method" do
    it "returns a concatenated first and last name" do
      u = User.new FactoryGirl.attributes_for(:user).merge({first_name: "John", last_name: "Doe"})
      expect(u.full_name).to eq("John Doe")
    end
  end

  context "hashing the password method" do
    it "generates a password digest" do
      u = User.new FactoryGirl.attributes_for(:user)
      u.save
      expect(u.password_digest).to be
    end
  end

end
