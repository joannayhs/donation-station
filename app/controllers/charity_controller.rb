class CharityController < ApplicationController

    get '/charities' do 
        @charities = Charity.all
        erb :'/charity/charities'
    end 

    get '/charities/new' do 
        authenticator 
        erb :'/charity/new'
    end 

    get '/charities/:id' do 
        @charity = Charity.find_by_id(params[:id])
        erb :'charity/show'
    end 

    get '/charities/:id/edit' do 
        authenticator
        @charity = Charity.find_by_id(params[:id])
        authorize(@charity)
        erb :'charity/edit'
    end 

     get '/charities/:id/delete' do 
        @charity = Charity.find_by_id(params[:id])
        authenticator
        authorize(@charity)
        erb :'/charity/delete'
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

    patch '/charities/:id' do 
        @charity = Charity.find_by_id(params[:id])
        if logged_in? && @charity.user_id == current_user.id
            if params[:name] != nil && params[:description] != nil 
                @charity.update(name: params[:name], description: params[:description])
                @charity.save 
                redirect to '/charities'
            else 
                redirect to '/charities/:id/edit'
            end 
        else 
            redirect to '/login'
        end 
    end 

    delete '/charities/:id/delete' do 
         @charity = Charity.find_by_id(params[:id])
         @charity.destroy
         redirect to '/charities'
    end   


end 