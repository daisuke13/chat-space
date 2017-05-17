$(function() {
  function buildHTML(message) {
    var html =
    `<div class = "chat-main__body--messages-list-message">`
    + `<div class = "chat-main__body--messages-list-message-name">` + message.name + `</div>`
    + `<div class = "chat-main__body--messages-list-message-date">` + message.created_at + `</div>`
    + `<div class = "chat-main__body--messages-list-message-comment">` + message.body + `</div>`
    + `</div>`
    return html;
  }

  $('#new_message').on('submit', function(e) {
    e.preventDefault();
    var textField = $('#message_body');
    var message = textField.val();
    $.ajax({
      type: 'POST',
      url: './messages',
      data: {
        message: {
          body: message
        }
      },
      dataType: 'json'
    })
    .done(function(data) {
      var html = buildHTML(data);
      console.log(html)
      $('.chat-main__body--messages-list').append(html);
      textField.val('');
      $("input").prop("disabled", false)
    })
    .fail(function() {
      alert('メッセージを送信できませんでした');
    });
  });
});
