class DonationController < ApplicationController 

  get '/donations' do 
        if logged_in?
            @user = current_user
            @charities = Charity.all 
            erb :'/donation/show'
        else 
            redirect to '/login'
        end 
    end 

    get '/donations/new' do 
        if logged_in? 
            @charities = Charity.all
            erb :'/donation/new'
        else 
            redirect to '/login'
        end 
    end 

    post '/donations' do 
        if logged_in? 
            if params[:donations][:amount] != nil && params[:charities][:name] != "" && params[:charities][:description] != ""
                @donation = Donation.create(amount: params[:donations][:amount])
                @charity = Charity.create(name: params[:charities][:name], description: params[:charities][:description])
                @charity.donations << @donation 
                @user = current_user 
                @user.donations << @donation
                redirect to '/donations'
            else 
                redirect to '/donations/new'
            end 
        else 
            redirect to '/login'
        end 
    end 

end 