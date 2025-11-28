# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/result_printer'
require_relative 'lib/word_reader'
require_relative 'lib/save'

VERSION = 'Hangman game (tests available).'

begin
  word_reader = WordReader.new

  game = nil

  saves = Save.all
  unless saves.empty?
    puts 'Saved games:'
    saves.each do |s|
      g = s['game']
      puts "  ID: #{s['id']} | created_at: #{s['created_at']} | status: #{g['status']} | errors: #{g['errors']}"
    end
    puts
  end

  puts 'Enter the ID of a saved game (or blank for a new one):'
  input = STDIN.gets&.chomp

  if input && !input.empty?
    loaded_game = Save.load_game(input.to_i)

    if loaded_game
      game = loaded_game
      puts "Loaded game №#{input}"
    else
      warn "Save with ID=#{input} not found. A new game will start."
    end
  end

  if game.nil?
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
  end
  printer = ResultPrinter.new(game)

  begin
    while game.in_progress?
      printer.print_status(game)
      action = game.ask_next_letter

      if action == :save_and_exit
        id = Save.save_game(game)
        puts "The game is saved under number #{id}."
        exit 0
      end
    end

    printer.print_status(game)
  rescue Interrupt
    warn "\nThe game was interrupted by the user."

    if game.in_progress?
      print 'Save current game? (y/n):'
      answer = STDIN.gets&.chomp&.downcase

      if answer == 'y'
        id = Save.save_game(game)
        puts "The game is saved under number #{id}."
      end
    end

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
