# spec/requests/blogs_spec.rb
require 'rails_helper'

RSpec.describe "BlogsController", type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  context "with valid parameters" do
    it "creates a new blog and redirects to the blog show page" do
      blog_params = {
        blog: {
          title: "New Blog Title",
          body: "This is the content of the blog",
          user_id: user.id
        }
      }
      post blogs_path, params: blog_params
      expect(response).to redirect_to(blog_path(Blog.last))
      follow_redirect!
      expect(response.body).to include("New Blog Title")
    end
  end
end
