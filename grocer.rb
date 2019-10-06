def consolidate_cart(cart)
  # code here
end

def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
def consolidate_cart(cart)
  output = {}
  cart.each do |item|
    item_name = item.keys[0]
    if output[item_name]
      output[item_name][:count] += 1
    else
      output[item_name] = item[item_name]
      output[item_name][:count] = 1
    end
  end
  output
end
