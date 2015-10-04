require 'rails_helper'

RSpec.describe CoachController do
  context 'CoachController' do
    describe 'GET#training_session' do
      before :each do
        request.env["HTTP_ACCEPT"] = 'application/json'
      end

      context 'user is signed_in' do
        it 'retrurns a list of words with images' do
          @user = User.create(
            name: 'Eric Santos', email: 'test@test.com', password: 'password',
            password_confirmation: 'password', age: 22, language: 'es',
            token: Devise.friendly_token[0,20])
          get :training_session, { email: @user.email, token: @user.token }
          res = JSON.parse(response.body)
          expect(res['training'].empty?).to eq false
          expect(res['training'].first.keys.count).to eq 2
        end
      end

      context 'user is not signed in' do
        it 'returns an unauthorized error' do
          get :training_session
          res = JSON.parse(response.body)
          expect(res['error']).to eq "Unauthorized"
          expect(response.status).to eq 401
        end
      end
    end

    describe 'GET#test_session' do
      before :each do
        request.env["HTTP_ACCEPT"] = 'application/json'
      end

      context 'user is signed_in' do
        it 'retrurns a list of words with images' do
          @user = User.create(
            name: 'Eric Santos', email: 'test@test.com', password: 'password',
            password_confirmation: 'password', age: 22, language: 'es',
            token: Devise.friendly_token[0,20])
          get :test_session, { email: @user.email, token: @user.token }
          res = JSON.parse(response.body)
          expect(res['test'].empty?).to eq false
        end
      end

      context 'user is not signed in' do
        it 'returns an unauthorized error' do
          get :test_session
          res = JSON.parse(response.body)
          expect(res['error']).to eq "Unauthorized"
          expect(response.status).to eq 401
        end
      end
    end

    describe 'POST#test_results' do
      context 'user is signed_in' do
        it 'returns the test evaluation and updates user profile' do
          @user = User.create(
            name: 'Eric Santos', email: 'test@test.com', password: 'password',
            password_confirmation: 'password', age: 22, language: 'es',
            token: Devise.friendly_token[0,20])
          post :test_results, { email: @user.email, token: @user.token, words_read: 3 }
          res = JSON.parse(response.body)
          expect(res['evaluations'].first['words_read']).to eq 3
          expect(res['evaluations'].empty?).to eq false
        end
      end

      context 'user is not signed in' do
        it 'returns an unauthorized error' do
          get :test_results
          res = JSON.parse(response.body)
          expect(res['error']).to eq "Unauthorized"
          expect(response.status).to eq 401
        end
      end

      context 'when results are not valid' do
        it 'returns an unauthorized error' do
          @user = User.create(
            name: 'Eric Santos', email: 'test@test.com', password: 'password',
            password_confirmation: 'password', age: 22, language: 'es',
            token: Devise.friendly_token[0,20])
          post :test_results, { email: @user.email, token: @user.token }
          res = JSON.parse(response.body)
          expect(res['error']).to eq 'Unable to save evaluation'
        end
      end
    end
  end
end
