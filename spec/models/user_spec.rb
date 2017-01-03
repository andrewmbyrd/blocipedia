require 'rails_helper'

RSpec.describe User, type: :model do
  describe "attributes" do
    it "responds to role" do
      expect(user).to respond_to(:role)
    end
  end

  describe "roles" do
    it "is a standard role by default" do
      expect(user.role).to eq("standard")
    end
  end
end
