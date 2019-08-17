class UserController < ApplicationController
    
      get '/profile' do 
        @user = current_user
        @charities = @user.charities
        if logged_in?
            erb :'/user/profile'
        else 
            redirect to '/login'
        end 
    end 
    
    get '/login' do 
     if !logged_in?
        erb :'/user/login'
     else 
        redirect to "/profile"
     end 
    end 

    post '/login' do 
       @user = User.find_by(username: params[:username])
       if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id 
        redirect to "/profile"
       else 
        redirect to '/signup'
       end 
    end 

    get '/signup' do 
     if logged_in?
        redirect to "/profile"
     else 
        erb :'/user/signup'
     end 
    end 

    post '/signup' do 
        if params[:username] == "" || params[:password] == ""
            redirect to '/signup'
        else 
            if User.all.empty? || !User.find_by(username: params[:username])
                @user = User.create(username: params[:username].downcase, password: params[:password])
                session[:user_id] = @user.id 
                redirect to "/profile"
            else 
                redirect to '/login'
            end 
        end 
    end 
    
   get '/logout' do 
        if logged_in?
            session.destroy
            redirect '/'
        else 
            redirect '/login'
        end 
    end 

    
end 