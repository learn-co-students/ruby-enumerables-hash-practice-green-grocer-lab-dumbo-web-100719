def consolidate_cart(cart)
#   new_cart = {}
#   cart.each do |items_array| 
#     items_array.each do |item, attribute_hash| 
#       new_cart[item] ||= attribute_hash 
#       new_cart[item][:count] ? new_cart[item][:count] += 1 :   
#       new_cart[item][:count] = 1 
#   end 
# end 
# new_cart 
final_hash = {}
cart.each do |element_hash|
  element_name = element_hash.keys[0]
  element_stats = element_hash.values[0]
  
  if final_hash.has_key?(element_name)
      final_hash[element_name][:count] += 1
  else
    final_hash[element_name] = {
      count: 1,
      price: element_stats[:price],
      clearance: element_stats[:clearance]
      
    }
end
end
final_hash
end


def apply_coupons(cart, coupons)
#   coupons.each do |coupon| 
#     coupon.each do |attribute, value| 
#       name = coupon[:item] 
    
#       if cart[name] && cart[name][:count] >= coupon[:num] 
#         if cart["#{name} W/COUPON"] 
#           cart["#{name} W/COUPON"][:count] += 1 
#         else 
#           cart["#{name} W/COUPON"] = {:price => coupon[:cost], 
#           :clearance => cart[name][:clearance], :count => 1} 
#         end 
  
#       cart[name][:count] -= coupon[:num] 
#     end 
#   end 
# end 
#   cart 

    coupons.each do |coupon|
      item = coupon[:item]
      if cart[item] 
    if  cart[item][:count] >= coupon[:num] && !cart.has_key?("#{item} W/COUPON")
           cart["#{item} W/COUPON"] = {price: coupon[:cost] / coupon[:num], clearance: cart[item][:clearance], count: coupon[:num] }
           cart[item] [:count] -= coupon[:num]
        elsif  cart[item][:count] >= coupon[:num] && cart.has_key?("#{item} W/COUPON")
             cart["#{item} W/COUPON"] [:count] += coupon[:num]
             cart[item] [:count] -= coupon[:num]
             
      end
    end
  end
      cart
end

def apply_clearance(cart)
   cart.each do |item, attribute_hash| 
    if attribute_hash[:clearance] == true 
      attribute_hash[:price] = (attribute_hash[:price] *
      0.8).round(2) 
    end 
  end 
cart 
end

def checkout(cart, coupons)
  hash_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(hash_cart, coupons)
  applied_discount = apply_clearance(applied_coupons)
  total = applied_discount.reduce(0) { |cart, (key, value) | cart += value[:price] * value[:count] }
  total > 100 ? total * 0.9 : total 
  
end
