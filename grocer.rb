def consolidate_cart(cart)
  # code here
  new_cart = {}
  cart.each do |item|
    item_name = item.keys[0]
    if new_cart[item_name]
      new_cart[item_name][:count] += 1
    else 
      new_cart[item_name] = item[item_name]
      new_cart[item_name][:count] = 1
    end
  end
  return new_cart
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |discount|
    if cart.keys.include? discount[:item]
      if cart[discount[:item]][:count] >= discount[:num]
        separated_discount_item = "#{discount[:item]} W/COUPON"
        if cart[separated_discount_item] 
          cart[separated_discount_item][:count] += discount[:num]
        else
          cart[separated_discount_item] ={
            :price => discount[:cost]/discount[:num],
            :clearance => cart[discount[:item]][:clearance],
            :count => discount[:num]
          }
          end
         cart[discount[:item]][:count] -= discount[:num]
        end
      end
    end
    return cart
end

def apply_clearance(cart)
  # code here
  cart.each do |key, value|
    if value[:clearance] == true
      value[:price] = (value[:price] * 0.8).round(1)
    end
  end
  return cart
end

def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  applied_coupons_cart = apply_coupons(consolidated_cart, coupons)
  all_discounts_applied_cart = apply_clearance(consolidated_cart)

  total = 0.0
  all_discounts_applied_cart.keys.each do |item|
    total += all_discounts_applied_cart[item][:price] * all_discounts_applied_cart[item][:count]
  end
  if total > 100.00
    total = (total * 0.9).round
  end
  return total
end
