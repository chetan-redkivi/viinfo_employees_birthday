class CustomMessagesController < ApplicationController
  # GET /custom_messages
  # GET /custom_messages.json
  def index
    @custom_messages = CustomMessage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @custom_messages }
    end
  end

  # GET /custom_messages/1
  # GET /custom_messages/1.json
  def show
    @custom_message = CustomMessage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @custom_message }
    end
  end

  # GET /custom_messages/new
  # GET /custom_messages/new.json
  def new
    @custom_message = CustomMessage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @custom_message }
    end
  end

  # GET /custom_messages/1/edit
  def edit
    @custom_message = CustomMessage.find(params[:id])
  end

  # POST /custom_messages
  # POST /custom_messages.json
  def create
    no_message_available = CustomMessage.find_by_friend_uid(params[:custom_message]["friend_uid"]).nil?
    if no_message_available
      @custom_message = CustomMessage.new(params[:custom_message])

        if @custom_message.save
          flash[:notice] = "Your message has been successfully added"
          redirect_to root_url
        end
    else
      @custom_message = CustomMessage.find_by_friend_uid(params[:custom_message]["friend_uid"])
      if @custom_message.update_attributes(params[:custom_message])
        flash[:notice] = "Your message has been updated successfully"
        redirect_to root_url
      else
        flash[:error] = "We are sorry, please update again."
      end
    end
  end

  # PUT /custom_messages/1
  # PUT /custom_messages/1.json
  def update
    @custom_message = CustomMessage.find_by_friend_uid(params[:custom_message]["friend_uid"])

    respond_to do |format|
      if @custom_message.update_attributes(params[:custom_message])
        format.html { redirect_to @custom_message, notice: 'Custom message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @custom_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /custom_messages/1
  # DELETE /custom_messages/1.json
  def destroy
    @custom_message = CustomMessage.find(params[:id])
    @custom_message.destroy
    redirect_to root_url
  end
end
