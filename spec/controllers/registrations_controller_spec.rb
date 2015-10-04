require 'rails_helper'
require 'factory_girl'
require 'ostruct'

RSpec.describe RegistrationsController do
  context 'RegistrationsController' do
    describe 'POST#create' do
      let(:eric) { FactoryGirl.attributes_for(:user) }
      let(:json) { post :create, user: eric }
      let(:result) { res = JSON.parse(json.body) }

      before :each do
        request.env["HTTP_ACCEPT"] = 'application/json'
        request.env['devise.mapping'] = Devise.mappings[:user]
      end

      it 'creates a new user' do
        expect(result['email']).to eq eric[:email]
      end

      it 'has an auth token' do
        expect(result['token']).not_to eq nil
      end

      it 'signs the user up' do
        expect(User.valid_session_token? result['token']).to eq true
      end
    end
  end
end
