class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/songs/new' do
    erb :'song/new'
  end

  get '/artists' do
    @all = Artist.all
    erb :index
  end

  get '/artists/:slug' do
    @artist = Artist.find_by_slug(params[:slug])
    erb :'artist/show'
  end

  get '/songs' do
    @all = Song.all
    erb :index
  end

  post '/songs' do
    @song = Song.create(params[:song])
    if !params[:artist][:name].empty?
      @song.artist = Artist.create(name: params[:artist][:name])
    end
    if !params[:genre][:name].empty?
      @song.genres << Genre.create(name: params[:genre][:name])
    end
    redirect '/songs/#{@song.slug}'
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :edit
  end

  patch '/songs' do
    @song = Song.find_by_slug(params[:slug])
    @song.update(params[:song])
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'song/show'
  end

  get '/genres' do
    @all = Genre.all
    erb :index
  end

  get '/genres/:slug' do
    @genre = Genre.find_by_slug(params[:slug])
    erb :'genre/show'
  end



  # get '/:class_name' do
  #   class_name = params[:class_name].singularize.capitalize
  #   @all = send("#{class_name}.all")
  #   erb :index
  # end
  #
  # get '/:class_name/:slug' do
  #   class_name = params[:class_name].singularize.capitalize
  #   @instance = send("#{class_name}.find_by_slug(#{params[:slug]})")
  #   erb :'#{class_name.downcase}/show'
  # end

end
