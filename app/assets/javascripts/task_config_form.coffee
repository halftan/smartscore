selData = $.parseJSON $('#model-type-select').attr('data-select')
modelSelect = $("[name='task_config[model_type]']")
typeSelect = $("[name='task_config[task_type]']")

buildSelect = (control, data) ->
  $("<option value=\"#{item.value}\">#{item.text}</option>").appendTo control for item in data

typeSelect.change ($evt) ->
  modelSelect.html('')
  buildSelect(modelSelect, selData[$(this).val()])

