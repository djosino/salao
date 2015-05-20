$.fn.extend
  dynamicSelectable: ->
    $(@).each (i, el) ->
      new DynamicSelectable($(el))

class DynamicSelectable
  constructor: ($select) ->
    @init($select)

  init: ($select) ->
    @urlTemplate = $select.data('dynamicSelectableUrl')
    @$targetSelect = $($select.data('dynamicSelectableTarget'))
    @$targetInput  = $("input" + $select.data('dynamicSelectableTarget'))
    
    $select.on 'change', =>
      @clearTarget()
      url = @constructUrl($select.val())
      if url
        $("#loading").show()
        $.getJSON url, (data) =>
          $.each data, (index, el) =>
            if el["textfield"]
              @$targetInput.val el[el["column"]] 
            else
              @$targetSelect.append "<option value='" + el.id + "'>" + el[el["column"]] + "</option>"
            # reinitialize target select
          @reinitializeTarget()
      else
        @reinitializeTarget()

  reinitializeTarget: ->
    @$targetSelect.trigger("change")
    @$targetInput.trigger("change")
    $("#loading").hide()

  clearTarget: ->
    @$targetSelect.html('<option></option>')
    @$targetInput.html('')

  constructUrl: (id) ->
    if id && id != ''
      id += '/'
      @urlTemplate.replace(/:.+\//, id )
