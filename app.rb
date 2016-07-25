require('bundler/setup')
Bundler.require(:default)

require('pry')

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  erb(:index)
end

get('/dates/new') do
  erb(:date_form)
end
