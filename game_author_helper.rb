require 'json'
require_relative 'game'
require_relative 'author'

class GameLibrary
  attr_reader :games, :authors

  DATA_PATH = './data'.freeze
  GAMES_FILE = "#{DATA_PATH}/games.json".freeze
  AUTHORS_FILE = "#{DATA_PATH}/authors.json".freeze

  def initialize
    @games = []
    @authors = []
  end

  def add_game(game)
    @games << game
    game.authors.each { |author| add_author(author) }
    puts 'Game Created 🎮'
  end

  def add_author(author)
    return if authors.include?(author)

    authors << author
    # author.items.each { |item| add_game(item) if item.is_a?(Game) }
  end

  def list_games
    if games.empty?
      puts 'There are no games in the catalog.'
    else
      games.each do |game|
        puts '-' * 110
        print "Game ID: #{game.id}, "
        print "Title: #{game.title}, "
        print "Multiplayer: #{game.multiplayer ? 'Yes' : 'No'}, "
        print "Last Played At: #{game.last_played_at}, "
        print "Publish Date: #{game.publish_date}, "
        puts "Authors: #{game.authors.map(&:full_name).join(', ')}"
      end
      puts '-' * 110
    end
  end

  def list_authors
    if authors.empty?
      puts 'There are no authors in the catalog.'
    else
      puts 'List of authors:'
      authors.each do |author|
        puts '-' * 50
        print "Author ID: #{author.id}, "
        print "Name: #{author.full_name}, "
        puts "Items: #{author.items.map(&:title).join(', ')}"
      end
      puts '-' * 50
    end
  end

  def save_data
    return unless File.exist?(GAMES_FILE) && File.exist?(AUTHORS_FILE)

    File.write(GAMES_FILE, JSON.generate(games.map(&:to_hash)))
    File.write(AUTHORS_FILE, JSON.generate(authors.map(&:to_hash)))
  end

  def load_data
    return unless File.exist?(GAMES_FILE) && File.exist?(AUTHORS_FILE)

    games_data = JSON.parse(File.read(GAMES_FILE))
    authors_data = JSON.parse(File.read(AUTHORS_FILE))
    games_data.map do |game_data|
      game = Game.new(game_data['title'], game_data['multiplayer'], game_data['last_played_at'],
                      game_data['publish_date'], game_data['authors'])
      add_game(game)
    end
    authors_data.map do |author_data|
      author = Author.new(author_data['first_name'], author_data['last_name'], author_data['items'])
      add_author(author)
    end
  end

  def game_menu
    load_data

    loop do
      puts 'Welcome!'
      puts '1. List all games'
      puts '2. List all authors'
      puts '3. Add game'
      puts '4. Back to Main Menu'
      puts '5. Quit'
      choice = gets.chomp.to_i
      if choice == 4
        save_data
        break
      end
      excute_selection(choice)
    end
  end

  def excute_selection(choice)
    case choice
    when 1
      list_games
    when 2
      list_authors
    when 3
      add_new_game
    when 5
      save_data
      puts 'Thanks for using this app'
      exit
    else
      puts 'Invalid choice. Please choose again.'
    end
  end

  private

  def add_new_game
    print 'Enter game title: '
    title = gets.chomp
    print 'Is the game multiplayer? (Y/N): '
    multiplayer = gets.chomp.downcase == 'y'
    print 'Enter the date of the last time the game was played (YYYY/MM/DD): '
    last_played_at = gets.chomp
    print 'Enter the game\'s publish date (YYYY/MM/DD): '
    publish_date = gets.chomp

    game = Game.new(title, multiplayer, last_played_at, publish_date, [])
    add_game(game)
    add_author_to_game(game)
  end

  def add_author_to_game(game)
    print 'Enter author first name: '
    first_name = gets.chomp
    print 'Enter author last name: '
    last_name = gets.chomp
    author = Author.new(first_name, last_name)
    add_author(author)
    game.add_author(author)
  end
end
