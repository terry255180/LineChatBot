require 'line/bot'
require 'uri'
require 'json'
require 'net/http'
class KamigoController < ApplicationController
	protect_from_forgery with: :null_session
	
# Line Bot API 物件初始化
def line
    @line ||= Line::Bot::Client.new { |config|
      config.channel_secret = 'dc62e62d81121757e6b1c2b35d347599'
      config.channel_token = 'jDujREv/W8A+A11ibFphMkhtMpxUqWnpnBiMTp+twFzSu2VBufBrzI1w7RJn54MTavPQgLrLNaIgyO5BQX4e4bAVvI8IP7OpSPX/XzCkLbTTUCe4phEYN2CDAjq6kFNKc4qeVEX8Oq+x7PWuyY0E2gdB04t89/1O/w1cDnyilFU='
    }
end	


	
def webhook


  reply_token = params['events'][0]['replyToken']
  #p "======這裡是 reply_token ======"
  #p reply_token 
  #p "============"
  type = params['events'][0]['type']
  #p "======這裡是 type ======"
  #p type 
  #p "============"
   
    # 設定回覆訊息
    
	messages = [{
      type: 'text',
      text: 
'❤️歡迎各位孕媽咪、寶媽咪❤️

加入禾佳藥局中繼站審核群

《本群組沒有任何活動通知》

《請審核加入臉書表單群》

請要審核加入群組媽咪

"直接私訊小幫手媽咪"審核資料

1️⃣媽媽手冊審核資格：
媽媽手冊+預產期內頁+媽媽本人健保卡（請遮/馬身分證字號）
《限有效孕期內》
🆘生產完請用寶寶手冊審核🆘

2️⃣寶寶手冊審核資格：
寶寶手冊+媽媽健保卡
（寶寶手冊需要填寫家長姓名）

找下列其中的一位媽媽審核
@Shu-Lin Wang
@溫寧
@Fanny lee
@周蕎蕎
@010
@王靜靜 WJY鴻利童裝
@Jacqueline

私訊完畢後請在本群組
	tag你私訊的小幫手
 （09:00-22:00）

小幫手也需要休息，有自己的時間，請勿22:00後私訊

 請務必這邊tag小幫手喔，不然您們的私訊我怕被洗到深海裡QQ

《審核完畢就可以退出中繼站嘍》

《審核完畢就可以退出中繼站嘍》

《本群組沒有任何活動通知》

《請審核後加入臉書表單群》

⬇️免費快閃媽媽手冊禮⬇️

⬇️免費快閃寶寶手冊禮⬇️

⬇️都在粉專發文快閃限定⬇️

《各位媽咪記得關注禾佳粉專》

《按讚+訂閱+追蹤我的最愛》

https://www.facebook.com/%E7%A6%BE%E4%BD%B3%E8%97%A5%E5%B1%80-%E6%96%B0%E8%8E%8A%E6%B0%91%E5%AE%89%E8%A5%BF%E8%B7%AF154%E8%99%9F-298842283885133/'
    },{
      type: 'image',
      originalContentUrl: "https://i.imgur.com/Rqe5hTF.jpg",
	  previewImageUrl: "https://i.imgur.com/Rqe5hTF.jpg"
    },{
      type: 'image',
      originalContentUrl: "https://i.imgur.com/UUaHK5E.jpg",
	  previewImageUrl: "https://i.imgur.com/UUaHK5E.jpg"
    },{
      type: 'image',
      originalContentUrl: "https://i.imgur.com/k0khHtd.jpg",
	  previewImageUrl: "https://i.imgur.com/k0khHtd.jpg"
    },{
      type: 'image',
      originalContentUrl: "https://i.imgur.com/wYA4auN.jpg",
	  previewImageUrl: "https://i.imgur.com/wYA4auN.jpg"
    }]
  
  #memberJoined
  if (type == 'memberJoined')	
    # 傳送訊息
    response = line.reply_message(reply_token, messages)
  end
  #when Line::Bot::Event::Message
