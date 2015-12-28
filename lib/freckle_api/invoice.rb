class FreckleApi
  class Invoice < FreckleApi::Model
    coerce_key :invoice_date, coerce_to_date
  end
end
