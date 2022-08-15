require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def score
    @word = params[:word]
    @grid = params[:grid]
    if good_letters == false
      @response = "Sorry, but #{@word} can't be built out of #{@grid}"
    elsif !english_word?(@word)
      @response = "Sorry, but #{@word} is not valid!"
    else
      @response = 'Well done!'
    end
  end

  private

  def good_letters
    @word.upcase.chars.all? { |letter| @grid.include?(letter) }
  end
end
