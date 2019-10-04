require 'pry'

def consolidate_cart(cart)
  new_cart = {}
  cart.each do |item|
    if new_cart[item.keys[0]]
      new_cart[item.keys[0]][:count] += 1
    else
      new_cart[item.keys[0]] = {
        count: 1,
        price: item.values[0][:price],
        clearance: item.values[0][:clearance]
      }
   # binding.pry
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    if cart[item] 
      if cart[item][:count] >= coupon[:num] && !cart["#{item} W/COUPON"]
      cart["#{item} W/COUPON"] = {price: coupon[:cost] / coupon[:num], clearance: cart[item][:clearance], count: coupon[:num]}
      cart[item][:count] -= coupon[:num]
      elsif cart[item][:count] >= coupon[:num] && cart["#{item} W/COUPON"]
      cart["#{item} W/COUPON"][:count] += coupon[:num]
      cart[item][:count] -= coupon[:num]
    end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.keys.each do |item|
    if cart[item][:clearance]
      cart[item][:price] = (cart[item][:price]*0.80).round(2)
    end 
  end
  cart
end

def checkout(cart, coupons)
  con_cart = consolidate_cart(cart)
  coup_cart = apply_coupons(con_cart, coupons)
  dis_cart = apply_clearance(coup_cart)
  total = dis_cart.reduce(0) { |acc, (key, value)| acc += value[:price] * value[:count] }
  total > 100.00 ? (total * 0.90).round : total
end

#rejected code:

#new_cart = Hash[cart.map {|key, value| [key, value]}]
  #puts new_cart
    #cart.map do |item| num * 2 
  #
  #end
  
  # h = { "a" => 100, "b" => 200 }
  # cart.map{ |item| num * 2 }
  # h3 = Hash[a3.map {|key, value| [key, value]}]