require 'line/bot'
class PushMessagesController < ApplicationController
  before_action :authenticate_user!

  # GET /push_messages/new
  def new
  end

  # POST /push_messages
  def create
    text = params[:text]
    Channel.all.each do |channel|
      push_to_line(channel.channel_id, text)
    end
    redirect_to '/push_messages/new'
  end

  # 傳送訊息到 line
  def push_to_line(channel_id, text)
    return nil if channel_id.nil? or text.nil?
    
    # 設定回覆訊息
    message = {
      type: 'text',
      text: text
    } 

    # 傳送訊息
    line.push_message(channel_id, message)
  end

  # Line Bot API 物件初始化
  def line
    @line ||= Line::Bot::Client.new { |config|
      config.channel_secret = 'f667670b8ed22186be46fd7177a174b8'
      config.channel_token = 'ilen02IJbGbKjVjChdjiGuP5wbEDEjEWZAeP6IT/465Zjtnh91GR58J+SANkKWxiET4u39Y6l/GwafrXS5yBRXZC3djPUIdDTZfoNcSOGZu/baxQ0+sIBsVmXg+c37yDy0CZPJ+/xJzbBrqevhSjNgdB04t89/1O/w1cDnyilFU='
    }
  end
end