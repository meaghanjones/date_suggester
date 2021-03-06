require 'bundler/setup'
Bundler.require(:default)

require 'pry'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  erb(:index)
end

get '/dates/new' do
  @date_idea = DateIdea.new
  @tag = Tag.new
  @tags = Tag.all
  erb(:date_form)
end

post '/dates' do
  name = params.fetch('name')
  street = params[:street]
  city = params[:city]
  state = params[:state]
  description = params[:description]
  address = "#{street}\n#{city},#{state}"
  rating = 0
  @date_idea = DateIdea.create({:name => name, :address => address, :description => description, :rating => rating})
  if @date_idea.save
    redirect to "/dates/#{@date_idea.id}"
  else
    erb(:date_form)
  end
end

get '/dates/random' do
  date_idea = DateIdea.order_by_rand.first
  redirect('/dates/'.concat(date_idea.id.to_s))
end

get '/dates/:id' do
  @date_idea = DateIdea.find(params.fetch('id').to_i)
  @tags = Tag.all - @date_idea.tags
  @datelog = Datelog.new
  @tag = Tag.new
  erb(:date)
end

get '/dates' do
  @date_ideas = DateIdea.order('rating  DESC')
  erb(:dates)
end

patch '/dates/:id/rate' do
  @date_ideas = DateIdea.order('rating  DESC')
  date_idea = DateIdea.find(params.fetch('id').to_i)
  rating = params.fetch('rating').to_i
  date_idea.update({:rating => rating})
  redirect to("/dates")
end

get '/dates/:id/edit' do
  @date_idea = DateIdea.find(params.fetch('id').to_i)
  erb(:date_edit)
end

patch '/dates/:id' do
  @date_idea = DateIdea.find(params.fetch('id').to_i)
  name = params.fetch('name')
  address = params[:address]
  description = params[:description]
  @date_idea.update({:name => name, :address => address, :description => description})
  if @date_idea.save()
    redirect('/dates/'.concat(@date_idea.id.to_s))
  else
    erb(:date_edit)
  end
end

delete '/dates/:id' do
  @date_idea = DateIdea.find(params.fetch('id').to_i)
  @date_idea.destroy
  redirect('/dates')
end

post '/dates/:id/rating' do
  date_idea = DateIdea.find(params.fetch('id').to_i)
  rating = params.fetch('rating').to_i
  date_idea.update({:rating => rating})
  redirect to("/dates/#{date_idea.id}")
end

get '/tags/new' do
  erb(:tag_form)
end

post '/tags/onpage' do
  tag_name = params.fetch('tag_name')
  @tag = Tag.create(:name => tag_name)
  @tags = Tag.all
  if @tag.save
    redirect('/tags')
  else
    erb(:tags)
  end
end

post '/tags/:date_idea_id' do
  tag_name = params.fetch('tag_name')
  @tag = Tag.create(:name => tag_name)
  @tags = Tag.all
  @datelog = Datelog.new
  @date_idea = DateIdea.find(params.fetch('date_idea_id').to_i)
  if @tag.save
    redirect("/dates/#{@date_idea.id}")
  else
    erb(:date)
  end

end


get '/tags' do
  @tags = Tag.all()
  @tag = Tag.new
  erb(:tags)
end

get '/tags/:id' do
  @tag = Tag.find(params.fetch('id').to_i)
  erb(:tag)
end

patch '/tags/:id/remove/:date_idea_id' do
  id = params.fetch('id').to_i
  tag = Tag.find(id)
  date_idea_id = params.fetch('date_idea_id')
  @date_idea = DateIdea.find(date_idea_id)
  @date_idea.tags.destroy(tag)
  redirect to("/dates/#{date_idea_id}")
end

patch '/tags/:id/add/:date_idea_id' do
  id = params.fetch('id').to_i
  tag = Tag.find(id)
  date_idea_id = params.fetch('date_idea_id')
  @date_idea = DateIdea.find(date_idea_id)
  @date_idea.tags.push(tag)
  redirect to("/dates/#{date_idea_id}")
end


patch '/tags/:id' do
  @tag = Tag.find(params.fetch('id').to_i)
  name = params.fetch('tag_name')
  @tag.update({:name => name})
  if @tag.save
    redirect back
  else
    erb(:tag)
  end
end

delete '/tags/:id/delete' do
  @tag = Tag.find(params.fetch('id').to_i)
  @tag.destroy
  redirect('/tags')
end

post '/datelogs/:date_idea_id' do
  rendezvous_time = params.fetch('rendezvous_time')
  romantic_interest = params[:romantic_interest]
  notes = params[:notes]
  date_idea_id = params.fetch('date_idea_id')
  @date_idea = DateIdea.find(date_idea_id)
  @datelog = @date_idea.datelogs.create({:rendezvous_time => rendezvous_time, :romantic_interest => romantic_interest, :notes => notes})
  @tags = Tag.all - @date_idea.tags
  if @datelog.save
    redirect("/dates/#{@date_idea.id.to_s}")
  else
    erb(:date)
  end
end

get '/datelogs/:id' do
  @datelog = Datelog.find(params.fetch('id').to_i)
  erb(:datelog)
end

get '/datelogs/:id/edit' do
  @datelog = Datelog.find(params.fetch('id').to_i)
  erb(:datelog_edit)
end

patch '/datelogs/:id' do
  @datelog = Datelog.find(params.fetch('id').to_i)
  rendezvous_time = params.fetch('rendezvous_time')
  romantic_interest = params[:romantic_interest]
  notes = params[:notes]
  @datelog.update({:rendezvous_time => rendezvous_time, :romantic_interest => romantic_interest, :notes => notes})
  if @datelog.save()
    redirect('/datelogs/'.concat(@datelog.id.to_s))
  else
    erb(:datelog)
  end
end

delete '/datelogs/:date_idea_id/:id' do
  @datelog = Datelog.find(params.fetch('id').to_i)
  @datelog.destroy
  date_idea = DateIdea.find(params.fetch('date_idea_id').to_i)
  redirect('/dates/'.concat(date_idea.id.to_s))
end

post '/dates/search' do
  date_idea_search = params.fetch('date_idea_search').titlecase
  @search_results = []
  date_search_results = DateIdea.where("name LIKE ?", "%#{date_idea_search}%")
  tag_search_results = Tag.where("name LIKE ?", "%#{date_idea_search}%")
  tag_search_results.each do |tag|
    tag.date_ideas.each() do |idea|
      @search_results.push(idea)
    end
  end
  date_search_results.each do |date|
    @search_results.push(date)
  end
  if @search_results.!=([])
    erb(:search_results)
  else
    erb(:no_result)
  end
end
