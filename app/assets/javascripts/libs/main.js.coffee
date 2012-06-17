$.for = (element, clb) ->
  $(document).ready -> clb() if $(element).size() > 0