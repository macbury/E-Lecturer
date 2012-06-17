jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip], .have_tooltip").tooltip()
  $("button[rel=tooltip]").tooltip(placement: "right")