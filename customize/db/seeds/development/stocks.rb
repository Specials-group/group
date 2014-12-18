# coding: utf-8

%w(ハンバーグ 白米 海藻サラダ).each do |name|
  dish = Dish.find_by_name(name)
  0.upto(4) do |idx|
    Stock.create(
    { dish: dish,
      date: idx.days.from_now,
      stock: idx * 50
    }, without_protection: true)
  end
end
