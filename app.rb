require 'rubygems'
require 'sinatra'
require 'haml'
require 'yaml'

require 'site'

def load_sites
  raw_sites = File.open('sites.yml') { |yf| YAML::load( yf ) }
  sites = []
  raw_sites.each do |s|
    sites << Site.new(s)
  end
  return sites
end

configure do
  set :sites, load_sites
end

get '/' do
  @sites = settings.sites
  @sites.each {|s| s.check }
  haml :index
end
