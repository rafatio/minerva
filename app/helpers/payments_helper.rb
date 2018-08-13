module PaymentsHelper
  def format_currency value
    value == 0 ? "-" : number_to_currency(value, unit: "R$ ", separator: ",")
  end
end