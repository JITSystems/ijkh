#encoding: utf-8

class WebInterface::TitlePageController < WebInterfaceController
	skip_before_filter :require_current_user
	layout 'title_page'

	def show
		@news_items =[
		{id: 1, title: "Совещание с руководителями управляющих компаний Сов...", body: "02.12.2013 г. в здании Администрации Советского рай...", published: nil, created_at: "2013-12-02 07:32:28", updated_at: "2013-12-02 12:25:43"},
		{id: 2, title: "Привлечение новых поставщиков услуг", body: "Подписано партнерское соглашение с ЗАО \"ГЛОБАЛ ТЕЛЕ...", published: nil, created_at: "2013-12-02 07:33:59", updated_at: "2013-12-02 12:26:05"},
		{id: 3, title: "Привлечение новых поставщиков услуг", body: "Подписано Партнерское соглашение с ТСЖ \"Стара Загор...", published: nil, created_at: "2013-12-02 07:42:15", updated_at: "2013-12-02 12:26:22"},
		{id: 4, title: "Без комиссии!", body: "Теперь клиенты ООО \"Дельта-Самара\" и ООО \"Дельта-То...", published: nil, created_at: "2013-12-02 12:26:55", updated_at: "2013-12-02 12:26:55"},
		{id: 5, title: "Новый функционал.", body: "Появился новый функционал для клиентов ООО \"Сбыт-Эн...", published: nil, created_at: "2013-12-02 12:27:23", updated_at: "2013-12-02 12:27:23"},
		{id: 6, title: "Привлечение новых поставщиков услуг", body: "Подписаны договора с ТСЖ \"Железнодорожный №85\" и ЖС...", published: nil, created_at: "2013-12-02 12:27:38", updated_at: "2013-12-02 12:27:38"},
		{id: 7, title: "Справочник участковых", body: "Не знаете, кто ваш участковый инспектор и как его н...", published: nil, created_at: "2013-12-02 12:27:58", updated_at: "2013-12-02 12:27:52"}]
	end
end