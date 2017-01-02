require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:title) {RandomData.random_sentence}
  let(:body) {RandomData.random_paragraph}
  let(:user) {User.create!(email: 'jalkdj@hhh.com', password: 'password')}

  let(:my_wiki) {user.wikis.create!(title: title, body: body, private: false)}

  describe "GET #show" do
    it "returns http success" do
      get :show, id: my_wiki.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http status success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "increases number of posts by 1" do
      expect{post :create, user: user, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph, private: false}}.to change(Wiki,:count).by(1)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, id: my_wiki.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT #update" do

    it "updates post with expected attributes" do
       new_title = RandomData.random_sentence
       new_body = RandomData.random_paragraph

       put :update,  id: my_wiki.id, wiki: {title: new_title, body: new_body, private: false}


       updated_wiki = assigns(:wiki)
       expect(updated_wiki.id).to eq my_wiki.id
       expect(updated_wiki.title).to eq new_title
       expect(updated_wiki.body).to eq new_body
     end

  end

  describe "DELETE #destroy" do
    it "deletes the post" do
       delete :destroy,  id: my_wiki.id

       count = Wiki.where({id: my_wiki.id}).size
       expect(count).to eq 0
     end
  end


end
