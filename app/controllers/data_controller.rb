class DataController < ApplicationController

  def new
  end

  def create
    @datum = Datum.new(datum_params)
    @datum.save
    redirect_to @datum
    
  end

  def show
    @datum = Datum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @datum }
      format.json do
        #convert to EPOCH time for easy JSON data exchange.
        @datum.created_at = @datum.created_at.to_f
        @datum.updated_at = @datum.updated_at.to_f
        render :json => @datum 
      end
    
    end
  end

private
  def datum_params
    #the rails tutorials say I should use permit and require
    #but they crash so maybe thats a rails 4 thing.
    params[:datum]

  end

end
