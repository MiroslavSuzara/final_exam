require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "#new" do
    it "renders a new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

end
