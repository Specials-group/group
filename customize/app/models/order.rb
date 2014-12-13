class Order < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :id, :order_date, :member_id, :receive_date, :lunchbox_id, :staple_id, :main_id, :sub_id, :num, :status
end
