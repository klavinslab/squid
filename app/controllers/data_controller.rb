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
      format.json {render :json => to_epoch_t(@datum)}
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
        render :json => to_epoch_t(@d.to_a)
      end
    end
  end

private
  def datum_params
    #the rails tutorials say I should use permit and require
    #but they crash so maybe thats a rails 4 thing.
    params[:datum]

  end

  def to_epoch_t (d)
    #takes a datum or datum array and changes the date to an epoch time float.
    if (d.class == Array)
      d.map do |datum| 
        datum.created_at = datum.created_at.to_f
        datum.updated_at = datum.updated_at.to_f
      end
    else
      d.created_at = d.created_at.to_f
      d.updated_at = d.updated_at.to_f
    end
    return d

  end

end
