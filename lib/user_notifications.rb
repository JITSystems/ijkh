# encoding: utf-8
require 'mandrill'
class UserNotifications
	def self.registration(name, email)
    mandrill = Mandrill::API.new 'WT_DRSPlVKfp2sBM-TsZ_w'

    message = {  
		  :subject=> "Регистрация на сервисе АйЖКХ ",  
		  :from_name=> "Сервис АйЖКХ",  
		  :text=>"Регистрация на сервисе АйЖКХ",  
		  :to=>[{  
		      :email=> email,  
		      :name=> name
		  }],  
		  :html=>
		    "<html><h1>Уважаемый пользователь #{name}!</h1>
		    	<p>
		    		Компания АйЖКХ рада, что Вы воспользовались нашим сервисом.<br><br>
		    	  Оплатить услуги можно с помощью <a href='http://izkh.ru'>сайта айжкх.рф</a><br>
		    	  <img src='https://izkh.ru/images/web.png' width='370' height='100'/><br>
            или мобильного приложения на iOS<br><br>
		    	  Для загрузки iOS-приложения перейдите по ссылке или воспользуйтесь QR-кодом:<br>
		        <a href='http://itunes.apple.com/ru/app/servis-ajzkh/id649860222?mt=8'>
              <img src='https://izkh.ru/images/apple.png' width='90' height='90' />
            </a>
		        <img src='https://izkh.ru/images/qr.png' width='90' height='90'/>
		        <ul>
		    	   <li>узнавайте и оплачивайте задолженность за услуги ЖКХ</li>
		    	   <li>передавайте данные Ваших счетчиков в адрес своего ТСЖ или УК</li>
		    	   <li>оплачивайте другие услуги: Интернет, ТВ, домофон, охранные услуги</li>
		        </ul><br><br>
		    	  Посмотреть полный список поставщиков можно на нашем <a href='http://izkh.ru/catalog'>сайте айжкх.рф</a><br><br>
		    	  Перейдите по ссылке, чтобы посмотреть видеоинструкцию по использованию мобильного приложения сервиса АйЖКХ<br>
		    	  <a href='http://www.youtube.com/watch?feature=player_embedded&v=nUxI8cANm-g'>
              <img src='https://izkh.ru/images/youtube.png' width='90' height='90' />
            </a><br><br>
            Не нашли своего поставщика? <a href='http://izkh.ru/request_for_vendor'>Напишите нам</a><br><br>
            Присоединяйтесь к нам в соц.сетях<br><br>
            <a href='https://vk.com/izkh_official'>
              <img src='https://izkh.ru/images/vk.png' />
            </a>
            <a href='https://www.facebook.com/pages/%D0%9E%D0%9E%D0%9E-%D0%90%D0%B9%D0%96%D0%9A%D0%A5/730802226933352'>
              <img src='https://izkh.ru/images/f.png' />
            </a>
            <a href='https://twitter.com/izkh_official'>
              <img src='https://izkh.ru/images/t.png' />
            </a>
            <i>
              Вы получили это сообщение, потому что являетесь клиентом АйЖКХ.<br><br>
              Безопасность операций соответствует требованиям международного стандарта PCI DSS.<br>
              Услугу по переводу денежных средств оказывает ОАО АКБ \"Банк Москвы\" лицензия Банка России №2748.<br>
              Полный список тарифов и поставщиков  на сайте <a href='http://izkh.ru'>айжкх.рф</a>
            </i>
          </p>
		    </html>",
		  :from_email=>"out@izkh.ru"
		} 
	  mandrill.messages.send message
  end

  def self.new_vendors(name, email)
    vendors_title  = ""
    Vendor.where("created_at > ?", 31.days.ago).each {|v| vendors_title += "<li>#{v.title}</li>" }
    mandrill = Mandrill::API.new 'WT_DRSPlVKfp2sBM-TsZ_w'
    message = {  
      :subject=> "Новые поставщики услуг",  
      :from_name=> "Сервис АйЖКХ",  
      :to=>[{  
          :email=> email,  
          :name=> name
      }],  
      :html=>
        "<html><h1>Уважаемый пользователь #{name}!</h1>
          <p>
            Обращаем Ваше внимание на то, что у нас появились новые поставщики услуг:
            <ul>
              #{vendors_title}
            </ul>
            Посмотреть полный список поставщиков можно на нашем <a href='http://izkh.ru/catalog'>сайте айжкх.рф</a><br><br>
            Новые возможности нашего сервиса:<br>
            <a href='http://izkh.ru/precinct'>Мобильный участковый.</a> Найди телефон и фамилию своего участкового по адресу проживания.<br>
            <a href='http://izkh.ru/freelancers'>Частные услуги.</a> Нужен электрик, сантехник или каменщик? Найди в нашем сервисе, посмотри его рейтинг и отзывы от других пользователей сервиса.<br><br>
            Не нашли своего поставщика? <a href='http://izkh.ru/request_for_vendor'>Напишите нам</a>
            Присоединяйтесь к нам в соц.сетях<br><br>
            <a href='https://vk.com/izkh_official'>
              <img src='https://izkh.ru/images/vk.png' />
            </a>
            <a href='https://www.facebook.com/pages/%D0%9E%D0%9E%D0%9E-%D0%90%D0%B9%D0%96%D0%9A%D0%A5/730802226933352'>
              <img src='https://izkh.ru/images/f.png' />
            </a>
            <a href='https://twitter.com/izkh_official'>
              <img src='https://izkh.ru/images/t.png' />
            </a><br><br>
            <i>Вы получили это сообщение, потому что являетесь клиентом АйЖКХ.<br><br>
              Безопасность операций соответствует требованиям международного стандарта PCI DSS.<br>
              Услугу по переводу денежных средств оказывает ОАО АКБ \"Банк Москвы\" лицензия Банка России №2748.<br>
              Полный список тарифов и поставщиков  на сайте <a href='http://izkh.ru'>айжкх.рф</a>
            </i>
          </p>
        </html>",
      :from_email=>"out@izkh.ru"
    } 
    mandrill.messages.send message
  end

  def self.successful_payment(summa, recipient, account, name, email)
    mandrill = Mandrill::API.new 'WT_DRSPlVKfp2sBM-TsZ_w'
    message = {  
      :subject=> "Успешная оплата",  
      :from_name=> "Сервис АйЖКХ",   
      :to=>[{  
          :email=> email,  
          :name=> name
      }],  
      :html=>
        "<html><h1>Уважаемый пользователь #{name}!</h1>
          <p>
            Поздравляем! Вы успешно оплатили услуги с помощью сервиса АйЖКХ.<br><br>
            #{summa}, #{recipient}, #{account}.<br><br>
            Посмотреть полный список поставщиков можно на нашем <a href='http://izkh.ru/catalog'>сайте айжкх.рф</a><br><br>
            Новые возможности нашего сервиса:<br>
            <a href='http://izkh.ru/precinct'>Мобильный участковый.</a> Найди телефон и фамилию своего участкового по адресу проживания.<br>
            <a href='http://izkh.ru/freelancers'>Частные услуги.</a> Нужен электрик, сантехник или каменщик? Найди в нашем сервисе, посмотри его рейтинг и отзывы от других пользователей сервиса.<br><br>
            Не нашли своего поставщика? <a href='http://izkh.ru/request_for_vendor'>Напишите нам</a><br><br>
            Присоединяйтесь к нам в соц.сетях<br><br>
            <a href='https://vk.com/izkh_official'>
              <img src='https://izkh.ru/images/vk.png' />
            </a>
            <a href='https://www.facebook.com/pages/%D0%9E%D0%9E%D0%9E-%D0%90%D0%B9%D0%96%D0%9A%D0%A5/730802226933352'>
              <img src='https://izkh.ru/images/f.png' />
            </a>
            <a href='https://twitter.com/izkh_official'>
              <img src='https://izkh.ru/images/t.png' />
            </a><br><br>
            <i>
              Вы получили это сообщение, потому что являетесь клиентом АйЖКХ.<br><br>
              Безопасность операций соответствует требованиям международного стандарта PCI DSS.<br>
              Услугу по переводу денежных средств оказывает ОАО АКБ \"Банк Москвы\" лицензия Банка России №2748.<br>
              Полный список тарифов и поставщиков  на сайте <a href='http://izkh.ru'>айжкх.рф</a>
            </i>
          </p>
        </html>",
      :from_email=>"out@izkh.ru"
    } 
    mandrill.messages.send message
  end

  def self.no_payment(name, email)
    vendors_title  = ""
    Vendor.where("created_at > ?", 31.days.ago).each {|v| vendors_title += "<li>#{v.title}</li>" }
    mandrill = Mandrill::API.new 'WT_DRSPlVKfp2sBM-TsZ_w'
    message = {  
      :subject=> "Сервис АйЖКХ",  
      :from_name=> "Сервис АйЖКХ ",  
      :to=>[{  
          :email=> email,  
          :name=> name
      }],  
      :html=>
        "<html><h1>Уважаемый пользователь #{name}!</h1>
          <p>
            Мы заметили, что Вы зарегистрировались в нашем сервисе и не совершили ни одного платежа. Если Вам требуется помощь специалиста - звоните:
            <table>
            <tbody>            
            <tr>
              <td rowspan='2'>
                <img src='https://izkh.ru/images/phone.png' width='90' height='90'/>
              </td>
            </tr>
            <tr>
              <td>
                (846)373-64-10<br><br>
                (846)373-64-11
              </td>
            </tr>
            </table>
            </tbody><br><br>
            Оплатить услуги можно с помощью <a href='http://izkh.ru'>сайта айжкх.рф</a><br>
            <img src='https://izkh.ru/images/web.png' width='370' height='100'/><br>
            или мобильного приложения на iOS<br><br>
            Для загрузки iOS-приложения перейдите по ссылке или воспользуйтесь QR-кодом:<br>
            <a href='http://itunes.apple.com/ru/app/servis-ajzkh/id649860222?mt=8'>
              <img src='https://izkh.ru/images/apple.png' width='90' height='90' />
            </a>
            <img src='https://izkh.ru/images/qr.png' width='90' height='90'/>
          <ul>
            <li>узнавайте и оплачивайте задолженность за услуги ЖКХ</li>
            <li>передавайте данные Ваших счетчиков в адрес своего ТСЖ или УК</li>
            <li>оплачивайте другие услуги: Интернет, ТВ, домофон, охранные услуги</li>
          </ul>
          Рады сообщить, что добавились новые поставщики услуг:
            <ul>
              #{vendors_title}
            </ul>
          Посмотреть полный список поставщиков можно на нашем <a href='http://izkh.ru/catalog'>сайте айжкх.рф</a><br><br>
          Не нашли своего поставщика? <a href='http://izkh.ru/request_for_vendor'>Напишите нам</a><br><br>
          Присоединяйтесь к нам в соц.сетях<br><br>
          <a href='https://vk.com/izkh_official'>
            <img src='https://izkh.ru/images/vk.png' />
          </a>
          <a href='https://www.facebook.com/pages/%D0%9E%D0%9E%D0%9E-%D0%90%D0%B9%D0%96%D0%9A%D0%A5/730802226933352'>
            <img src='https://izkh.ru/images/f.png' />
          </a>
          <a href='https://twitter.com/izkh_official'>
            <img src='https://izkh.ru/images/t.png' />
          </a><br><br>
          <i>
            Вы получили это сообщение, потому что являетесь клиентом АйЖКХ.<br><br>
            Безопасность операций соответствует требованиям международного стандарта PCI DSS.<br>
            Услугу по переводу денежных средств оказывает ОАО АКБ \"Банк Москвы\" лицензия Банка России №2748.<br>
            Полный список тарифов и поставщиков  на сайте <a href='http://izkh.ru'>айжкх.рф</a>
          </i>
        </html>",
      :from_email=>"out@izkh.ru"
    } 
    mandrill.messages.send message
  end
end