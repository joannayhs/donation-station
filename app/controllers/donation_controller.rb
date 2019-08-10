class DonationController < ApplicationController 

  get '/donations' do 
        if logged_in?
            @user = current_user
            erb :'/donation/show'
        else 
            redirect to '/login'
        end 
    end 

    get '/donations/new' do 
        if logged_in? 
            erb :'/donation/new'
        else 
            redirect to '/login'
        end 
    end 


end 