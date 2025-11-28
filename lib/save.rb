# frozen_string_literal: true

require 'json'
require_relative 'game'

# The class is responsible for saving and loading the game state to/from a JSON file.
class Save
  SAVE_FILE = File.join(__dir__, '..', 'data', 'saves.json')

  def self.all
    return [] unless File.exist?(SAVE_FILE)

    JSON.parse(File.read(SAVE_FILE))
  end

  def self.save_game(game)
    saves = all
    new_id = (saves.map { |s| s['id'] }.max || 0) + 1
    saves << {
      'id' => new_id,
      'created_at' => Time.now.strftime('%T %F'),
      'game' => {
        'letters' => game.letters,
        'good_letters' => game.good_letters,
        'bad_letters' => game.bad_letters,
        'errors' => game.errors,
        'status' => game.status.to_s,
        'version' => game.version
      }
    }

    File.write(SAVE_FILE, JSON.pretty_generate(saves))
    new_id
  end

  def self.load_game(id)
    data = all.find { |s| s['id'] == id }
    return nil unless data

    g = data['game']
    letters_array = Array(g['letters'])
    return nil if letters_array.empty?

    game = Game.new(letters_array.join)

    game.instance_variable_set(:@good_letters, g['good_letters'])
    game.instance_variable_set(:@bad_letters, g['bad_letters'])
    game.instance_variable_set(:@errors, g['errors'])
    game.instance_variable_set(:@status, g['status'].to_sym)
    game.version = g['version']

    game
  end
end
