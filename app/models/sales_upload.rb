class SalesUpload < ApplicationRecord

  mount_uploader :video, VideoUploader
  serialize :video, JSON # If you use SQLite, add this line.

  def order_sales_relationship
    Order.where(id: SalesUpload.where(:order_id))


  end


  def ordertits
    Order.where(:id) && SalesUpload.where(:order_id)

  end
  #belongs_to :order

  belongs_to :order


end
