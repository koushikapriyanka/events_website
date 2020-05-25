json.extract! user_event, :id, :user_id, :event_id, :ticket_fee, :status, :created_at, :created_at, :updated_at
json.url user_event_url(user_event, format: :json)
