extends "res://addons/gspec/gspec.gd"

var counter = 0

func after_all():
  counter += 1
  _out.println("i only print once")

func test_after_first():
  should_eq(0, counter)

func test_after_second():
  should_eq(0, counter)
