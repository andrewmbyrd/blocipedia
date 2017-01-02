require 'rails_helper'

RSpec.describe Wiki, type: :model do

  let(:title) {RandomData.random_sentence}
  let(:body) {RandomData.random_paragraph}
  let(:user) {User.create!(email: 'jalkdj@hhh.com', password: 'password')}

  it { is_expected.to belong_to(:user) }

  let(:wiki) {user.wikis.create!(title: title, body: body, private: false)}

  describe "attributes" do
    it "has a title and body and private attribute" do
      expect(wiki).to have_attributes(title: title, body: body, private: false)
    end
  end

end
