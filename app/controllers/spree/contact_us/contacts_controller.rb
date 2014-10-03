class Spree::ContactUs::ContactsController < Spree::StoreController

  helper "spree/products"
  def create
    @contact = Spree::ContactUs::Contact.new(params[:contact_us_contact])

    logger.info @contact
    logger.info @contact.last_name.nil?
    logger.info @contact.last_name.empty?
    if (@contact.last_name.nil? or @contact.last_name.empty?)
      if @contact.save
        if Spree::ContactUs::Config.contact_tracking_message.present?
          flash[:contact_tracking] = Spree::ContactUs::Config.contact_tracking_message
        end
        redirect_to("#{spree.root_path}#contact", :notice => t('spree.contact_us.notices.success'))
      else
        render :new
      end
    else
      render :new
    end
  end

  def new
    @contact = Spree::ContactUs::Contact.new
  end

  private

  def accurate_title
    t('contact_us')
  end

end
