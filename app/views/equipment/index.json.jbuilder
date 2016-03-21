json.array!(@equipment) do |equipment|
  json.extract! equipment, :id, :equip_id, :name, :status
  json.url equipment_url(equipment, format: :json)
end
