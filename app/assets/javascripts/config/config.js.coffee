window.UI         = {} # views classes
window.Interface  = {} # created views
window.Model      = {} # models
window.Collection = {} # collections

window.ServerError = (msg) -> 
  alert("Nastąpił błąd serwera...")
  console.log msg
  #window.location.reload()
  #alert(msg)