json.extract! event, :id, :name, :ticket_fee, :timing, :created_at, :updated_at
json.url event_url(event, format: :json)
