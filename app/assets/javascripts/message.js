$(function() {
  function buildHTML(message) {
    var message_image = "";
    if (message.image) {
      message_image =  `<div class = "chat-main__body--messages-list-message-image">
           <img src = "${message.image}" alt = "image">
         </div>`
    }
    var html =
      `<div class = "chat-main__body--messages-list-message">
         <div class = "chat-main__body--messages-list-message-name">
           ${message.name}
         </div>
         <div class = "chat-main__body--messages-list-message-date">
           ${message.created_at}
         </div>
         <div class = "chat-main__body--messages-list-message-comment">
           ${message.body}
         </div>
         ${message_image}
       </div>`
    return html;
  }

  function buildMessage(message) {
    var message =
      `<p class = "group-message">
           ${message.body}
       </p>`
    return message;
  }

  function flash() {
    var html =
      `<p class="alert-notice">メッセージを送信しました</p>`
    $('.alert').append(html);
    $('.alert-notice').fadeIn(500).fadeOut(2000);
    setTimeout(function(){
     $('.alert-notice').remove();
    },2500);
  }

  function scroll() {
    var scroll =
      $('.chat-main__body').delay(100).animate({
        scrollTop: $('.chat-main__body')[0].scrollHeight
      }, 1500);
  }

  $('#new_message').on('submit', function(e) {
    e.preventDefault();
    var textField = $('#message_body');
    var messageData = new FormData($(this).get(0));
    $.ajax({
      type: 'POST',
      url: './messages',
      data: messageData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data) {
      var html = buildHTML(data);
      $('.chat-main__body--messages-list').append(html);
      textField.val('');
      $("input").prop("disabled", false)

      var message = buildMessage(data);
      var group_id = ".id-" + data.group_id
      $(group_id).html(message);
      textField.val('');
      $('#new_message')[0].reset();
      flash();
      scroll();
    })

    .fail(function() {
      alert('メッセージを送信できませんでした');
      $("input").prop("disabled", false)
    });
  });
});
