extends SceneTree

var GSpec = preload("res://addons/gspec/gspec.gd")
var MemoryOut = preload("res://addons/gspec/memory_out.gd")
var passing = true

func should_eq(x, y):
  if x != y:
    push_error("Expected {0}, but got {1}".format([x, y]))
    passing = false

func should_have_output(path, message):
  var out = MemoryOut.new()
  var spec = load(path).new(out)
  spec.run_spec()
  spec.summarize()
  should_eq(message, out.out)

func format_red_line(text):
  return "\u001b[31m{0}\u001b[0m\n".format([text])

func format_green_line(text):
  return "\u001b[32m{0}\u001b[0m\n".format([text])

func no_summary_when_no_tests_defined():
  should_have_output("res://spec/empty_spec.gd", "\nempty\n")

func prints_green_with_passing_test():
  should_have_output(
    "res://spec/passing_spec.gd",
    "\npassing\n" + format_green_line("  test_the_passing_spec"))

func prints_red_and_summary_with_failing_test():
  should_have_output(
    "res://spec/one_failing_spec.gd",
    "\none_failing\n" + \
    format_red_line("  test_one_failure") + \
    "\n" + \
    format_red_line("one_failing test_one_failure") + \
    format_red_line("  Expected: 1\n       Got: 2"))

func prints_two_failures():
  should_have_output(
    "res://spec/two_failing_spec.gd",
    "\ntwo_failing\n" + \
    format_red_line("  test_first_failure") + \
    format_red_line("  test_second_failure") + \
    "\n" + \
    format_red_line("two_failing test_first_failure") + \
    format_red_line("  Expected: 1\n       Got: 2") + \
    "\n" + \
    format_red_line("two_failing test_second_failure") + \
    format_red_line("  Expected: 3\n       Got: 4"))

func executes_before_each_test():
  should_have_output(
    "res://spec/before_spec.gd",
    "\nbefore\n" + \
    format_green_line("  test_before_first") + \
    format_green_line("  test_before_second"))

func executes_after_each_test():
  should_have_output(
    "res://spec/after_spec.gd",
    "\nafter\n" + \
    format_green_line("  test_after_first") + \
    format_green_line("  test_after_second") + \
    format_green_line("  test_after_third"))

func executes_before_all_tests():
  should_have_output(
    "res://spec/before_all_spec.gd",
    "\nbefore_all\n" + \
    format_green_line("  test_before_first") + \
    format_green_line("  test_before_second"))

func executes_after_all_tests():
  should_have_output(
    "res://spec/after_all_spec.gd",
    "\nafter_all\n" + \
    format_green_line("  test_after_first") + \
    format_green_line("  test_after_second") + \
    "i only print oce\n")

func run_tests():
  no_summary_when_no_tests_defined()
  prints_green_with_passing_test()
  prints_red_and_summary_with_failing_test()
  prints_two_failures()
  executes_before_each_test()
  executes_after_each_test()
  executes_before_all_tests()
  executes_after_all_tests()

func _init():
  run_tests()
  var result = 0
  if passing:
    print("PASSING")
  else:
    print("FAILING")
    result = -1

  print("RESULT: ", result)
  quit(result)
