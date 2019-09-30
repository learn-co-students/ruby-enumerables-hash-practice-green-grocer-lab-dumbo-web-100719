def consolidate_cart(cart)
 new_hash = {}
 cart.each do |element_hash|
  element_name = element_hash.keys[0]
  element_stats = element_hash.values[0]
  
    if new_hash.has_key?(element_name)
      new_hash[element_name][:count] += 1 
    else
      new_hash[element_name] = {
        count: 1,
        price: element_stats[:price], 
        clearance: element_stats[:clearance],
      }
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
      if cart[item]
        if cart[item][:count] >= coupon[:num] && !cart.has_key?("#{item} W/COUPON")
              cart["#{item} W/COUPON"] = {price: coupon[:cost] / coupon[:num], clearance: cart[item][:clearance], count: coupon[:num]}
              cart[item][:count] -= coupon[:num]
        elsif cart[item][:count] >= coupon[:num] && cart.has_key?("#{item} W/COUPON")
              cart["#{item} W/COUPON"][:count] += coupon[:num]
              cart[item][:count] -= coupon[:num]
        end
        
      end
   end 
   cart
end

def apply_clearance(cart)
  cart.each do |product_name, value|
    value[:price] -= value[:price] * 0.2 if value[:clearance] == true
  end
  cart
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(new_cart, coupons)
  applied_clearance = apply_clearance(applied_coupons)
  total = applied_clearance.reduce(0) { |acc, (key, values)| acc += values[:price] * values[:count] }
  total > 100 ? total * 0.9 : total   
  
end
