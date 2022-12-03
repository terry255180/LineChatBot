#更新到heroku
git add .
git commit -m "Update"
git push heroku master

#更新Database
heroku run rake db:migrate

#查詢Log檔
heroku logs -t

#備份
	#台北
	return '為您尋找台北大安區附近的交通車：' if received_text.include? '大安區' 
    return '為您尋找台北中正區附近的交通車：' if received_text.include? '中正區' 
    return '為您尋找台北萬華區附近的交通車：' if received_text.include? '萬華區'
    return '為您尋找台北中和區附近的交通車：' if received_text.include? '中和區'
    return '為您尋找台北文山區附近的交通車：' if received_text.include? '文山區'
    return '為您尋找台北信義區附近的交通車：' if received_text.include? '信義區'
    return '為您尋找台北板橋區附近的交通車：' if received_text.include? '板橋區'  
    return '為您尋找台北土城區附近的交通車：' if received_text.include? '土城區'
    return '為您尋找台北三峽區附近的交通車：' if received_text.include? '三峽區'
    return '為您尋找台北新莊區附近的交通車：' if received_text.include? '新莊區'
    return '為您尋找台北樹林區附近的交通車：' if received_text.include? '樹林區'
    return '為您尋找台北汐止區附近的交通車：' if received_text.include? '汐止區' 
    return '為您尋找台北南港區附近的交通車：' if received_text.include? '南港區'  
    return '為您尋找台北新店區附近的交通車：' if received_text.include? '新店區'
    return '為您尋找台北內湖區附近的交通車：' if received_text.include? '內湖區'
    return '為您尋找台北中山區附近的交通車：' if received_text.include? '中山區'
    return '為您尋找台北松山區附近的交通車：' if received_text.include? '松山區'
    return '為您尋找台北大同區附近的交通車：' if received_text.include? '大同區' 
    return '為您尋找台北三重區附近的交通車：' if received_text.include? '三重區'  
    return '為您尋找台北林口區附近的交通車：' if received_text.include? '林口區'
    return '為您尋找台北北投區附近的交通車：' if received_text.include? '北投區'
    return '為您尋找台北士林區附近的交通車：' if received_text.include? '士林區'  
    return '為您尋找台北永和區附近的交通車：' if received_text.include? '永和區'
    #桃園
    return '為您尋找桃園龜山區附近的交通車：' if received_text.include? '龜山區'
    return '為您尋找桃園區附近的交通車：' if received_text.include? '桃園區'
    return '為您尋找桃園龍潭區附近的交通車：' if received_text.include? '龍潭區'
    return '為您尋找桃園八德區附近的交通車：' if received_text.include? '八德區'
    return '為您尋找桃園大溪區附近的交通車：' if received_text.include? '大溪區'
    return '為您尋找桃園鶯歌區附近的交通車：' if received_text.include? '鶯歌區'
    return '為您尋找桃園觀音區附近的交通車：' if received_text.include? '觀音區'
    return '為您尋找桃園中壢區附近的交通車：' if received_text.include? '中壢區'
    return '為您尋找桃園平鎮區附近的交通車：' if received_text.include? '平鎮區'
    return '為您尋找桃園大園區附近的交通車：' if received_text.include? '大園區'  
    #新竹
    return '為您尋找新竹附近的交通車：' if received_text.include? '新竹'  

    ('' "\n" 'GOOGLE評價：★★★★↑(4.4)' "\n" '地址：' "\n" '電話：(03)' "\n" '更多資訊：')


            rand_indexes_snacks = ([('小品屋早餐') , ('逸園廣東粥') , ('香香赤肉焿'), ('魯家大腸麵線'), ('正榮豆花'), ('吉丸飯糰小巴'), ('郭記胡椒餅'),('關西臭豆腐'),('萬丹紅豆餅'),('真順冰城'),('粥董') ] ).shuffle[0,1].join
        return rand_indexes_snacks if received_text.include? '抽小吃' 

        rand_indexes_bento = ([('香廚嚕味便當'),('複園焢肉飯'),('小宓便當'),('瑞香快餐'),('金章燒臘專家')] ).shuffle[0,1].join
        return rand_indexes_bento if received_text.include? '抽便當'

        rand_indexes_noodles = ([('李記北方麵館'),('開封水餃'),('石門山登山口經濟小館'),('品味麵食館'),('華中刀削麵'),('家佳香水餃 '),('客家香小吃'),('龍潭牛肉麵'),('大個子刀削麵'),('轉角豬頭肉麵 '),('曾家牛肉麵'),('東安橋頭牛肉麵'),('淳雞絲涼麵'),('神廚'),('永盛牛肉麵')] ).shuffle[0,1].join
        return rand_indexes_noodles if received_text.include? '抽麵'

        rand_indexes_StirFried_Food = ([('山外山蔬食料理'),('品客小館'),('紅鱻客家小館'),('韓樓'),('亞加珞'),('提緣客家小館'),('采莊庭園複合式餐廳'),('小江活魚'),('美樂地我家小館'),('宋師傅')] ).shuffle[0,1].join
        return rand_indexes_StirFried_Food if received_text.include? '抽熱炒'

        rand_indexes_HotPot = ([('蔡媽媽羊肉爐'),('佳安薑母鴨'),('武讚坊'),('鴻鮮火鍋(原白甘蔗)'),('東昇羊肉爐')] ).shuffle[0,1].join
        return rand_indexes_HotPot if received_text.include? '抽火鍋'

        rand_indexes_Chinese = ([('亨味食堂'),('王朝活魚館'),('老地坊'),('大楊梅鵝莊'),('福站'),('客滿滿'),('紅燈籠農家菜館')] ).shuffle[0,1].join
        return rand_indexes_Chinese if received_text.include? '抽中式'

        rand_indexes_Western_food = ([('知心園'),('晴晴微風小食堂'),('竺園咖啡館'),('景山湖水岸'),('藍月莊園'),('老爸的後花園'),('西堤牛排龍潭店'),('藍海新食感料理 '),('市集巷弄'),('簡單生活')] ).shuffle[0,1].join
        return rand_indexes_Western_food if received_text.include? '抽西餐'

    ('小品屋早餐') , ('逸園廣東粥') , ('香香赤肉焿'), ('魯家大腸麵線'), ('正榮豆花'), ('吉丸飯糰小巴'), ('郭記胡椒餅'),('關西臭豆腐'),('萬丹紅豆餅'),('真順冰城'),('粥董'),
          ('香廚嚕味便當'),('複園焢肉飯'),('小宓便當'),('瑞香快餐'),('金章燒臘專家'), ('李記北方麵館'),('開封水餃'),('石門山登山口經濟小館'),('品味麵食館'),('華中刀削麵'),('家佳香水餃 '),('客家香小吃'),('龍潭牛肉麵'),('大個子刀削麵'),('轉角豬頭肉麵 '),('曾家牛肉麵'),('東安橋頭牛肉麵'),('淳雞絲涼麵'),('神廚'),('永盛牛肉麵'),
          ('山外山蔬食料理'),('品客小館'),('紅鱻客家小館'),('韓樓飲食店'),('亞加珞'),('提緣客家小館'),('逗點 複合式餐廳'),('小江活魚'),('美樂地我家小館'),('宋師傅'),('蔡媽媽羊肉爐'),('佳安薑母鴨'),('武讚坊'),('鴻鮮火鍋(原白甘蔗)'),('東昇羊肉爐'),
          ('亨味食堂'),('王朝活魚館'),('老地坊'),('大楊梅鵝莊'),('客滿滿'),('紅燈籠農家菜館'),('知心園'),('晴晴微風小食堂'),('竺園咖啡館'),('景山湖水岸'),('藍月莊園'),('老爸的後花園'),('西堤牛排龍潭店'),('藍海新食感料理 '),('市集巷弄'),('簡單生活'),('八方雲集')



          #
          
 =begin 
 json_str = {
   "type": "template",
   "altText": "this is a buttons template",
   "template": {
     "type": "buttons",
     "actions": [
       {
         "type": "message",
         "label": "123",
         "text": "123"
       },
       {
         "type": "message",
         "label": "456",
         "text": "456"
       }
     ],
     "title": "HI",
     "text": "22"
   }
 }
 
 json = json_decode(json_str)

   message = {
     json
 }
 =end  


 def keyword_reply(channel_id, received_text)
  message = KeywordMapping.where(channel_id: channel_id, keyword: received_text).last&.message
  return message unless message.nil?
  KeywordMapping.where(keyword: received_text).last&.message
end


  # 查詢教師ID
  def teachername_reply(channel_id, user_id, received_text)
    message = KeywordMapping.where(channel_id: channel_id, keyword: received_text).last&.message
    return message unless message.nil?
    KeywordMapping.where(keyword: received_text.last&.message
  end

  # 傳送userid到 line
  def reply_id_to_line(name_text)
    
    # 設定回覆訊息
    message = {
      type: 'text',
      text: name_text
    } 

    # 傳送訊息
    line.reply_message(reply_token, message)
  end  