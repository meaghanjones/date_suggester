require('bundler/setup')
Bundler.require(:default)

require('pry')

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  erb(:index)
end

get('/dates/new') do
  @date_idea = DateIdea.new
  erb(:date_form)
end

post('/dates') do
  name = params.fetch('name')
  street = params[:street]
  city = params[:city]
  state = params[:state]
  description = params[:description]
  address = "#{street}\n#{city},#{state}"
  rating = 0
  @date_idea = DateIdea.create({:name => name, :address => address, :description => description, :rating => rating})
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

get('/dates/:id/edit') do
  @date_idea = DateIdea.find(params.fetch('id').to_i)
  erb(:date_edit)
end

patch('/dates/:id') do
  @date_idea = DateIdea.find(params.fetch('id').to_i)
  name = params.fetch('name')
  address = params[:address]
  description = params[:description]
  @date_idea.update({:name => name, :address => address, :description => description})
  if @date_idea.save()
    redirect('/dates/'.concat(@date_idea.id.to_s))
  else
    erb(:date_errors)
  end
end

delete('/dates/:id') do
  @date_idea = DateIdea.find(params.fetch('id').to_i)
  @date_idea.destroy
  redirect('/dates')
end

post('/dates/:id/rating') do
  date_idea = DateIdea.find(params.fetch('id').to_i)
  rating = params.fetch('rating').to_i
  date_idea.update({:rating => rating})
  redirect to("/dates/#{date_idea.id}")
end
