def consolidate_cart(cart)
  newhash = {}
  cart.each do |listing|
    listing.each do |item, hash|
      if newhash[item]
        newhash[item][:count] += 1 
      else
        newhash[item] = hash
        newhash[item][:count] = 1
      end 
    end 
  end 
  newhash
end


def apply_coupons(cart, coupons)
=begin
  newhash = {}
  cart.each do |item, hash|
    newhash[item] = hash
    ocount = hash[:count]
    coupons.each do |clip|
      if item == clip[:item] && ocount >= clip[:num]
        newitem = item + " W/COUPON"
        newhash[item][:count] %= clip[:num]
        newhash[newitem] = {}
        newhash[newitem][:price] = clip[:cost] / clip[:num]
        newhash[newitem][:clearance] = hash[:clearance]
        newhash[newitem][:count] = ocount - newhash[item][:count]
      end
    end
  end 
  newhash
end 
=end 
  cart.reduce({}) do |memo, (key, value)|
    memo[key] = value
    ocount = value[:count]
    coupons.each do |clip|
      if clip[:item] == key && ocount >= clip[:num]
        newkey = key + " W/COUPON"
        memo[key][:count] %= clip[:num]
        memo[newkey] = {}
        memo[newkey][:price] = clip[:cost] / clip[:num]
        memo[newkey][:clearance] = value[:clearance]
        memo[newkey][:count] = ocount - memo[key][:count]
      end
    end
    memo
  end 
end

def apply_clearance(cart)
  cart.reduce({}) do |memo, (key, value)|
    memo[key] = value
    if value[:clearance]
      memo[key][:price] *= 0.80
      memo[key][:price] = memo[key][:price].round(2)
    end 
    memo
  end 
end

def checkout(cart, coupons)
  concart = consolidate_cart(cart)
  coucart = apply_coupons(concart, coupons)
  clearcart = apply_clearance(coucart)
  total = clearcart.reduce(0) do |memo, (key, value)|
      memo + value[:price] * value[:count]
    end
  if total > 100
    total *= 0.90
  end
  total
end
