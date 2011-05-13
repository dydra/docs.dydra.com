require 'rubygems'
require 'bundler'
Bundler.setup
$:.unshift File.dirname(__FILE__)
require 'indextank'
require 'topic'
require 'net/http'
require 'uri'

desc 'Start a development server'
task :server do
	if which('shotgun')
		exec 'shotgun -O docs.rb'
	else
		warn 'warn: shotgun not installed; reloading is disabled.'
		exec 'ruby -rubygems docs.rb -p 9393'
	end
end

desc 'Index documentation'
task :index do
  puts "indexing now:"
  client = IndexTank::Client.new(ENV['DYDRA_INDEXTANK_URL'])
  index = client.indexes('docs')
  index.add unless index.exists?

  docs = FileList['docs/*.txt']
  docs.each do |doc|
    name = name_for(doc)
    puts "...indexing #{name}"
    source = File.read(doc)
    topic = Topic.load(name, source)
    topic.text_only
    result = indextank_document = index.document(name).add(:title => topic.title, :text => topic.body)
    puts "=> #{result}"
  end
  puts "finished indexing"
end

desc 'Sample search'
task :search, :query do |t, args|
  client = IndexTank::Client.new(ENV['DYDRA_INDEXTANK_URL'])
  index = client.indexes('docs')
  results = index.search(args[:query], :fetch => 'title', :snippet => 'text')
  puts "#{results['matches']} results."
  puts results.inspect
end

task :start => :server

desc "Update template."
task :update_template do
  s = Net::HTTP.get URI.parse('http://dydra.com/template')
  main = File.read('views/main_content.erb')
  ga = File.read('views/google_analytics.erb')
  sidebar = File.read('views/sidebar.erb')
  s.gsub!(/\<title\>.+\<\/title\>/m, '<title>Dydra | <%=h @title %></title>')
  s.gsub!(/\<body\ class=[\'\"].+[\'\"]\>/, '<body class="docs">')
  s.gsub!(/\<script\ src=\"https\:\/\/www.google.com\/jsapi\?key\=.+\"\ type=\"text\/javascript\"\>\<\/script\>/, '<script src="https://www.google.com/jsapi?key=ABQIAAAAQUhgcqxq--MWYkEaUwYkOxSiLYLpKcN2trQdajp33h_3zPteGBSjW0O6m_UM52KZWX3vyqlIZagqSQ" type="text/javascript"></script>')
  s.gsub!('[INSERT CONTENT HERE]', main)
  s.gsub!('[INSERT SIDEBAR CONTENT HERE]', sidebar)
  m = s.match(/.+(<script\b[^>]*>.+?google-analytics.+?<\/script\>)/m)
  s.gsub!(m[1], ga)
  File.open('views/layout.erb', 'w') {|f| f.write s}
  File.open('views/layout.haml', 'w'){|f| f.write ":erb\n  " + File.read('views/layout.erb').gsub("\n", "\n  ")}
end

def which(command)
	ENV['PATH'].
		split(':').
		map  { |p| "#{p}/#{command}" }.
		find { |p| File.executable?(p) }
end

def name_for(doc)
  File.basename(doc, '.txt')
end

namespace :build do
  desc "Build the developer guide (requires texi2pdf)"
  task :guide do
    sh 'cd docs && texi2pdf guide.texi'
  end
end

file 'docs/guide.pdf' => 'build:guide'
