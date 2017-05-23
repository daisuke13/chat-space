json.messages @messages.each do |message|
  json.name       message.user.name
  json.created_at message.created_at.strftime("%Y/%m/%d %H:%M")
  json.body       message.body
  json.id         message.id
  json.image      message.image.url
end
