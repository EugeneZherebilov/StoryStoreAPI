json.data do
    # json.image current_user.return_avatar 'large'
    # json.image_medium current_user.return_avatar 'medium'
    # json.image_small current_user.return_avatar 'small'
    json.call(@game, :image)
end