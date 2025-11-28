# frozen_string_literal: true

# WordReader class handles reading words for the game.
# Provides methods to read words from command-line arguments or from a file.
class WordReader
  def read_from_args
    ARGV[0]
  end

  def read_from_file(file_name)
    return nil unless File.exist?(file_name)

    f = File.new(file_name, 'r:UTF-8')
    lines = f.readlines
    f.close
    lines.sample&.chomp
  end
end
