class ProductsController < ApplicationController
	protect_from_forgery :only => [:update, :destroy]

  def create
    @product_order = Product.last
    @user = User.find(params[:user_id])
    @product = @user.products.create(params[:product])
    flash[:notice] = "Your wish is successfully created."
    redirect_to user_path(@user)
 end

 def edit
   @user = User.find(session[:user_id])
   @product_edit = @user.products.find(params[:id])
   end

 def update
    if params[:update]
      @product_edit = Product.find(params[:update])
      @product_edit.update_attributes(params[:product])
      @product_edit.lat = params[:product][:lat]
      @product_edit.lng = params[:product][:lng]
      @user_id = params[:product][:user_id]
      @product_edit.save
      flash[:notice] = "Your wish is successfully created."
      redirect_to :controller=> "users", :action =>"show",:id=>@user_id
    end
 end

 def destroy
    @product =Product.find(params[:id])
    begin
    @photos_delete = Photo.where(:product_id=>params[:id])
    @photos_delete.each do |photos_delete|
           photos_delete.destroy
            end
          rescue => e
    end
    @product.destroy
    flash[:notice] = "Your wish is successfully deleted."
    redirect_to  :controller=>"users",:action=>"show",:id=>session[:user_id]
	end
	
 def sendlist
    @user = User.find(params[:user_id])
    @product_list = Product.find_all_by_user_id(@user.id)
    @product_list.each do |product_list| 
    @cl = product_list.name
    @id = product_list.id
    end
    ListMailer.share_list_email(@user, params[:email], @cl ,@id).deliver
    flash[:notice] = "Email is succesfully send"
    redirect_to user_path(@user)
 end

 def add_wish
 end

 def ordering_list
    if params[:id]
        @pro_id = params[:id].gsub("listItem[]=", "")
        @pro_id1 = @pro_id.gsub("&", ",")
        @pro_id3 = @pro_id1.split(",")
         @count = 0
        @pro_id3.each do |value|
            @pro = Product.find_by_id(value)
            pro = @pro.order_id
            @pro.update_attributes(:order_id => @count=@count+1)
        end
    end
    render :layout=>"blanck"
  end

  def terms_and_conditions
    if params[:users][:id]
      @trems = User.find_by_id(params[:users][:id])
      @trems.update_attributes(params[:users])
      @trems.terms = params[:users][:terms]
      redirect_to :action => "show", :controller => "users" , :id=>session[:user_id]
    end
  end

  def contact_us
  end

  def contact_us_user
    @email_contect = ListMailer.share_contact_email(params[:products][:message],params[:products][:name],params[:products][:subject],params[:products][:email]).deliver
    flash[:notice] = "Your contect information is sucessfully send!!!!!!!"
    redirect_to :action => "contact_us", :controller => "products"
  end


end
