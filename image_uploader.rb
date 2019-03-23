def image_upload(img3)
  logger.info "upload now"
  tempfile = img3[:tempfile]

  upload = Cloudinary::Uploader.upload(tempfile.path)

  contents = Chat.last

  contents.update_attribute(:img3, upload['url'])
end

def image_upload_local(img3)
  if img3
    contents = Contribution.last
    id = contents.id
    logger.info img3
    ext = File.extname(img3[:filename])
    img_name = "#{id}-bbs#{ext}"
    p "="*20
    logger.info ext
    img_path = "/images/bbs/#{img_name}"
    contents.update_attribute(:img3, img_path)

    save_path = File.join('public', 'images', 'bbs', img_name)

    File.open(save_path, 'wb') do |f|
     logger.info "Temp file: #{img3[:tempfile]}"
     f.write img3[:tempfile].read
     logger.info 'アップロード成功'
    end
  else
    logger.info 'アップロード失敗'
  end
end
