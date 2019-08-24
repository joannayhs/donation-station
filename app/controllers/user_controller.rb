class UserController < ApplicationController
    
      get '/profile' do 
        @user = current_user
        @charities = @user.charities
        authenticator
        erb :'/user/profile'
    end 
    
    get '/login' do 
     if !logged_in?
        @failed = false
        erb :'/user/login'
     else 
        redirect to "/profile"
     end 
    end 

    post '/login' do 
       user = User.find_by(username: params[:username])
       if user && user.authenticate(params[:password])
        session[:user_id] = user.id 
        redirect to "/profile"
       else 
        @failed = true 
        erb :'user/login'
       end 
    end 

    get '/signup' do 
        redirect to '/profile' if logged_in?
        @user = nil
        erb :'/user/signup' 
    end 

    post '/signup' do 
        user = User.create(params)
        if user.errors.any? 
            @errors = user.errors.full_messages
            erb :'/user/signup'
        else 
            session[:user_id] = user.id 
            redirect to "/profile"
        end 
    end 
    
   get '/logout' do 
        authenticator
        session.destroy 
        redirect '/'
    end 

    
end 