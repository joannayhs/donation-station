class ApplicationController < Sinatra::Base 
    configure do 
        set 'public_folder', 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "donation_station"
    end 

    get '/' do 
        erb :index
    end 

    not_found do 
        status 404 
        erb :error
    end 

    helpers do 
     def logged_in? 
        !!session[:user_id]
     end 

     def current_user 
        User.find_by_id(session[:user_id])
     end 

     def authenticator 
        if !logged_in?
            redirect to '/login'
        end 
    end

    def authorize(resource)
        if resource.user != current_user 
            redirect to '/profile'
        end
    end 
end 
    
end 