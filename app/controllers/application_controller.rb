class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/artists' do
    @all = Artist.all
    erb :index
  end

  get '/artists/:slug' do
    @artist = Artist.fing_by_slug(params[:slug])
    erb :'artist/show'
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
