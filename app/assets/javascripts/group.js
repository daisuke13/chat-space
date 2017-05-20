$(function() {

//ユーザー検索時、表示されるユーザー名のHTML
  function appendList(user) {
    var html =
    `<div class = "chat-group-user clearfix">
       <p class = "chat-group-user__name"> ${user.name} </p>
       <a class = "user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id = "${user.id}" data-user-name = "${user.name}">追加</a>
     </div>`;
     $('#user-search-result').append(html)
     console.log(html)
  }

//追加ボタンクリック後の、ユーザー名と削除ボタンのHTML
  function buildHTML(id, name) {
    var html =
    `<div class = "chat-group-user clearfix" id = "chat-group-user-${id}">
       <input name = "group[user_ids][]" type = "hidden" value = "${id}">
       <p class = "chat-group-user__name">${name}</p>
       <a class = "user-search-remove chat-group-user__btn chat-group-user__btn--remove" data-user-id = "${id}">削除</a>
     </div>`;
     return html
  }

           // <div id='chat-group-users'>
           // <div class='chat-group-user clearfix' id='chat-group-user-22'>
           // <input name='chat_group[user_ids][]' type='hidden' value='22'>
           // <p class='chat-group-user__name'>seo_kyohei</p>
           // </div>
           // </div>

//コントローラーへjson形式でデータの送信
  $('#user-search-field').on('keyup', function(e) {
    e.preventDefault();
    var input = $.trim($(this).val());

    $.ajax({
      url: '/users/search',
      type: 'GET',
      data: ('keyword=' + input),
      dataType: 'json'
    })

//コントローラーからデータ取得後、ユーザーリストの作成
    .done(function(data) {
      console.log(data)
      $('#user-search-result').find('.chat-group-user').remove();
      $(data).each(function(i, user) {
        appendList(user)
      })
    })
  })

//ユーザーの追加
  $('#user-search-result').on('click', '.chat-group-user__btn--add', function() {
    var add_user = $(this);
    var id = add_user.data('user-id');
    var name = add_user.data('user-name');
    var html = buildHTML(id, name);
    $('#chat-group-users').append(html);
    add_user.parent().remove();
  })

//ユーザーの削除
  $('#chat-group-users').on('click', '.chat-group-user__btn--remove', function() {
    var id = $(this).data('user-id');
    $(this).parent().remove();
  })
})
