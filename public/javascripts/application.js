Event.observe(window, "load", function() {
  var forenames = $("user_forenames");
  if (forenames) {
    forenames.focus();
    return;
  }
  var email = $("email");
  if (email) {
    email.focus();
    return;
  }
  var name = $("watch_name");
  if (name && !name.disabled) {
    name.focus();
    return;
  }
  var address = $("watch_address");
  if (address) {
    address.focus();
    return;
  }
  var username = $("user_twitter_username");
  if (username) {
    username.focus();
  }
});