json.game do
  json.call(@game, :id, :user_id, :name, :description, :image, :count_players, :type_id, :start_time)
end
