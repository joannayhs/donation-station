class DonationController < ApplicationController 

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
            if params[:donation][:amount] != nil && params[:charity]!= nil 
                @donation = Donation.create(params[:donation])
                current_user.donations << @donation
                @donation.user_id = current_user.id 
                @donation.charity_id = Charity.find_by(name: params[:charity][:name])
                @donation.save 
                current_user.save
                redirect to '/profile'
            else 
                redirect to '/donations/new'
            end 
        else 
            redirect to '/login'
        end 
    end 

    get '/donations/:id/edit' do 
        @donation = Donation.find_by_id(params[:id])
        if logged_in? 
            erb :'/donation/edit'
        else 
            redirect to '/login'
        end 
    end 

    patch '/donations/:id' do 
        if logged_in? 
            @donation = Donation.find_by_id(params[:id])
            if params[:amount] != nil && params[:charity] != "" 
                @donation.update(amount: params[:amount], charity: params[:charity])
                @donation.save 
                redirect to '/profile'
            else 
                redirect to "/donations/#{@donation.id}/edit"
            end 
        else 
            redirect to '/login'
        end 
    end 

    get '/donations/:id/delete' do 
        if logged_in?
            @donation = Donation.find_by_id(params[:id])
            erb :'/donation/delete'
        else 
            redirect to '/login'
        end 
    end 

    delete '/donations/:id/delete' do 
        if logged_in?
            @donation = Donation.find_by_id(params[:id])
            @donation.destroy
            redirect to '/profile'
        else 
            redirect to '/login'
        end 
    end 

end 