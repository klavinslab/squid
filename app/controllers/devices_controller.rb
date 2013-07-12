require 'open-uri'

class DevicesController < ApplicationController
  # GET /devices
  # GET /devices.json
  def index
    @devices = Device.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @devices }
    end
  end

  # GET devices/:id/data?start=<start>&end=<end>
  # GET devices/:id/data.json?start=<start>&end=<end>
  def searchdata
    @device = get_device_by_any_id(params[:id])
    @d = @device.data.order(params[:order]=="ASC"?'id ASC':'id DESC')
      .limit(params[:limit]||100)
    if params[:start]
      @d = @d.where("created_at > :stime", :stime => Time.zone.at(params[:start].to_f))
    end
    if params[:end]
      @d = @d.where("created_at < :etime", :etime => Time.zone.at(params[:end].to_f))
    end
                
    respond_to do |format|
      format.html {render "data/index"}
      format.json {render json: @d}
    end

  end

  # GET /devices/1
  # GET /devices/1.json
  def show
    @device = get_device_by_any_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @device }
    end
  end

  # GET /devices/new
  def new
    @device = Device.new
  end

  # GET /devices/1/edit
  def edit
    @device = Device.find(params[:id])
  end

  # POST /devices
  def create
    #exceptions thrown by open should be caught.
    open("http://"+params[:device][:ip]+":"+params[:device][:port]+"/?cmd=info", 
         :read_timeout => 5.0) do |body|
      @info = ActiveSupport::JSON.decode(body)
    end
    open("http://"+params[:device][:ip]+":"+params[:device][:port]+
         "/?cmd=acquire&port="+request.port.to_s) 

    device_info = params[:device].merge(@info)
    @device = Device.new(device_info)


    if @device.save
      redirect_to @device, notice: 'Device was successfully created.' 
    else
      render action: "new"
    end
  end

  # PUT /devices/1
  # PUT /devices/1.json
  def update
    @device = Device.find(params[:id])

    respond_to do |format|
      if @device.update_attributes(params[:device])
        format.html { redirect_to @device, notice: 'Device was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  def destroy
    @device = Device.find(params[:id])
    @device.destroy

    redirect_to devices_url
  end

private
  def get_device_by_any_id(id)
    #assume its a uuid if not try DB id
    d = Device.where(uuid: id).last
    if d
      return d
    end
    return Device.find(id)
  end
  
end