#	p "join the room"
 # end

  # 講笑話--------------------------
  reply_joke = reply_rand_joke(received_text)
  # 有查到的話 後面的事情就不作了
  unless reply_joke.nil?
    # 傳送訊息到 line
      response = reply_joke_to_line(reply_joke)

    # 回應 200
      head :ok

      return 
  end    
 

    # 傳送訊息到 line
      
      #reply_text = generate_teacher_list(channel_id, user_id, received_text)
      #response = reply_to_line(reply_text)  
      #name_text = teachername_reply(channel_id, user_id, received_text)
      

  # 教機器人功能[教學功能]-------------------------------------
    
    #教師申請
    reply_text = generate_teacher_list(channel_id, user_id, received_text)
    #申請成功回覆到 line
    response = reply_to_line(reply_text) 
    #查詢是否為教師 是的話name_text會有值
    teacher_name = teacherid_search(channel_id, user_id, received_text)
    #response = reply_id_to_line(teacher_name)

    #學習功能 Start

        # 紀錄頻道
        Channel.find_or_create_by(channel_id: channel_id)
  
        # 學說話
          reply_text = learn(channel_id, teacher_name, received_text)
        
        # 關鍵字回覆
          reply_text = keyword_reply(channel_id, received_text) if reply_text.nil?  
    
        # 推齊
          #reply_text = echo2(channel_id, received_text) if reply_text.nil?
    
        # 記錄對話
          #save_to_received(channel_id, received_text)
          #save_to_reply(channel_id,s reply_text)     
    
    #學習功能 end      
         

    # 傳送keyword訊息到 line
    response = reply_to_line(reply_text)

  #------------------------------------------------------------ 
  
  # AI語義辨識轉換成關鍵字並傳送至LINE---------------------------
=begin
    reply_AIanswer = AIanswer_reply(received_text) 
    # 有查到的話 後面的事情就不作了
    unless reply_AIanswer.nil?        
      # 傳送訊息到 line
        #response = reply_AIanswer_to_line(reply_AIanswer)
        reply_question = reply_keyword(reply_AIanswer,received_text)
        response = reply_question_to_line(reply_question)

        reply_keyword = keyword_reply(channel_id, received_text) if reply_question.nil?
        response = reply_to_line(reply_keyword)

        #顯示表單
        show_salary_template() if reply_AIanswer == '薪資相關問題'
        show_welfare_template() if reply_AIanswer == '員工福利'
        show_guideline_template() if reply_AIanswer == '新人指南'
        show_club_template() if reply_AIanswer == '社團'
        show_otherQA_template() if reply_AIanswer == '其他常見問題'
  
      # 回應 200
        head :ok
  
        return 
    end 
=end
  #------------------------------------------------------------  
    
    # 回應 200
    head :ok
  end 


  # 隨機抽取笑話
def reply_rand_joke(received_text)

    rand_indexes_joke = ([('丁丁被肚子被打了一拳變什麼？....答案是ㄎㄎ'),
        ('有一天有一個小女孩，她騎著腳踏車去買東西。買完東西後竟然發現她的腳踏車不見了，她看到警察在那邊，於是說：「警察ㄅㄟㄅㄟ」'"\n"'然後...警察就把她背走了。 >_<'),
        ('有一天有個帥哥走在路上一個阿嬤突然上前搭訕'"\n"'👵「帥哥，你超會搭耶」'"\n"'然後帥哥就冒煙了...'),
        ('有一天螃蟹走在沙灘上，走著走著然後踩到了海星，海星大罵：你瞎子嗎 走路不看路啊！螃蟹回：不是 我是螃蟹'),
        ('Q:哈利波特裡面誰最有主見？'"\n"'A:佛地魔'"\n"'因為他不會被牽著鼻子走'),
        ('Q:把外勞關在家猜一個地名'"\n"'A:索馬利亞'),
        ('警察抓到路人甲闖紅燈問他：[為何闖紅燈你沒有看到紅燈嗎？] 路人回答:我有看到紅燈，但是我沒有看到你'),
        ('Q:哪個女藝人不能代言電鍋?'"\n"'A:范冰冰(飯冰冰)'),
        ('有一天Y跟X走在路上，突然看到U哭得很傷心，Y就走過去問U說：uniqlo'),
        ('有一個國王，奴隸們要幫他做菜，今天國王就跟奴隸們講說我今天要吃煎蛋，然後奴隸們就說可是國王我們不能做煎蛋，國王問為什麼...'"\n"'修煉愛情的悲歡~我們這些「奴隸不煎蛋~~~」'),
        ('有一天軟糖難過的哭了 然後他就變成QQ軟糖了'),
        ('大富翁躺在病床上，對守在身邊等遺產的兒子說：「我覺得我的病有好轉了..」兒子問：「你是怎麼知道的？」大富翁說：「我發現你們的表情一天比一天難過..」'),
        ('Q:有一個rapper要去買水果，他買不到什麼水果?' "\n" 'A:葡萄，因為他永遠只能買到葡萄YO~~'),
        ('Q:為什麼模範生這麼容易被綁架?' "\n" 'A:因為他一臉好綁樣..'),
        ('Q:有一天杯蓋問吸管為什麼我們不能在一起?' "\n" '吸管就說：「因為你是BAD GUY」'),
        ('有一天海底生物們在考試，魚、蝦、烏龜、海馬都來了，在考到一半的時候，老師抓到蝦好像在作弊，老師就說「蝦！你抄誰的？」蝦就回：「我抄蚌的！！」'),
        ('Q:為什麼警察局的女生都不想當最漂亮的嗎？'"\n"'A:因為會被叫局花..'),
        ('Q:陶晶瑩玩抖音猜一個成語？' "\n" 'A:晶瑩剔透(TikTok)')                      
    ]).shuffle[0,1].join
    return rand_indexes_joke if received_text.include? '講笑話'
  end 
  # 回應笑話
