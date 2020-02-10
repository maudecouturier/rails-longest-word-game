require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(9)
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    if verif_letters(@word, @letters) == false
      @result = "Sorry but #{@word} cannot be built out of #{@letters}"
    elsif verif_word_exist_api(@word) == false
      @result = "Sorry but #{@word} does not seem to be a valid English word..."
    else
      @result = "Congratulations! #{@word} is a valid English word!"
    end
  end

  private

  def verif_letters(word, letters)
    word_array = word.upcase.chars
    word_array.all? { |letter| word_array.count(letter) <= letters.count(letter) }
  end

  def verif_word_exist_api(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    result_api = JSON.parse(open(url).read)
    result_api['found']
  end
end
