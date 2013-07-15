class DataController < ApplicationController

  def new
  end

  #POST /data
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
      format.json {render :json => @datum }
    end
  end

  #note: this is only going to show the most recent #100 data
  #note: I'm assuming ID's are monotonic and in insert order...
  def index 
    @d = Datum.order('id DESC').limit(100)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @datum }
      format.json do
        #convert to EPOCH time for easy JSON data exchange.
        render :json => @d.to_a
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