def reply_joke_to_line(reply_joke)
    return nil if reply_joke.nil?
    
    # 取得 reply token 
    reply_token = params['events'][0]['replyToken']


    message = {
      type: 'text',
      text: reply_joke
    }

    # 傳送訊息
    line.reply_message(reply_token, message)
  end 

  # AI回覆
=begin  
  def AIanswer_reply(received_text)
    host = "https://westus.api.cognitive.microsoft.com"
    path = "/luis/v2.0/apps/"
    appId = "a2640b7f-9782-4d11-bb88-cee8f3246aa9"
    other = "verbose=true&timezoneOffset=0&subscription-key=980e56af8ddc4e09828e1c2ab583c898&"
    term = received_text
    qs = URI.encode_www_form(
      "q" => term, 
      #"timezoneOffset" => 0, 
      #"verbose" => false, 
      #"spellCheck" => false, 
      #"staging" => false
    )
    uri = URI(host + path + appId + "?" + other + qs)
    

    request = Net::HTTP::Get.new(uri)

    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
    http.request(request)
    end
    #str = JSON::pretty_generate(JSON(response.body))

    data = JSON.parse(response.read_body)
    reply_AIanswer = data["topScoringIntent"]["intent"]
    score = data["topScoringIntent"]["score"]

    #p '------------------------------'
    #p reply_AIanswer
    #p '------------------------------'
    #p score
    #p '------------------------------'
    return 'None' if received_text.length <= 1
    return 'None' if received_text.length > 20
    return 'None' if score < 0.3
    return reply_AIanswer unless received_text.nil?
  end
  # AI回覆顯示到Line
  def reply_AIanswer_to_line(reply_AIanswer)
      return nil if reply_AIanswer.nil?
      
      # 取得 reply token 
      reply_token = params['events'][0]['replyToken']

      message = {
        type: 'text',
		    text: reply_AIanswer

      }
  
      # 傳送訊息
      line.reply_message(reply_token, message)
  end     
=end


  #AI尋找關鍵字並依照設定關鍵字訊息回覆
