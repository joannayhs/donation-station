class UserController < ApplicationController
    
    get '/:username' do 
        if logged_in?
            @user = current_user
            erb :'/user/show'
        else 
            redirect to '/login'
        end 
    end 

    get '/login' do 
     if !logged_in?
        erb :'/user/login'
     else 
        redirect to "/#{current_user.username}"
     end 
    end 

    post '/login' do 
       @user = User.find_by(username: params[:username])
       if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id 
        redirect to "/#{current_user.username}"
       else 
        redirect to '/signup'
       end 
    end 

    get '/signup' do 
     if logged_in?
        redirect to "/#{current_user.username}"
     else 
        erb :'/user/signup'
     end 
    end 

    post '/signup' do 
        if params[:username] == "" || params[:password] == ""
            redirect to '/signup'
        else 
            if params[:username] != User.find_by(username: params[:username])
                @user = User.create(params) 
                session[:user_id] = @user.id 
                redirect to "/#{current_user.username}"
            else 
                redirect to '/signup'
            end 
        end 
    end 
    
   get 'logout' do 
        if logged_in?
            session.destroy
            redirect '/'
        else 
            redirect '/login'
        end 
    end 

    
end 