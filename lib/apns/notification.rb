#encoding: utf-8
module APNS
  require 'openssl'

  class Notification
    attr_accessor :device_token, :alert, :badge, :sound, :other, :priority
    attr_accessor :message_identifier, :expiration_date
    attr_accessor :content_available
    
    def initialize(device_token, message)
      self.device_token = device_token
      if message.is_a?(Hash)
        self.alert = message[:alert]
        self.badge = message[:badge]
        self.sound = message[:sound]
        self.other = message[:other]
        self.message_identifier = message[:message_identifier]
        self.content_available = !message[:content_available].nil?
        self.expiration_date = message[:expiration_date]
        self.priority = if self.content_available
          message[:priority] || 5
        else
          message[:priority] || 10
        end
      elsif message.is_a?(String)
        self.alert = message
      else
        raise "Notification needs to have either a hash or string"
      end

      self.message_identifier ||= OpenSSL::Random.random_bytes(4)
    end
        
    def packaged_notification
      pt = self.packaged_token
      pm = self.packaged_message
      pi = self.message_identifier
      pe = (self.expiration_date || 0).to_i
      pr = (self.priority || 10).to_i

      # Each item consist of
      # 1. unsigned char [1 byte] is the item (type) number according to Apple's docs
      # 2. short [big endian, 2 byte] is the size of this item
      # 3. item data, depending on the type fixed or variable length
      data = ''
      data << [1, pt.bytesize, pt].pack("CnA*")
      data << [2, pm.bytesize, pm].pack("CnA*")
      data << [3, pi.bytesize, pi].pack("CnA*")
      data << [4, 4, pe].pack("CnN")
      data << [5, 1, pr].pack("CnC")
      
      data
    end
  
    def packaged_token
      [device_token.gsub(/[\s|<|>]/,'')].pack('H*')
    end
  
    def packaged_message
      aps = {'aps'=> {} }
      aps['aps']['alert'] = self.alert if self.alert
      aps['aps']['badge'] = self.badge if self.badge
      aps['aps']['sound'] = self.sound if self.sound
      aps['aps']['content-available'] = 1 if self.content_available

      aps.merge!(self.other) if self.other

      codes = {
        '\u0410'=>'А', 
        '\u0430'=>'а',
        '\u0411'=>'Б',
        '\u0431'=>'б',
        '\u0412'=>'В',
        '\u0432'=>'в',
        '\u0413'=>'Г',
        '\u0433'=>'г',
        '\u0414'=>'Д',
        '\u0434'=>'д',
        '\u0415'=>'Е',
        '\u0435'=> 'е',
        '\u0401'=> 'Ё',
        '\u0451'=> 'ё',
        '\u0416'=> 'Ж',
        '\u0436'=> 'ж',
        '\u0417'=> 'З',
        '\u0437'=> 'з',
        '\u0418'=> 'И',
        '\u0438'=> 'и',
        '\u0419'=> 'Й',
        '\u0439'=> 'й',
        '\u041a'=> 'К',
        '\u043a'=> 'к',
        '\u041b'=> 'Л',
        '\u043b'=> 'л',
        '\u041c'=> 'М',
        '\u043c'=> 'м',
        '\u041d'=> 'Н',
        '\u043d'=> 'н',
        '\u041e'=> 'О',
        '\u043e'=> 'о',
        '\u041f'=> 'П',
        '\u043f'=> 'п',
        '\u0420'=> 'Р',
        '\u0440'=> 'р',
        '\u0421'=> 'С',
        '\u0441'=> 'с',
        '\u0422'=> 'Т',
        '\u0442'=> 'т',
        '\u0423'=> 'У',
        '\u0443'=> 'у',
        '\u0424'=> 'Ф',
        '\u0444'=> 'ф',
        '\u0425'=> 'Х',
        '\u0445'=> 'х',
        '\u0426'=> 'Ц',
        '\u0446'=> 'ц',
        '\u0427'=> 'Ч',
        '\u0447'=> 'ч',
        '\u0428'=> 'Ш',
        '\u0448'=> 'ш',
        '\u0429'=> 'Щ',
        '\u0449'=> 'щ',
        '\u042a'=> 'Ъ',
        '\u044a'=> 'ъ',
        '\u042d'=> 'Ы',
        '\u044b'=> 'ы',
        '\u042c'=> 'Ь',
        '\u044c'=> 'ь',
        '\u042d'=> 'Э',
        '\u044d'=> 'э',
        '\u042e'=> 'Ю',
        '\u044e'=> 'ю',
        '\u042f'=> 'Я',
        '\u044f' => 'я'
      }
      aps = aps.to_json
      codes.each do |k, v|
        aps = aps.gsub(k, v)
      end
      aps
    end
  end
end
