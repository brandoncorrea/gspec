extends SceneTree

var GSpec = preload("res://addons/gspec/gspec.gd")
var ConsoleOut = preload("res://addons/gspec/console_out.gd")
var out = ConsoleOut.new()

func spec_files(dir, root, file_name):
  var full_name = root + "/" + file_name
  if dir.current_is_dir():
    return get_spec_files(full_name)
  elif file_name.ends_with("_spec.gd"):
    return [full_name]
  return []

func get_spec_files(root):
  var dir = DirAccess.open(root)
  var specs = []
  
  if DirAccess.get_open_error() != OK:
    return []

  dir.list_dir_begin()
  var file_name = dir.get_next()
  
  while file_name != "":
    specs += spec_files(dir, root, file_name)
    file_name = dir.get_next()

  return specs

func new_spec(path):
  return load("res://" + path).new(out)

func _init():
  var specs = get_spec_files("spec").map(new_spec)
  specs.map(func(spec): spec.run_spec())
  specs.map(func(spec): spec.summarize())
  quit()
