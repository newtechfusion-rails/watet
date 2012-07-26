class WebservicesController < ApplicationController
  def users_product_list
    @user = User.find(params[:id])
    @products = Product.where(:user_id=>params[:id])
    @pro_order = @products.find(:all , :order => "order_id")
    respond_to do |format|
      format.html
      format.xml { render :xml => @pro_order }
      format.json  {render :json => @pro_order}
    end
  end

  def users_friend_list
    @users_friend = User.find_by_id(params[:id])
    @fb_id = @users_friend.fbid
    fb_friends = ActiveSupport::JSON.decode(open(URI.encode("https://graph.facebook.com/me/friends?access_token=#{@fb_id}")))['data']
    @friends = fb_friends.collect { |f| AuthService.find_by_provider_and_uid('facebook', f['id']) }.compact
     respond_to do |format|
      format.html
      format.xml { render :xml => @friends }
      format.json  {render :json => @friends}
    end
  end

  def product_edit
    @product_edit = Product.find(params[:id])
      respond_to do |format|
      format.html
      format.xml {render :xml => @product_edit}
      format.json  {render :json => @product_edit}
    end
  end

  def product_delete
    @product_delete =Product.find(params[:id]).destroy
    respond_to do |format|
      format.html
      format.xml {render :xml => @product_delete}
      format.json  {render :json => @product_delete}
    end
  end

  def add_product
    @user = User.find(params[:id])
    @product = @user.products.create(params[:product])
    respond_to do |format|
      format.html
      format.xml {render :xml => @product}
      format.json  {render :json => @product}
    end
  end

def friend_products_list
    @friends_product = Product.find_all_by_user_id(params[:id])
    respond_to do |format|
      format.html
      format.xml {render :xml => @friends_product}
      format.json  {render :json => @friends_product}
    end
end

def friend_product_profile
    @friends_prod_profile = Product.find_by_id(params[:id])
      respond_to do |format|
      format.html
      format.xml {render :xml =>@friends_prod_profile}
      format.json  {render :json => @friends_prod_profile}
    end
end


  def profile_product
    @products_pro = Product.find_by_id(params[:id])
    respond_to do |format|
      format.html
      format.xml {render :xml =>@products_pro}
      format.json  {render :json => @products_pro}
    end
  end

   def product_update
      @product_edit = Product.find(params[:id])
      @product_edit.update_attributes(params[:product])
      @product_edit.save
       respond_to do |format|
      format.html
      format.xml {render :xml => @product_edit}
      format.json  {render :json => @product_edit}
    end
   end
end
