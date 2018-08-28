require 'rails_helper'
RSpec.describe LinksController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Link. As you add validations to Link, be sure to
  # adjust the attributes here as well.

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LinksController. Be sure to keep this updated too.

  let(:link) {FactoryBot.create(:link)}
  let(:valid_attributes) {{url: 'https://roosterteeth.com'}}
  let(:invalid_attributes) {{url: 'not a real url'}}



  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end

  describe "GET #link_through" do
    it "routes you through to the shortened link's url" do
      get :link_through, params: {slug: link.to_param}
      expect(response).to redirect_to('https://roosterteeth.com')
    end

    it "returns 404 for expired links" do
      expired_link = FactoryBot.create(:link, expired: true)
      expect { 
        get :link_through, params: {slug: expired_link.to_param}
        }.to raise_error(ActionController::RoutingError)
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: {slug: link.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Link" do
        expect {
          post :create, params: {link: valid_attributes}
        }.to change(Link, :count).by(1)
      end

      it "redirects to the created link" do
        post :create, params: {link: valid_attributes}
        expect(response).to redirect_to(edit_link_url(Link.last))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {link: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #expire" do
    it "redirects to the root page" do
      link_to_delete = FactoryBot.create(:link)
      delete :expire, params: {slug: link_to_delete.to_param}
      expect(response).to redirect_to(root_url)
    end

  end

end
