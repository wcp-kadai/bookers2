$(function() {
  const current_user_id = () => $('input:hidden[name="from_id"]').val();
  const user_id = () => $('input:hidden[name="to_id"]').val();
  const room_id = () => $('input:hidden[name="room_id"]').val();
  const content = () => $('input[name="content"]').val();
  console.log(room_id());

  const room_ch = () => {
    return {
      channel: 'RoomChannel',
      room_id: room_id()
    }
  };

  App.room = App.cable.subscriptions.create(room_ch(), {
    received: (data) => {
      $('#message-wrapper').append(data.message);
      floatMessage();
      $(window).scrollTop($(window).height());
      console.log($(window).height());
    },
    speak(from_id, to_id, room_id, content) {
      this.perform('speak', { from_id, to_id, room_id, content });
    }
  });

  $(document).on('click', '#submit', (e) => {
    e.preventDefault();
    App.room.speak(current_user_id(), user_id(), room_id(), content());
    $('input[name="content"]').val('');
  });

  const floatMessage = () => {
    $('.message-' + current_user_id()).css({
      justifyContent: 'flex-end'
    });
  };
  floatMessage();
});
