class DonationController < ApplicationController 

    get '/donations/new' do 
        authenticator 
        @charities = Charity.all 
        erb :'donation/new'
    end 

    post '/donations' do 
        if logged_in? 
            if params[:donations][:amount] != nil && params[:charities] 
                @donation = Donation.create(params[:donations])
                current_user.donations << @donation
                @donation.user_id = current_user.id 
                @donation.charity_id = Charity.find_by(name: params[:charities][:name]).id
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
        @charities = Charity.all
        authenticator 
        authorize(@donation)
        erb :'/donation/edit'
    end 

    patch '/donations/:id' do 
        if logged_in? 
            @donation = Donation.find_by_id(params[:id])
            if params[:amount] != nil && params[:charity]
                @donation.update(amount: params[:amount], charity_id: Charity.find_by(name: params[:charity]).id)
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
        if logged_in? && current_user.id == Donation.find_by_id(params[:id]).user_id
            @donation = Donation.find_by_id(params[:id])
            @charity = Charity.find_by_id(@donation.charity_id)
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