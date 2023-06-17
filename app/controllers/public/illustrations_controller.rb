class Public::IllustrationsController < ApplicationController

  def show
    @illustration = Illustration.find(params[:id])
    @customer = Customer.find(@illustration.customer_id)
    @post_comment = PostComment.new
  end

  def newly_arrived
    @illustrations = Illustration.all
    @customer = current_customer
    @illustration = Illustration.new
  end

  def new
    @illustration = Illustration.new
  end

  def create
    @illustration = Illustration.new(illustration_params)
      tag_list = params[:illustration][:tag_name].split(nil)
    @illustration.illustration_image.attach(params[:illustration][:illustration_image])
    @illustration.customer_id = current_customer.id
    if @illustration.save
      @illustration.save_illustrations(tag_list)
      redirect_to illustration_path(@illustration), notice: "You have created book successfully."
    else
      flash.now[:alert] = '投稿に失敗しました'
      @illustrations = Illustration.all
      @customer = current_customer
      render :index
    end
  end

  def edit
    @illustration = Illustration.find(params[:id])
  end

  def update
    @illustration = Illustration.find(params[:id])
    if @illustration.update(illustration_params)
      redirect_to illustration_path(@illustration), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @illustration = Illustration.find(params[:id])
    @illustration.destroy
    redirect_to illustrations_path
  end

  private

  def illustration_params
    params.require(:illustration).permit(:title, :body, :illustration_image)
  end

  private
    def customer_params
      params.require(:customer).permit(:name, :introduction, :image)
    end


end
