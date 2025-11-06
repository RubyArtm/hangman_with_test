## 🎮 Hangman Game
Console Hangman game in Ruby with test coverage
## 📝 Description
A classic Hangman game implemented in Ruby. The player guesses a word letter by letter, with a limited number of attempts (7 errors). Words are loaded from a text file or passed via command-line arguments.
## 🚀 Getting Started
```bash
# Run with a random word from file
ruby main.rb

# Run with a specific word
ruby main.rb word
```
## 🎯 Game Rules
- Player must guess the hidden word by suggesting letters
- Maximum allowed errors: **7**
- Correct letter reveals its position(s) in the word
- Incorrect letter increases the error counter
- Victory: all letters are guessed
- Defeat: error limit is reached

## 🏗️ Project Structure
```
hangman_with_test/
├── main.rb               # Application entry point
├── lib/                  # Game modules
│   ├── game.rb           # Game logic
│   ├── result_printer.rb # Results output
│   └── word_reader.rb    # Word reading
├── spec/                 # RSpec tests
│   └── game_spec.rb      # Game logic tests
├── data/                 # Data files
│   └── words.txt         # Word list
└── image/                # Visual assets (ASCII art)
```
## 🛠️ Technologies & Skills
### Programming Language
- **Ruby 3.4.5**

### Architectural Patterns
- **OOP (Object-Oriented Programming)**
    - Separation of concerns between classes
    - Game logic encapsulation
    - Proper use of attributes and accessor methods

### Design Principles
- **Modular architecture** - separation into independent components
- **Single Responsibility Principle** - each class has one responsibility
- **Separation of Concerns** - separating logic from presentation

### Core Components
#### 1. **Game** `lib/game.rb`
- Game state management
- Player move processing
- Win/loss condition checking
- Duplicate letter validation

#### 2. **WordReader** `lib/word_reader.rb`
- Reading words from file
- Getting words from command-line arguments
- Random word selection from list

#### 3. **ResultPrinter** `lib/result_printer.rb`
- Game status display
- Progress visualization
- Results output

### Testing
- **RSpec** - testing framework
- Unit tests for game logic validation
- Test coverage for win and loss scenarios

### Error Handling
- Exception handling (`ArgumentError`, `RuntimeError`) 
- Proper interrupt handling (`Interrupt`) 
- Input data validation
- Graceful degradation

### File Operations
- Reading from text files
- UTF-8 encoding support

### I/O Operations
- Interactive input/output
- User input processing
- Formatted results output

## 🧪 Running Tests
```bash

# Install dependencies

gem install rspec

# Run tests
rspec spec/game_spec.rb
```

## 📋 Requirements

- Ruby >= 3.0
- RSpec (for testing)
- UTF-8 support

## 💡 Demonstrated Skills

✅ Console application development in Ruby  
✅ Object-oriented design  
✅ Writing modular and extensible code  
✅ Unit testing with RSpec  
✅ Exception and error handling  
✅ File system operations  
✅ Working with encodings (UTF-8)  
✅ Git version control  
✅ Code documentation
