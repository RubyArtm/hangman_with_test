# frozen_string_literal: true

# Game class implements the "Hangman" game logic.
# Manages game state, processes player moves,
# tracks correct and incorrect letters, determines win or loss.
class Game
  attr_reader :errors, :letters, :good_letters, :bad_letters, :status
  attr_accessor :version

  MAX_ERRORS = 7

  def initialize(word)
    @letters = get_letters(word)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = :in_progress
  end

  def get_letters(word)
    if word.nil? || word == ''
      abort 'The word is not given. The game is interrupted.'
    else
      word = word.encode('UTF-8')
    end

    word.upcase.split('')
  end

  def max_errors
    MAX_ERRORS
  end

  def errors_left
    MAX_ERRORS - @errors
  end

  def good?(letter)
    @letters.include?(letter)
  end

  def add_letter_to(letters, letter)
    letters << letter
  end

  def solved?
    (@letters - @good_letters).empty?
  end

  def repeated?(letter)
    @good_letters.include?(letter) || @bad_letters.include?(letter)
  end

  def lost?
    @status == :lost || @errors >= MAX_ERRORS
  end

  def in_progress?
    @status == :in_progress
  end

  def won?
    @status == :won
  end

  def next_step(letter)
    letter = letter.upcase

    return if @status == :lost || @status == :won

    return if repeated?(letter)

    if good?(letter)
      add_letter_to(@good_letters, letter)
      @status = :won if solved?
    else
      add_letter_to(@bad_letters, letter)
      @errors += 1
      @status = :lost if lost?
    end
  end

  def ask_next_letter
    puts "\nEnter the next letter (or '!' to save and exit)"
    letter = ''

    letter = $stdin.gets.encode('UTF-8').chomp while letter == ''

    return :save_and_exit if letter == '!'

    next_step(letter)
  end
end
