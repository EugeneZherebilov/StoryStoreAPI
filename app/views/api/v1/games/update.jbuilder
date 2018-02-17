json.game do
  json.call(@game, :id, :name, :description, :image, :count_players, :type_id, :start_time)
end
