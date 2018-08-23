require 'rails_helper'

RSpec.describe User, type: :model do
  context "validation test" do
    it "pass validation" do
      user = User.new name: "a", email: "a@g.c", password: "12345678"
      expect(user.valid?).to eq(true)
    end

    it "ensures name presence" do
      user = User.new email: "a@g.c", password: "12345678"
      expect(user.valid?).to eq(false)
    end

    it "ensures email presence" do
      user = User.new name: "a", password: "12345678"
      expect(user.valid?).to eq(false)
    end

    it "ensures email in true format" do
      user1 = User.new name: "a", email: "a@g", password: "12345678"
      user2 = User.new name: "a", email: "a.c", password: "12345678"
      expect(user1.valid? || user2.valid?).to eq(false)
    end

    it "ensures name 's length is valid" do
      user = User.new name: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        email: "a@g.c", password: "12345678"
      expect(user.valid?).to eq(false)
    end

    it "ensures password presence" do
      user = User.new name: "a", email: "a@g.c"
      expect(user.valid?).to eq(false)
    end

    it "should have many subtasks" do
      association = User.reflect_on_association(:subtasks)
      expect(association.macro).to eq(:has_many)
    end

    it "should lead many groups if it is a leader" do
      association = User.reflect_on_association(:lead_groups)
      expect(association.macro).to eq(:has_many)
    end

    it "should have many groups if it is a member" do
      association = User.reflect_on_association(:groups)
      expect(association.macro).to eq(:has_many)
    end

    it "should have many reports" do
      association = User.reflect_on_association(:reports)
      expect(association.macro).to eq(:has_many)
    end

    it "should have many following" do
      association = User.reflect_on_association(:following)
      expect(association.macro).to eq(:has_many)
    end

    it "should have many followers" do
      association = User.reflect_on_association(:followers)
      expect(association.macro).to eq(:has_many)
    end
  end
end
