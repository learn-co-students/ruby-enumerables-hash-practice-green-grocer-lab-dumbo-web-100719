def consolidate_cart(cart)
  returned_hash = {}
  cart.each do |item_hash|
    item_hash.each do |key, value|
      if !returned_hash[key]
        returned_hash[key] = value
        returned_hash[key][:count] = 0
      end
      returned_hash[key][:count] += 1
    end
  end
  returned_hash
end

def apply_coupons(cart, coupons)
  applied_coupon_hash = {}
  cart.each do |item_name, det_hash|
    coupons.each do |coupon_hash|
      if item_name == coupon_hash[:item] && det_hash[:count] >= coupon_hash[:num]
        
        det_hash[:count] = det_hash[:count] - coupon_hash[:num]
        
        applied_coupon_name = "#{coupon_hash[:item]} W/COUPON"
        
          if !applied_coupon_hash[applied_coupon_name]
            
        applied_coupon_hash[applied_coupon_name] = {
          :price => coupon_hash[:cost] / coupon_hash[:num],
          :count => coupon_hash[:num],
          :clearance => det_hash[:clearance]
        }
          else 
      applied_coupon_hash[applied_coupon_name][:count] += coupon_hash[:num]
          end
          #p applied_coupon_hash
      end
    end
  end
  cart.merge(applied_coupon_hash)
end

def apply_clearance(cart)
  clearance_cart = {}
  cart.each do |(item, item_info)|
    if item_info[:clearance]
      item_info[:price] = (item_info[:price] * 0.8).round(3)
    end
    clearance_cart[item] = item_info
  end
  clearance_cart
end

def checkout(cart, coupons)
  cons_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(cons_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  
  final_price = clearance_cart.reduce(0) do |memo, (key, value)|
    memo += value[:price] * value[:count]
    memo
  end
              
if final_price > 100
  final_price = (final_price * 0.9).round(2)
end

final_price
end
