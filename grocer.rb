require "pry"

def consolidate_cart(cart)
  new_cart = {} 
  cart.each do |item|
    if new_cart[item.keys[0]]
      new_cart[item.keys[0]][:count] +=1
    else
      new_cart[item.keys[0]] = {
        price: item.values[0][:price],
        clearance: item.values[0][:clearance],
        count: 1
      }
  end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        new_name = "#{coupon[:item]} W/COUPON"
        if cart[new_name]
          cart[new_name][:count] += coupon[:num]
        else
          cart[new_name] = {
            count: coupon[:num],
            price: coupon[:cost]/coupon[:num],
            clearance: cart[coupon[:item]][:clearance]
          }
        end
        cart[coupon[:item]][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.map do |item,info|
    if info[:clearance]
      info[:price] = (info[:price]*0.8).round(2)
    #binding.pry
  end
  end 
  cart
end

def checkout(cart, coupons)
  total = 0
  cons_cart = consolidate_cart(cart)
  coup_cons_cart= apply_coupons(cons_cart, coupons)
  coup_cons_clear_cart= apply_clearance(coup_cons_cart)
  coup_cons_clear_cart.each do |item, info|
    total += (info[:price]* info[:count])
  end
  if total >= 100
    total = (total*0.9).round(2)
  end
  total
  #binding.pry
end