def reply_keyword(reply_AIanswer,received_text)
    # 學習紀錄表
    keyword_mapping = {
      #圖文選單功能
      '最新消息' => '小幫手Beta版上線溜~',
      '周邊美食' => '',
      '本院位置' => '',
      '院內交通車' => '',
      '給意見' => ''

    }
    # 查表
    #if (reply_AIanswer == 'None' || keyword_mapping[received_text] != nil)
      keyword_mapping[received_text]
    #else
    #  keyword_mapping[reply_AIanswer]
    #end

  end
  

  # 使用者 ID
  def user_id
    source = params['events'][0]['source']
    source['userId']
  end

  # 頻道 ID
  def channel_id
    source = params['events'][0]['source']
    source['groupId'] || source['roomId'] || source['userId']
  end
  
  # 儲存對話
  def save_to_received(channel_id, received_text)
    return if received_text.nil?
    Received.create(channel_id: channel_id, text: received_text)
  end

  # 儲存回應
  def save_to_reply(channel_id, reply_text)
    return if reply_text.nil?
    Reply.create(channel_id: channel_id, text: reply_text)
  end
  
  def echo2(channel_id, received_text)
    # 如果在 channel_id 最近沒人講過 received_text，卡米狗就不回應
    recent_received_texts = Received.where(channel_id: channel_id).last(5)&.pluck(:text)
    return nil unless received_text.in? recent_received_texts
    
    # 如果在 channel_id 卡米狗上一句回應是 received_text，卡米狗就不回應
    last_reply_text = Reply.where(channel_id: channel_id).last&.text
    return nil if last_reply_text == received_text

    received_text
  end

  # 取得對方說的話
  def received_text
    message = params['events'][0]['message']
    message['text'] unless message.nil?
  end

  # 教師名單
  def generate_teacher_list(channel_id, user_id, received_text)
    return nil if channel_id.nil?
    return nil unless (channel_id == 'Ce0f5d81527b4bede4a35b8396bf0293c')  

    #如果開頭不是 申請教學; 就跳出
    return nil unless received_text[0..4] == '申請教學;' 

    teacher_name = received_text[5..-1]

	  KeywordMapping.create(channel_id: '', keyword: user_id, message: teacher_name)
    '加入教師名單～'    

  end

  # 學說話
  def learn(channel_id, teacher_name, received_text)
    #如果開頭不是 資通寶學; 就跳出
    return nil unless received_text[0..4] == '小幫手學;'
    
    received_text = received_text[5..-1]
    semicolon_index = received_text.index(';')

    # 找不到分號就跳出
    return nil if semicolon_index.nil?

    keyword = received_text[0..semicolon_index-1]
    message = received_text[semicolon_index+1..-1]

	  KeywordMapping.create(channel_id: channel_id, keyword: keyword, message: message)
    
    return '我學會了唷～' unless teacher_name.nil?
    return '不好意思~您沒有教學權限>_<' if teacher_name.nil? 
  end

  # 關鍵字回覆
  def keyword_reply(channel_id, received_text)
    message = KeywordMapping.where(channel_id: channel_id, keyword: received_text).last&.message
    return message unless message.nil?
    KeywordMapping.where(keyword: received_text).last&.message
  end

  # 查詢教師ID
  def teacherid_search(channel_id, user_id, received_text)
    message = KeywordMapping.where(channel_id: channel_id, keyword: user_id).last&.message
    return message unless message.nil?
    KeywordMapping.where(keyword: user_id).last&.message
  end 

  # 傳送userid到 line
  def reply_id_to_line(name_text)
    return nil if name_text.nil?

    # 取得 reply token
    reply_token = params['events'][0]['replyToken']

    # 設定回覆訊息
    message = {
      type: 'text',
      text: name_text
    } 

    # 傳送訊息
    line.reply_message(reply_token, message)
  end    


  # 傳送訊息到 line
  def reply_to_line(reply_text)
    return nil if reply_text.nil?
    
    # 取得 reply token
    reply_token = params['events'][0]['replyToken']
    
    # 設定回覆訊息
    message = {
      type: 'text',
      text: reply_text
    } 

    # 傳送訊息
    line.reply_message(reply_token, message)
  end
  
 
  # 回應圖+字
  def reply_question_to_line(reply_question)
	  return nil if reply_question.nil?
	  
    # 取得 reply token 
    reply_token = params['events'][0]['replyToken']

	# message1 = {
		#type: 'text',
		#text: '喵喵喵~'
    #} 

    #message2 = {
    #type: "image",
    #originalContentUrl: reply_textimg,
    #previewImageUrl: reply_textimg
    #}
	 
    #message = [message1,message2]

    #message = {
    #      "type": "location",
    #      "title": "國家中山科學研究院 新新院區",
    #      "address": "325桃園市龍潭區中正路佳安段481號",
    #     "latitude": 24.848135,
    #     "longitude": 121.246690
    #}
	
  # 設定回覆訊息
    message = {
      type: 'text',
      text: reply_question
    }
    
    # 傳送訊息
    line.reply_message(reply_token, message)
  end	
  

  
  
   
end
