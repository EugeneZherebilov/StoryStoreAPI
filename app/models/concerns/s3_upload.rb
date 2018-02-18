require 'aws-sdk'
module S3Upload

  def s3_initialize(file_name, bucket)
    s3 = Aws::S3::Resource.new
    bucket = s3.bucket(bucket)
    @obj = bucket.object(file_name)
  end

  def upload_file(file, bucket)
    file_name = Time.now.to_i.to_s + "_" + SecureRandom.uuid.to_s
    s3_initialize(file_name, bucket)
    body = Base64.decode64(file.split(',')[1])
    @obj.put(body: body, acl: 'public-read', content_type: 'image/jpeg', content_encoding: 'base64')
    @file_link = 'https://s3-us-east-1.amazonaws.com/' + bucket + '/' + file_name
  end

  def delete_file(file_link, bucket)
    file_name = file_link.split('/')[-1]
    s3_initialize(file_name, bucket)
    @obj.delete
    s3_initialize(file_name + '_medium', bucket)
    @obj.delete if @obj
    s3_initialize(file_name + '_small', bucket)
    @obj.delete if @obj
  end

  def update_file(new_file, old_file_link, bucket)
    delete_file(old_file_link, bucket)
    upload_file(new_file, bucket)
  end
end
