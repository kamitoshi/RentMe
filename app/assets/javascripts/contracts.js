// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$("#check").change(function () {
  // チェックが入っていたら有効化
  if ($(this).is(":checked")) {
    // ボタンを有効化
    $("#button").attr("disabled", false);
  } else {
    // ボタンを無効化
    $("#button").attr("disabled", true);
  }
});
