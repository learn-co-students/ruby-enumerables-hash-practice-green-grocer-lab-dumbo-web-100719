def consolidate_cart(cart)
  final_hash = {}
  cart.each do |item|
    item_name = item.keys[0]
    if final_hash.has_key?(item_name)
      final_hash[item_name][:count] +=1
    else
      final_hash[item_name] = {
        count: 1,
        price: item[item_name][:price],
        clearance: item[item_name][:clearance]
      }
    end
  end
    final_hash
end
  # code here

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
  item = coupon[:item]
    if cart[item]
      if cart[item][:count] >= coupon[:num] && !cart.has_key?("#{item} W/COUPON")
        cart["#{item} W/COUPON"] = {
          price: coupon[:cost] / coupon[:num],
          clearance: cart[item][:clearance],
          count: coupon[:num]
        }
        cart[item][:count] -= coupon[:num]
        elsif cart[item][:count] >= coupon[:num] && cart.has_key?("#{item} W/COUPON")
          cart["#{item} W/COUPON"][:count] += coupon[:num]
          cart[item][:count] -= coupon[:num]
        end
    end
  end
  cart
  # code here
end

def apply_clearance(cart)
  cart.each do |product_name, stats|
   stats[:price] -= stats[:price] * 0.2 if stats[:clearance]
 end
 cart
  # code here
end

def checkout(cart, coupons)
  hash_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(hash_cart, coupons)
  applied_discount = apply_clearance(applied_coupons)
  total = applied_discount.reduce(0) { |acc, (key, val)| acc += val[:price] * val[:count]}
  total > 100? total * 0.9 : total
  # code here
end
