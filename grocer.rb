
def consolidate_cart(cart)
    new_cart = {} 
    cart.each do |items| 
      items.each do |item, new_pair| 
        new_cart[item] ||= new_pair 
        new_cart[item][:count] ? new_cart[item][:count] += 1 :   
        new_cart[item][:count] = 1 
      end 
    end 
    new_cart 
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item])
      if cart[coupon[:item]][:count] >= coupon[:num]
        itemwithCoupon = "#{coupon[:item]} W/COUPON"
        if cart[itemwithCoupon]
          cart[itemwithCoupon][:count] += coupon[:num]
          cart[coupon[:item]][:count] -= coupon[:num]
        else
          cart[itemwithCoupon] = {}
          cart[itemwithCoupon][:price] = (coupon[:cost] / coupon[:num])
          cart[itemwithCoupon][:clearance] = cart[coupon[:item]][:clearance]
          cart[itemwithCoupon][:count] = coupon[:num]
          cart[coupon[:item]][:count] -= coupon[:num]
        end
      end
    end
  end
  cart

end

def apply_clearance(cart)
  new_cart = cart
  cart.each do |name, hash|
      if hash[:clearance] 
        new_cart[name][:price] = (cart[name][:price] * 0.8).round(2)
      end
  end
  new_cart
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  apply_coupons(new_cart, coupons)
  apply_clearance(new_cart)
  total = 0
  new_cart.each do |name, hash|
    total += (hash[:price] * hash[:count])
  end

  if total >= 100
      total *= 0.9
  end
  total
end

