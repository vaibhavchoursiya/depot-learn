class StoreController < ApplicationController
  def index
    # @page_title = "Index"
    @time = Time.now
    @products = Product.order(:title)
  end
end
