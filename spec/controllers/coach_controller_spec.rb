require 'rails_helper'

RSpec.describe CoachController do
  context 'CoachController' do
    describe 'GET#training_session' do
      before :each do
        request.env["HTTP_ACCEPT"] = 'application/json'
      end

      context 'user is signed_in' do
        it 'retrurns a list of words with images' do
          @user = User.create(FactoryGirl.attributes_for(:user).merge(token: Devise.friendly_token[0,20]))
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

    describe 'GET#advanced_training_session' do
      before :each do
        request.env["HTTP_ACCEPT"] = 'application/json'
      end

      context 'user is signed_in' do
        it 'retrurns a list of words with images' do
          @user = User.create(FactoryGirl.attributes_for(:user).merge(token: Devise.friendly_token[0,20]))
          get :advanced_training_session, { email: @user.email, token: @user.token }
          res = JSON.parse(response.body)
          expect(res['training'].empty?).to eq false
        end
      end

      context 'user is not signed in' do
        it 'returns an unauthorized error' do
          get :advanced_training_session
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
        it 'retrurns a list of words' do
          @user = User.create(FactoryGirl.attributes_for(:user).merge(token: Devise.friendly_token[0,20]))
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

    describe 'GET#advanced_test_session' do
      before :each do
        request.env["HTTP_ACCEPT"] = 'application/json'
      end

      context 'user is signed_in' do
        it 'retrurns a list of words' do
          @user = User.create(FactoryGirl.attributes_for(:user).merge(token: Devise.friendly_token[0,20]))
          get :advanced_test_session, { email: @user.email, token: @user.token }
          res = JSON.parse(response.body)
          expect(res['test'].empty?).to eq false
        end
      end

      context 'user is not signed in' do
        it 'returns an unauthorized error' do
          get :advanced_test_session
          res = JSON.parse(response.body)
          expect(res['error']).to eq "Unauthorized"
          expect(response.status).to eq 401
        end
      end
    end

    describe 'POST#test_results' do
      context 'user is signed_in' do
        describe 'normal' do
          it 'returns the test evaluation and updates user profile' do
            @user = User.create(FactoryGirl.attributes_for(:user).merge(token: Devise.friendly_token[0,20]))
            post :test_results, { email: @user.email, token: @user.token, words_read: 3 }
            res = JSON.parse(response.body)
            expect(res['evaluations'].first['words_read']).to eq 3
            expect(res['evaluations'].empty?).to eq false
          end
        end

        describe 'advanced' do
          it 'returns the test evaluation and updates user profile' do
            @user = User.create(FactoryGirl.attributes_for(:user).merge(token: Devise.friendly_token[0,20]))
            post :test_results, { email: @user.email, token: @user.token, phrase_read: 3 }
            res = JSON.parse(response.body)
            expect(res['evaluations'].first['phrase_read']).to eq 3
            expect(res['evaluations'].empty?).to eq false
          end
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
    end

    describe 'GET#show' do
      context 'when user is signed' do
        it 'returns a user object with evaluations and responds with 200' do
          @user = User.create(FactoryGirl.attributes_for(:user).merge(token: Devise.friendly_token[0,20]))
          get :profile, { email: @user.email, token: @user.token }
          res = JSON.parse(response.body)
          expect(res['id']).not_to eq nil
          expect(response.status).to eq 200
        end
      end
      context 'when user is not signed' do
        it 'returns an error with status of 401' do
          get :profile
          res = JSON.parse(response.body)
          expect(res['error']).to eq 'Unauthorized'
          expect(response.status).to eq 401
        end
      end
    end
  end
end
