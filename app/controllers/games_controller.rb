require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @array = []
    10.times do
      range = ('A'..'Z').to_a.sample
      @array << range
    end
    @array
  end

  def parsing_api
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    parse_serialized = URI.open(url).read
    parse = JSON.parse(parse_serialized)
    parse['found']
  end

  def calcule_corresp?
    word = params[:word].split('')
    letters = @array.clone
    word.each do |letter|
      if letters.include?(letter)
        letters.delete(letter)
      else
        return false
      end
    end
    true
  end

  def score
    @array = params[:letters]
    if calcule_corresp? && parsing_api
      @answer = "Congratulations! #{params[:word]} is a valid English word!"
    elsif calcule_corresp?
      @answer = "Sorry but #{params[:word]} does not seem to be a valid English word..."
    else
      @answer = "Sorry but #{params[:word]} can't be built our of #{params[:letters]}"
    end
  end
end
