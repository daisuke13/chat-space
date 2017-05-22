json.name       @message.user.name
json.created_at @message.created_at.strftime("%Y/%m/%d %H:%M")
json.body       @message.body
json.group_id   @message.group.id
json.image      @message.image.url
