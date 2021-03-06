class Admin::ItemsController < ApplicationController
#before_action :authenticate_admin!
    
def new
    @item = Item.new(params[:id])
end
    
def index
    @items = Item.all.page(params[:page]).per(10)
end

def show
    @item = Item.find(params[:id])
end

def create
    @item = Item.new(item_params)
    if @item.save
    redirect_to admin_item_path(@item)
    else
    render :show
    end
end

def edit
    @item = Item.find(params[:id])
end

def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
    redirect_to admin_item_path
    else
    render :edit
    end
end

private

def item_params
    params.require(:item).permit(:item_image, :name, :introduction, :genre_id, :price, :is_active)
end
end