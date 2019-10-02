require 'pry'
# require_relative 'print_bug'


def consolidate_cart(cart)
  new_cart = {}

  cart.each do |item|
    item.each do |item_name, item_val|
      if new_cart[item_name].nil?
        new_cart[item_name] = item_val
        new_cart[item_name][:count] = 1
      elsif new_cart[item_name][:count]
        new_cart[item_name][:count] += 1
      end
    end
  end
  new_cart
end


def apply_coupons(cart, coupons)
  # init
  # debug(cart) {}
  # debug(coupons) {}
  new_cart = {}
  if coupons != [] || coupons.empty?

    coupons.each do |coupon|
      coupon_name = coupon[:item]
      coupon_num = coupon[:num]
      item_coupon = "#{coupon_name} W/COUPON"

      # cart_count = cart[coupon_name][:count]

      if cart.has_key?(coupon_name)
        if !cart.has_key?(item_coupon) && cart[coupon_name][:count] >= coupon_num

          cart[item_coupon] = {
              price: (coupon[:cost] / coupon_num),
              clearance: cart[coupon_name][:clearance],
              count: coupon_num
          }

        elsif cart[item_coupon] && cart[coupon_name][:count] >= coupon_num
          cart[item_coupon][:count] += coupon_num
        end

        cart[coupon_name][:count] -= coupon_num
      end


      # msg("new_cart.has_key?(coupon_name W/COUPON) is #{new_cart.has_key?("#{coupon_name} W/COUPON")}")
      # msg("IS THIS TRUEE?????? " + (new_cart.has_key?("#{coupon_name} W/COUPON") && cart_count >= coupon_num ? "TRUE" : "FALSE") )
      # msg("cart = #{cart_count}")
      # msg("coupon = #{coupon_num}")
      # msg("cart_count = #{cart_count}")
      # msg("coupon_num = #{coupon_num}")
      #
      #
      #
      # if cart[coupon_name] && cart[coupon_name][:count] >= coupon[:num]
      #
      #   new_cart[coupon_name + " W/COUPON"] =
      #       {
      #           :price => (coupon[:cost] / coupon[:num]),
      #           :clearance => cart[coupon_name][:clearance],
      #           :count => coupon[:num]
      #       }
      #   new_cart[coupon_name] = cart[coupon_name]
      #   new_count = new_cart[coupon_name][:count] - coupon[:num]
      #   new_cart[coupon_name][:count] = [new_count, 0].max
      #
      #
      # elsif new_cart.has_key?("#{coupon_name} W/COUPON") && cart_count >= coupon_num
      #   msg("WTTTTFFFFFFFFFF")
      #
      #   new_cart["#{coupon_name} W/COUPON"][:count] += coupon[:num]
      #   new_count = new_cart[coupon_name][:count] - coupon[:num]
      #   new_cart[coupon_name][:count] = [new_count, 0].max
      #
      # else
      #   # new_cart << cart[coupon_name]
      # end
      #
      # binding.pry



    end


    # coupons.each do |coupon|
    #   cart.each do |item|
    #     item.each do |item_name, item_val|
    #
    #       coupon_name = coupon[:item]
    #
    #       if item_name == coupon_name && cart[item_name][:count] >= coupon[:num]
    #
    #         new_cart[item_name + " W/COUPON"] =
    #             {
    #                 :price => (coupon[:cost] / coupon[:num]),
    #                 :clearance => cart[item_name][:clearance],
    #                 :count => coupon[:num]
    #             }
    #
    #
    #         new_cart[item_name] = item[1]
    #         new_count = new_cart[item_name][:count] - coupon[:num]
    #         new_cart[item_name][:count] = [new_count, 0].max
    #
    #       elsif new_cart.has_key?("#{item_name} W/COUPON") && cart[item_name][:count] >= coupon[:num]
    #         msg("INSIDE THE COUPONNNN")
    #
    #         new_cart["#{item_name} W/COUPON"][:count] += coupon[:num]
    #         new_count = new_cart[item_name][:count] - coupon[:num]
    #         new_cart[item_name][:count] = [new_count, 0].max
    #       else
    #         new_cart[item_name] = item[1]
    #       end
    #     end
    #   end
    # end
  else
    new_cart = cart
  end

  # msg("new_cart = #{new_cart}")
  # anchor

  if new_cart.values == nil
    new_cart = cart
  end

  if new_cart.empty?
    return cart
  else
    return new_cart
  end

end

def apply_clearance(cart)
  new_cart = cart

  cart.each do |item_name, item_val|
    if item_val[:clearance]
      new_cart[item_name][:price] = cart[item_name][:price] - (cart[item_name][:price] * 0.2)
    end
  end

  return new_cart
end

def checkout(cart, coupons)
  # init
  # debug(cart){}
  # debug(coupons){}

  new_cart = consolidate_cart(cart)
  apply_coupons(new_cart, coupons)
  apply_clearance(new_cart)
  total = 0


  new_cart.each do |item_name, item_val|

    if item_val[:count].negative?


      new_cart[item_name][:count] = item_val[:count].abs
      # binding.pry
    end

    total += (item_val[:price] * item_val[:count])
  end

  # binding.pry
  # anchor

  return total >= 100 ? total *= 0.9 : total

end
