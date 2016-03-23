json.array!(@equipment) do |equipment|
  json.extract! equipment, :id, :name, :equip_id, :buy_date, :brand, :note, :exp, :status, :serial, :price, :pic_id
  json.url equipment_url(equipment, format: :json)
end
