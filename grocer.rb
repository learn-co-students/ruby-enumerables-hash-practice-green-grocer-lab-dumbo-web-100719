def consolidate_cart(cart)
  final_cart = Hash.new
  # iterate thru array
  cart.each do |item|
	# iterate thru keys
  	item.each do |(product,price_clearance)|
  		# if key is already present, than increment count by one
  		if final_cart[product]
  			final_cart[product][:count] += 1 
  		#if the key wasn't present, then add price_clearance and count set to 1 
  		else
  			final_cart[product] = price_clearance
  			final_cart[product][:count] = 1
  		end
  	end
  end
  return final_cart
end

def apply_coupons(cart, coupons)
  final_cart = {}
  cart.each do |(product,info)|
    coupons.each do |coupon|
      if product == coupon[:item] && info[:count] >= coupon[:num]
        info[:count] -= coupon[:num]
        
        if final_cart["#{product} W/COUPON"]
          final_cart["#{product} W/COUPON"][:count] += coupon[:num] 
        else
          final_cart["#{product} W/COUPON"] = {
            price: coupon[:cost]/coupon[:num],
            clearance: info[:clearance],
            count: coupon[:num]
          }
        end
      end
    end
    final_cart[product] = info
  end
  return final_cart
end


def apply_clearance(cart)
  discount = 0.20
  cart.each do |(product,info)|
	if info[:clearance] == true
		info[:price] -= (info[:price] * discount).round(2)
	end
  end
  return cart
end

def checkout(cart, coupons)
  final_bill_total = 0
  consolidated_cart = consolidate_cart(cart)
  total_cart_price = apply_clearance(apply_coupons(consolidated_cart,coupons))
  total_cart_price.each do |(product,value)|
    total_bill = value[:price] * value[:count]
    final_bill_total += total_bill
  end
  extended_discout = 0.10
  if final_bill_total > 100
    final_bill_total -= final_bill_total*extended_discout
  end
  return final_bill_total
end
