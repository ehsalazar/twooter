require 'spec_helper'


describe TwootsController do
  describe '#recent' do
    it "returns 50 twoots" do
      50.times do
        Twoot.create(content: 'some content')
      end
      get :recent

      expect(JSON.parse(response.body).length).to eq(50)
    end

    it "does not return older twoots" do
      Twoot.create(content: 'some other content')
      50.times do
        Twoot.create(content: 'some content')
      end
      get :recent

      expect(JSON.parse(response.body).length).to eq(50)
    end
  end

  describe '#search' do
    it "returns twoots associated with the given hashtag" do
      fake_hashtag = Hashtag.create(name: 'some name')
      unmatched_hashtag = Twoot.create
      5.times do
        fake_hashtag.twoots.create
      end
      get :search, keyword: fake_hashtag.name
      expect(JSON.parse(response.body).length).to eq(5)
    end
    it "returns a maximum of 50 twoots" do
      fake_hashtag = Hashtag.create(name: 'some name')
      51.times do
        fake_hashtag.twoots.create
      end
      get :search, keyword: fake_hashtag.name
      expect(JSON.parse(response.body).length).to eq(50)
    end

    it "returns status code 404 if the hashtag doesn't exist" do
      get :search, keyword: 'unlisted keyword'
      expect(response.status).to eq(404)
    end
  end

  describe '#create' do
    it "creates a new twoot" do
      expect{
        post :create, { twoot: { content: 'some content' } }
      }.to change{Twoot.count}.by(1)
    end

    it "associates the twoot with the given hashtags" do
      hashtag = Hashtag.create(name: 'some name')
      attributes = { twoot: { content: 'some content' },
                     hashtags: [hashtag.name] }
      post :create, attributes
      hashtag.reload
      expect(hashtag.twoots.count).to eq(1)
    end

    it "creates the associated hashtags if they don't already exist" do
      expect{
        attributes = { twoot: { content: 'some content' },
                     hashtags: ['some name'] }
        post :create, attributes
      }.to change{Hashtag.count}.by(1)
    end

    it "returns the associated twoot as JSON with hashtags" do
      hashtag = Hashtag.create(name: 'some name')
      attributes = { twoot: { content: 'some content' },
                     hashtags: [hashtag.name] }
      post :create, attributes
      expect(response.body).to eq(Twoot.last.to_json(methods: :hashtag_names))
    end

    it "should provide fake attributes if none are given" do
      post :create, { twoot: { } }
      expect(Twoot.last.content).to_not be_nil
      expect(Twoot.last.avatar_url).to_not be_nil
      expect(Twoot.last.handle).to_not be_nil
      expect(Twoot.last.username).to_not be_nil

    end
  end

end