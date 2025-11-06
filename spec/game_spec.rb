# frozen_string_literal: true

require 'rspec'
require_relative '../lib/game'

RSpec.describe 'Game' do
  before do
    @game = Game.new('play')
    expect(@game.status).to eq :in_progress
  end

  after do
    # Do nothing
  end
  # Checking the state and behavior of the game when winning
  it 'win' do
    @game.next_step('p')
    @game.next_step('l')
    @game.next_step('a')
    @game.next_step('y')
    expect(@game.errors).to eq 0
    expect(@game.status).to eq :won
  end
  # Checking the game state and behavior when losing
  it 'lose' do
    @game.next_step('p')
    @game.next_step('s')
    @game.next_step('d')
    @game.next_step('f')
    @game.next_step('g')
    @game.next_step('h')
    @game.next_step('j')
    @game.next_step('k')
    expect(@game.errors).to eq 7
    expect(@game.status).to eq :lost
  end
end
