class YandexMoney

  def initialize(request, requestDatetime, md5, orderNumber, customerNumber, orderSumAmount, invoiceId)
    p '------------------------------------------------------------------------------------------------'
    p @request = request
    p @requestDatetime = requestDatetime
    p "------------check_md5------------"
    p @md5 = md5
    p @orderNumber = orderNumber
    p @customerNumber = customerNumber
    p @orderSumAmount = orderSumAmount
    # @orderSumCurrencyPaycash = orderSumCurrencyPaycash
    p @invoiceId = invoiceId
    @shopId = "15196"
    @code = 1000
  end

  def notify
    if check_md5
      recipe = Recipe.find(@orderNumber)
      if @request == 'checkOrder' && recipe
        recipe.update_attributes!(total: @orderSumAmount) if @orderSumAmount != recipe.total
        @code = 0
      elsif @request == 'checkOrder' && !recipe then @code = 100
      elsif @request == 'paymentAviso'
        @code = 0
        payment_history_create_successful
      end
    else
      @code = 1
    end
    { performedDatetime: Time.now, code: @code, invoiceId: @invoiceId, shopId: @shopId, orderSumAmount: @orderSumAmount }.to_xml(:root => @request + 'Response')
  end

  private

  def check_md5
    @md5 == 'Sum0Zozilock8Qzhsoli'
  end

  def payment_aviso_params
    recipe = Recipe.find(@orderNumber)
    if recipe
      service_id = recipe.service_id
    else
      service_id = 0
    end

    payment_history_params = {
      po_date_time:       @requestDatetime, 
      po_transaction_id:    @invoiceId.to_i, 
      recipe_id:        @orderNumber.to_i, 
      amount:         @orderSumAmount, 
      currency:         "", 
      card_holder:      "", 
      card_number:      "", 
      country:        "", 
      city:           "", 
      eci:          "",
      user_id:        @customerNumber.to_i,
      payment_type:       "1",
      service_id:       service_id, 
      status:         1
    }

    return payment_history_params
  end

  def payment_history_create_successful
    payment_history_params = payment_aviso_params
    payment_history = PaymentHistory.new(payment_history_params)
    payment_history.save

    service_id = payment_history_params[:service_id]
    if service_id != 0
      service = Service.find(service_id)
      if service && service.vendor_id.to_i == 121
        amount = Recipe.find(payment_history_params[:recipe_id]).amount
        GtPaymentWorker.perform_async(service_id, payment_history_params[:recipe_id].to_i, amount)
      #elsif service && service.vendor_id.to_i == 16
        #JtPaymentWorker.perform_async(params[:user_id])
      elsif service && service.vendor_id.to_i == 135
        amount = Recipe.find(payment_history_params[:recipe_id]).amount
        SlPaymentWorker.perform_async(service_id, payment_history_params[:recipe_id].to_i, amount) 
      elsif service && service.vendor_id.to_i == 165
        amount = Recipe.find(payment_history_params[:recipe_id]).amount
        CraftSPaymentWorker.perform_async(service_id, payment_history_params[:recipe_id].to_i, amount)
      elsif service && service.vendor_id.to_i == 144

        recipe_id = payment_history_params[:recipe_id]

        # amount = Recipe.find(recipe_id).amount

        user_id = service.user.id
        freelancer = FreelanceInterface::Freelancer.where(recipe_id: recipe_id).first
        top_ten = FreelanceInterface::TopTenFreelancer.where(recipe_id: recipe_id).first
        top_four = FreelanceInterface::TopFourFreelancer.where(recipe_id: recipe_id).first

        if freelancer
          unpublish_at = Date.current() + freelancer.number_of_month.to_i.month
          freelancer.update_attributes!(unpublish_at: unpublish_at)
          if top_ten
            unpublish_at = Date.current() + top_ten.number_of_month.to_i.month
            top_ten.update_attributes!(unpublish_at: unpublish_at)
          end
        else 
          if top_ten
            unpublish_at = Date.current() + top_ten.number_of_month.to_i.month
            top_ten.update_attributes!(unpublish_at: unpublish_at)
          else
            if top_four
              unpublish_at = Date.current() + top_four.number_of_month.to_i.month
              top_four.update_attributes!(unpublish_at: unpublish_at)             
            end
          end
        end
      
      end
    end

    service_id = Recipe.get_service_id payment_history_params[:recipe_id]

    recipe = Recipe.find(payment_history_params[:recipe_id])

    account = Account.update_account_amount service_id, recipe.amount, recipe.amount # recipe.amount only once!!!

    if account[:amount] <= 0
      
      switch_status_params = {
        account_id: account[:account_id],
        status: 1,
        user_id: @customerNumber.to_i
      }

      Account.switch_status switch_status_params

      user = User.find(@customerNumber.to_i)
    #   NotificationsSuccessfulPaymentWorker.perform_async(recipe.total, service.title, service.user_account, user.first_name, user.email)
    else
      switch_status_params = {
        account_id: account[:account_id],
        status: -1
      }

      Account.switch_status switch_status_params
    end
  end

end