class UserController < ApplicationController

    get '/login' do 
     if !logged_in?
        erb :'/user/login'
     else 
        redirect to '/#{current_user.username}/donations'
     end 
    end 

    post '/login' do 
       @user = User.find_by(username: params[:username])
       if @user && @user.authenticate[params[:password])
        session[:id] = @user.id 
        redirect to "/#{current_user.username}/donations"
       else 
        redirect to '/signup'
       end 
    end 
    
end 