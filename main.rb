# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/result_printer'
require_relative 'lib/word_reader'

VERSION = 'Hangman game (tests available).'

begin
  word_reader = WordReader.new

  word =
    if ARGV[0].nil?
      words_file_name = File.join(__dir__, 'data', 'words.txt')
      word_reader.read_from_file(words_file_name)
    else
      word_reader.read_from_args
    end

  if word.nil? || (word.respond_to?(:empty?) && word.empty?)
    warn 'Unable to retrieve word for game. Please check your data source.'
    exit 2
  end

  game = Game.new(word)
  game.version = VERSION

  printer = ResultPrinter.new(game)

  begin
    while game.in_progress?
      printer.print_status(game)
      game.ask_next_letter
    end

    printer.print_status(game)
  rescue Interrupt
    warn "\nThe game was interrupted by the user."
    exit 130
  end
rescue ArgumentError, RuntimeError => e
  warn "Error: #{e.message}"
  exit 1
rescue StandardError => e
  warn "Unexpected error: #{e.message}"
  warn e.backtrace.join("\n") if ENV['DEBUG'] == '1'
  exit 1
end
