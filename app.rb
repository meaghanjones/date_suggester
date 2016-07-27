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
  tag_ids = params[:tag_ids]
  address = "#{street}\n#{city},#{state}"
  rating = 0
  @date_idea = DateIdea.create({:name => name, :address => address, :description => description, :rating => rating, :tag_ids => tag_ids})
  @tags = Tag.all
  @tag = Tag.new
  erb(:date_form)
end

get '/dates/:id' do
  @date_idea = DateIdea.find(params.fetch('id').to_i)
  @tags = Tag.all - @date_idea.tags
  erb(:date)
end

get '/dates' do
  @date_ideas = DateIdea.order('rating  DESC')
  erb(:dates)
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
    redirect("/dates/#{@date_idea.id}/edit")
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

post '/tags' do
  tag_name = params.fetch('tag_name')
  @tag = Tag.create(:name => tag_name)
  @tags = Tag.all
  @date_idea = DateIdea.new
  erb(:date_form)
end

post '/tags/onpage' do
  tag_name = params.fetch('tag_name')
  @tag = Tag.create(:name => tag_name)
  @tags = Tag.all
  if @tag.save
    redirect('/tags')
  else
    erb(:_errors)
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
  redirect('/tags/'.concat(@tag.id.to_s))
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
  date_idea = DateIdea.find(date_idea_id)
  date_idea.datelogs.create({:rendezvous_time => rendezvous_time, :romantic_interest => romantic_interest, :notes => notes})
  redirect back
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
    erb(:date_log)
  end
end

delete '/datelogs/:date_idea_id/:id' do
  @datelog = Datelog.find(params.fetch('id').to_i)
  @datelog.destroy
  date_idea = DateIdea.find(params.fetch('date_idea_id').to_i)
  redirect('/dates/'.concat(date_idea.id.to_s))
end
