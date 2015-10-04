require 'rails_helper'

RSpec.describe SessionsController do
  context 'SessionsController' do
    describe 'POST#create' do
      before do
        User.create(
          name: 'Eric Santos', email: 'test@test.com', password: 'password',
          password_confirmation: 'password', age: 22, language: 'es')
      end
      let(:eric) { FactoryGirl.attributes_for(:session_user) }
      let(:json) { post :create, user: eric }
      let(:result) { res = JSON.parse(json.body) }

      before :each do
        request.env["HTTP_ACCEPT"] = 'application/json'
        request.env['devise.mapping'] = Devise.mappings[:user]
      end

      it 'creates a session for valid user' do
        binding.pry
        expect(result['token']).not_to eq nil
      end

      it 'returns a user object' do
        # expect(result['email']).not_to eq nil
      end

      it 'returns an user object with valid token' do
        # expect(User.get_session_token(result['email'])).to eq result['token']
      end
    end
  end
end
