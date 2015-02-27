require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do
  let(:auction)   { create(:auction) }
  let(:auction_1) { create(:auction) }

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "#new" do
    it "assigns a new auction to a variable" do
      get :new
      expect(assigns(:auction)).to be_a_new Auction
    end
  end

  describe "#create" do
    context "with valid parameters" do
      def valid_request
        post :create, {auction: {
                          title: "valid auction title",
                          details: "valid details",
                          ends_on: (Time.now),
                          reserve_price: 1000
                      }}
      end

      it "saves an auction record to the db" do
        expect { valid_request }.to change{ Auction.count }.by(1)
      end

      it "redirects to the show page" do
        valid_request
        expect(response).to redirect_to(auction_path(Auction.last))
      end
    end

    context "with invalid parameters" do
      def invalid_request
        post :create, {auction: {
                          title: "valid auction title",
                          # details: "valid details",
                          # ends_on: (Time.now),
                          # reserve_price: 1000
                      }}      
      end

      it "doesn't save to the database" do
        expect { invalid_request }.not_to change {Auction.count}
      end
    end
  end

  describe "#show" do
    before {get :show, id: auction.id}
    # before {get :show, id: auction_1.id}
    it "assigns an instance variable for auction with passed id" do
      expect(assigns(:auction)).to eq(auction)
    end
  end

  describe "#edit" do
    before {get :edit, id: auction.id}
    it "assigns an instance variable with passed id" do
      expect(assigns(:auction)).to eq(auction)
    end
  end

  describe "#update" do
    context "with valid params" do
      def valid_request(params = {title: auction.title})
        patch :update, id: auction, auction: params
      end

      it "changes the details of auction if it's different" do
        valid_request({details: "MyString"})
        auction.reload
        expect(auction.title).to eq("MyString")
      end

      it "changes the reserve_price of auction if it's different" do
        valid_request({reserve_price: 4})
        auction.reload
        expect(auction.reserve_price).to eq(4)
      end

      it "changes the ends_on date of auction if it's different" do
        valid_request({ends_on: '2014-11-28 10:09:30'})
        auction.reload
        expect(auction.ends_on).to eq('2014-11-28 10:09:30')
      end
    end
    context "with invalid params" do
      def invalid_request(params = {title: ""})
        patch :update, id: auction, auction: params
      end

      it "doesnt change the record" do
        expect { invalid_request }.to_not change {auction.reload.title}
      end
    end
  end

  describe "#destroy" do
    let!(:auction) {create(:auction)}
    it "removes the auction from the database" do
      expect {delete :destroy, id: auction.id}.to change {Auction.count}.by(-1)
    end
  end

end
