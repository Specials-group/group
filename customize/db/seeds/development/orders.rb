#coding: utf-8

status = ["仮予約", "本予約", "済"]

0.upto(9) do |i|
  @order = Order.create(order_date: "2014/12/07",
               member_id: i%3,
               receive_date: Time.mktime(2014, 12, (24 + i / 2), (i + 10), 30),
               lunchbox_id: i%3,
               staple_id: [0,3].sample,
               main_id: [1,4].sample,
               sub_id: [2,5].sample,
               num: i%4+1,
               status: status[i%3]
               )
  select3 = [@order.staple_id, @order.main_id, @order.sub_id]
  select3.each do |sel|
    dishes = Dish.find(sel+1)
    dishes.orders << @order
  end
end
