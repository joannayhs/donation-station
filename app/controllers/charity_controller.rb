class CharityController < ApplicationController

    get '/charities' do 
        @charities = Charity.all
        erb :'/charity/charities'
    end 

    get '/charities/new' do 
        if logged_in? 
            erb :'charity/new'
        else 
            redirect to '/login'
        end 
    end 

    post '/charities' do 
        if logged_in? 
            if params[:name] != "" && params[:description] != "" 
                @charity = Charity.create(params)
                @charity.user_id = current_user.id
                current_user.charities << @charity 
                current_user.save 
                redirect to '/charities'
            else 
                redirect to '/charities/new' 
            end 
        else 
            redirect to '/login'
        end 
    end 


end 