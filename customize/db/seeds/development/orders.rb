#coding: utf-8

status = ["仮予約", "本予約", "済"]

0.upto(9) do |i|
  Order.create(order_date: "2014/12/07",
               member_id: i%3,
               receive_date: "2014/12/14 18:00",
               lunchbox_id: i%3,
               staple_id: i%5,
               main_id: (i+3)%5,
               sub_id: (i+2)%5,
               num: i%4+1,
               status: status[i%3]
               )
end