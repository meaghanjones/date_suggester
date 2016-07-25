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

post('/dates') do
  name = params.fetch('name')
  street = params[:street]
  city = params[:city]
  state = params[:state]
  description = params[:description]
  address = "#{street}\n#{city},#{state}"
  @date_idea = DateIdea.create({:name => name, :address => address, :description => description})
  if @date_idea.save
   redirect('/dates/'.concat(@date_idea.id.to_s))
  else
   erb(:date_errors)
 end
end

get('/dates/:id') do
  @date_idea = DateIdea.find(params.fetch('id').to_i)
  erb(:date)
end

get('/dates') do
  @date_ideas = DateIdea.all
  erb(:dates)
end
