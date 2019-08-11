class DonationController < ApplicationController 

  get '/donations' do 
        @user = current_user
        if logged_in?
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

    post '/donations' do 
        if logged_in? 
            if params[:amount] != nil && params[:charity] != ""
                @donation = Donation.create(params)
                @user = current_user 
                @user.donations << @donation
                @user.save 
                @donation.save
                redirect to '/donations'
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
                redirect to '/donations'
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
            redirect to '/donations'
        else 
            redirect to '/login'
        end 
    end 

end 