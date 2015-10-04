require 'rest-client'

class CoachController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :test_results

  def training_session
    token = User.get_session_token(coach[:email])
    if token && token == coach[:token]
      render json: { training: training_words(10) }, status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def advanced_training_session
    token = User.get_session_token(coach[:email])
    if token && token == coach[:token]
      render json: { training: phrases(30) }, status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def test_session
    token = User.get_session_token(coach[:email])
    if token && token == coach[:token]
      render json: { test: test_words(30) }, status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def advanced_test_session
    token = User.get_session_token(coach[:email])
    if token && token == coach[:token]
      render json: { test: phrases(30) }, status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def test_results
    token = User.get_session_token(results[:email])
    if token && token == results[:token]
      user = User.find_by(email: results[:email])
      evaluation = user.evaluations.new(words_read: results[:words_read], phrase_read: results[:phrase_read])
      if evaluation.valid?
        evaluation.save
        render json: user.to_json(include: :evaluations), status: :ok
      else
        render json: { error: 'Unable to save evaluation' }
      end
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def profile
    token = User.get_session_token(coach[:email])
    if token && token == coach[:token]
      user = User.find_by(email: coach[:email])
      render json: user.to_json(include: :evaluations), status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private
  def coach
    params.permit(:email, :token)
  end

  def results
    params.permit(:email, :token, :words_read, :phrase_read)
  end

  def user
    params.permit(:email, :token)
  end

  def training_words count
    words = File.read(File.join(Rails.root, 'app', 'assets', 'dictionaries', 'dictionary1'))
    .split("\n").shuffle[0...count]
    words.map { |word| { word: word, image: get_image(word) } }
  end

  def test_words count
    File.read(File.join(Rails.root, 'app', 'assets', 'dictionaries', 'dictionary1'))
    .split("\n").shuffle[0...count]
  end

  def get_image word
    url = 'https://api.gettyimages.com/v3/search/images?fields=id,title,thumb,referral_destinations&sort_order=best&phrase=[key]&exclude_nudity=true&compositions[]=close_up'.gsub('[key]', word)
    result = RestClient.get(url, { 'Api-Key' => 'tqhc6x75bcjc74yxgqv2kw7b' })
    res = JSON.parse(result)
    res['images'].map { |image| image['display_sizes'].first['uri'] }.sample
  end

  def phrases count
    File.read(File.join(Rails.root, 'app', 'assets', 'dictionaries', 'dictionary2'))
    .split("\n").shuffle[0...count]
  end
end
