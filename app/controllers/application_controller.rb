class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }
  require 'rack-flash'
  use Rack::Flash

  configure do
    enable :sessions
  end

  get '/songs/new' do
    @artists = Artist.all
    @genres = Genre.all
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
      if !(artist = Artist.find_by name: params[:artist][:name])
        artist = Artist.create(name: params[:artist][:name])
      end
      @song.artist = artist
    end
    if !params[:genre][:name].empty?
      if !(genre = Genre.find_by name: params[:genre][:name])
        genre = Genre.create(name: params[:genre][:name])
      end
      @song.genres << genre
    end
    @song.save
    flash[:message] = "Successfully created song."
    redirect to("/songs/#{@song.slug}")
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @artists = Artist.all
    @genres = Genre.all
    erb :'song/edit'
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.update(params[:song])
    if !params[:artist][:name].empty?
      if !(artist = Artist.find_by name: params[:artist][:name])
        artist = Artist.create(name: params[:artist][:name])
      end
      @song.artist = artist
    end
    if !params[:genre][:name].empty?
      if !(genre = Genre.find_by name: params[:genre][:name])
        genre = Genre.create(name: params[:genre][:name])
      end
      @song.genres << genre
    end
    @song.save
    flash[:message] = "Successfully updated song."
    redirect to("/songs/#{@song.slug}")
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
