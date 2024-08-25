class_name GSpec

var _context = ""
var _method = ""
var _out = null
var _results = {}

func _init(out):
  _out = out
  _context = _script_name()

func _script_name():
  return get_script().resource_path \
    .trim_prefix("res://spec/") \
    .trim_suffix("_spec.gd")

# Assertions

func should_eq(x, y):
  if x != y:
    fail("  Expected: {0}\n       Got: {1}".format([x, y]))

func fail(reason):
  _results[_method.name] = {
    "context": _context,
    "name": _method.name,
    "failed": true,
    "reason": reason
  }

# Execution

func run_spec():
  _out.println("")
  _out.println(_context)
  _maybe_call("before_all")
  _test_methods().map(_run_test)
  _maybe_call("after_all")

func summarize():
  _failures().map(_print_summary)

func _is_test_method(method):
  return method.name.begins_with("test_")

func _test_methods():
  return get_method_list().filter(_is_test_method)

func _maybe_call(fname):
  if has_method(fname):
    self[fname].call()

func _has_failed(method_name):
  if _results.has(method_name):
    return _results[method_name].failed

func _print_color(color, text):
  _out.println(color + text + "\u001b[0m")

func _print_red(text):
  _print_color("\u001b[31m", text)

func _print_green(text):
  _print_color("\u001b[32m", text)

func _print_result(method_name):
  if _has_failed(method_name):
    _print_red("  " + method_name)
  else:
    _print_green("  " + method_name)

func _failures():
  return _results \
    .values() \
    .filter(func(result): return result.failed)

func _print_summary(result):
  _out.println("")
  _print_red(result.context + " " + result.name)
  _print_red(result.reason)

func _run_test(method):
  _method = method
  _maybe_call("before")
  self[method.name].call()
  _maybe_call("after")
  _print_result(method.name)
  _method = ""
