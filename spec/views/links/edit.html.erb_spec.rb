require 'rails_helper'

RSpec.describe "links/edit", type: :view do
  let(:link) {FactoryBot.create(:link)}

  before(:each) do
    @link = assign(:link, link)
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end

  it "renders the expire link form" do
    render

    assert_select "form[action=?][method=?]", link_path(@link), "post"
  end
end
