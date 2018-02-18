module UpdateImage

  def update_image(new_file)
    key = new_file.keys[0]
    value = new_file[key]
    if attributes[key].blank? && value.present?
      update(key => upload_file(value, self.class::S3_BUCKET_NAME))
    elsif attributes[key].present? && value.blank?
      delete_file(attributes[key], self.class::S3_BUCKET_NAME)
      update(key => nil)
    elsif attributes[key].present? && value.present?
      update(key => update_file(value, attributes[key], self.class::S3_BUCKET_NAME))
    end
  end
end