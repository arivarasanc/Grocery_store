class Grocery_Store
  Items = {'milk' => 1, 'bread' => 2, 'banana' => 3, 'apple' => 4}
  Unit_price = {1 => 3.97, 2 => 2.17, 3 => 0.99, 4 => 0.89}
  Offer_price = {1 => 5.00, 2 => 6.00, 3 => 0.99, 4 => 0.89}
  Offer_quantity = {1 => 2, 2 => 3, 3 => 1, 4 => 1}

  def items_price_list
    puts 'This week pricing list'
    puts 'Item         Unit Price         Sale Price'
    puts '-------------------------------------'
    Items.each{|key, value| puts key.to_s + '        ' + '$' + Unit_price[value].to_s + '           ' + Offer_quantity[value].to_s + ' for $'+ Offer_price[value].to_s }
  end

  def get_input
    puts 'Please enter the items purchased separated by a comma: '
    items_list = gets
    bill_items(items_list)
  end

  def bill_items(items)
    items_list = items.strip.split(',')
    item_count = Hash.new(0)
    items_list.each{|item| item_count[item.strip.downcase] += 1}
    puts 'your purchase list is ' + item_count.to_s
    final_bill = Hash.new(0)
    actual_total = 0
    for each_item in item_count
      item = Items[each_item[0]]
      qty = each_item[1]
      if !item.nil?
        final_bill[each_item[0]] = (each_item[1] > Offer_quantity[item]) ? (((qty/Offer_quantity[item]) * Offer_price[item]) + ((qty%Offer_quantity[item])*Unit_price[item])) : (qty*Unit_price[item])
        actual_total += qty*Unit_price[item]
      else
        final_bill[each_item[0]] = "Stock Not Available"
      end
    end
    existing_total = final_bill.inject(0) { |total, (k, v)| (total.to_f + v.to_f).round(2)}

    puts 'Item      Quantity       Total Price'
    puts '-------------------------------------'
    final_bill.each{|k, v| puts k + '        ' + item_count[k].to_s + '           ' + '$'+ v.to_s }
    puts ' ------------------------------------'
    puts 'Total                   ' + existing_total.to_s
    puts 'Today you saved $' + (actual_total - existing_total).round(2).to_s
  end
end

purchase = Grocery_Store.new
purchase.items_price_list
purchase.get_input
