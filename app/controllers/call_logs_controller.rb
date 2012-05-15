class CallLogsController < ApplicationController
  # GET /call_logs
  # GET /call_logs.json
  def index
    @call_logs = CallLog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @call_logs }
    end
  end

  # GET /call_logs/1
  # GET /call_logs/1.json
  def show
    @call_log = CallLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @call_log }
    end
  end

  # GET /call_logs/new
  # GET /call_logs/new.json
  def new
    @call_log = CallLog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @call_log }
    end
  end

  # GET /call_logs/1/edit
  def edit
    @call_log = CallLog.find(params[:id])
  end

  # POST /call_logs
  # POST /call_logs.json
  def create
    @call_log = CallLog.new(params[:call_log])

    respond_to do |format|
      if @call_log.save
        format.html { redirect_to @call_log, notice: 'Call log was successfully created.' }
        format.json { render json: @call_log, status: :created, location: @call_log }
      else
        format.html { render action: "new" }
        format.json { render json: @call_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /call_logs/1
  # PUT /call_logs/1.json
  def update
    @call_log = CallLog.find(params[:id])

    respond_to do |format|
      if @call_log.update_attributes(params[:call_log])
        format.html { redirect_to @call_log, notice: 'Call log was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @call_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /call_logs/1
  # DELETE /call_logs/1.json
  def destroy
    @call_log = CallLog.find(params[:id])
    @call_log.destroy

    respond_to do |format|
      format.html { redirect_to call_logs_url }
      format.json { head :no_content }
    end
  end

  # new methods added for Twilio integration

  def begin
    call_log = CallLog.new
    call_log.save
    url = url_for :action => :end, :id => call_log
    render :content_type => 'text/xml',
      :text => "<Response><Say>Welcome to Nursing Mothers Counsel of Oregon. Connecting you to a counselor now.</Say><Dial action=\"#{url}\">2022856865</Dial></Response>"

  end

  def end
    call_log = CallLog.find(params[:id])
    call_log.to_number = params[:To]
    call_log.from_number = params[:From]
    call_log.from_city = params[:FromCity]
    call_log.from_state = params[:FromState]
    call_log.save
    url = url_for :action => :edit, :id => call_log
    render :content_type => 'text/xml',
      :text => "<Response><Sms to='2022856865' from='(503) 766-5528'>Here is the link to your entry form for #{params[:From]}: #{url}</Sms></Response>"
  end

end
