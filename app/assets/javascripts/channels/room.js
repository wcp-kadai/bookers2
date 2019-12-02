$(function() {
    // 必要な値を定義
    const current_user_id = () => $('input:hidden[name="from_id"]').val();
    const user_id = () => $('input:hidden[name="to_id"]').val();
    const room_id = () => $('input:hidden[name="room_id"]').val();
    const content = () => $('input[name="content"]').val();

    // ルームを定義
    const room_ch = () => {
      return {
        channel: 'RoomChannel',
        room_id: room_id() // channelクラスにパラメーターを渡す(params[:room_id]で受け取れる)
      }
    };

    // サブスクライブ
    App.room = App.cable.subscriptions.create(room_ch(), {
      received: (data) => { // メッセージをストリームした時のコールバック定義
        $('#message-wrapper').append(data.message);
        floatMessage(); // ログインユーザーのメッセージを右寄せ(下で定義された関数)
        $(window).scrollTop($('#message-wrapper').height()); // 一番下にスクロール
      },
      speak(from_id, to_id, room_id, content) {
        this.perform('speak', { from_id, to_id, room_id, content }); // RoomChannel#speakの呼び出し
      }
    });

    // 送信ボタンクリックイベント定義
    $(document).on('click', '#submit', (e) => {
      e.preventDefault(); // 送信ボタンデフォルトのクリック挙動を無くす
      App.room.speak(current_user_id(), user_id(), room_id(), content()); // App.roomに定義したメソッド呼び出し
      $('input[name="content"]').val(''); // テキストフィールドを空に
    });

    // 一番下にスクロールする関数定義
    const floatMessage = () => {
      $('.message-' + current_user_id()).css({
        justifyContent: 'flex-end'
      });
    };
    floatMessage(); // DMのページに遷移した際に一番下にスクロールするため呼び出す

});
