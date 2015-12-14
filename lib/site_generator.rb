require 'pry'
require 'erb'

class SiteGenerator
  def make_index!
    header = <<-STRING
<!DOCTYPE html>
<html>
  <head>
    <title>Movies</title>
  </head>
  <body>
    <ul>
    STRING
  
    footer = <<-STRING
    </ul>
  </body>
</html>
    STRING

    File.open('_site/index.html','w') { |f| f.write(header) }
    Movie.all.each do |movie|
      File.open('_site/index.html','a') do |f|
        f.write("      <li><a href=\"movies/#{movie.url}\">#{movie.title}</a></li>\n")
      end
    end
    File.open('_site/index.html','a') { |f| f.write(footer) }
  end

  def generate_pages!
    html = File.open('lib/templates/movie.html.erb', 'r').read
    template = ERB.new(html)
    Movie.all.each do |movie|
      File.open("_site/movies/#{movie.url}", 'a') { |f| f.write(template.result(binding)) }
    end
  end
end

#SiteGenerator.new.generate_pages!