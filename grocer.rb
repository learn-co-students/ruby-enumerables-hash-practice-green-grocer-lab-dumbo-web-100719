require "pry"
def consolidate_cart(cart)
  new_hash = {}

  cart.each do |elem|
  key_in_hash = elem.keys[0]
  value_in_hash = elem.values[0]

    if new_hash[key_in_hash]
        #value_in_hash[:count] += 1
        new_hash[key_in_hash][:count] += 1
    else
      new_hash[key_in_hash] = {
        price: value_in_hash[:price],
        clearance: value_in_hash[:clearance],
        count: 1
      }
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)

  coupons.each do |coupon|
  item = coupon[:item]
    if cart[:item] && cart[:item][:count] => coupon[:num] && !cart["#{item} w/COUPON"]
        cart["#{item} w/COUPON"] = {:price => coupon[:cost] / coupon[:num], :clearance => cart[item][:clearance], :count => coupon[:num]}
        cart[:item][:count] -= coupon[:num]
    elsif coupon[:num] && cart["#{item} w/COUPON"]
          cart["#{item} w/COUPON"][:count] += coupon[:num]
          cart[:item][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
