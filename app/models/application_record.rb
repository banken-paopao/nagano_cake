class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def subtotal
    item.with_tax_price * amount
  end
end
