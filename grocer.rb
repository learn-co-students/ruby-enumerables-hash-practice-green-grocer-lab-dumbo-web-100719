require 'pry'

def consolidate_cart(cart)
  # code here
  cart_hash = {}
  cart.each do |item_hash|
    item_name = item_hash.keys[0]
    item_stats = item_hash.values[0]
    
    
    if cart_hash.has_key?(item_name)
      cart_hash[item_name][:count] += 1 
      
    else
      cart_hash[item_name] =  {
        count:1,
        price: item_stats[:price],
        clearance: item_stats[:clearance]
        
      }
    end
  
    
    
  end 
  cart_hash
  
end



def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    item = coupon[:item]
    coupon_item = "#{item} W/COUPON"
    if cart[item] 
      if cart[item][:count] >= coupon[:num] 
        if !cart.has_key?(coupon_item)
          cart[coupon_item] = { price: coupon[:cost]/ coupon[:num], clearance: cart[item][:clearance] , count: coupon[:num]}

        else 
          cart[coupon_item][:count] += coupon[:num]
        
        end
        cart[item][:count] -= coupon[:num]
      end
      
    end
    
  end
  cart
end



def apply_clearance(cart)
  # code here --- reduce price by 20% for items where clearance =true
  cart.each do |item_name , stats|
    stats[:price] -= stats[:price] * 0.2 if stats[:clearance] 
  
  end
  cart
end



def checkout(cart, coupons)
  # code here
  hash_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(hash_cart, coupons)
  applied_clearance = apply_clearance(applied_coupons)
  
  total = applied_clearance.reduce(0) {|acc,( key, value)| 
  acc += value[:price]* value[:count] }
  
  # Use ternary operator here
  total > 100 ? total * 0.9 : total
  
end
