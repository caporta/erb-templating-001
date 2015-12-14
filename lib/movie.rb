require 'cgi'

class Movie
  attr_accessor :title, :release_date, :director, :summary
  @@movies = []

  def initialize(title, release_date, director, summary)
    @title, @release_date, @director, @summary = 
    title, release_date, director, summary
    @@movies << self
  end

  def url
    new_title = title.downcase.gsub(' ', '_') + '.html'
    url_friendly = CGI::escape(new_title)
  end

  def self.all
    @@movies
  end

  def self.reset_movies!
    @@movies.clear
  end

  def self.make_movies!
    File.readlines('spec/fixtures/movies.txt').each do |line|
      m = line.strip.split(' - ')
      Movie.new(m[0], m[1].to_i, m[2], m[3])
    end
  end

  def self.recent
    self.all.select {|movie| movie.release_date >= 2012}
  end
end