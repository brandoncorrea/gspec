extends "res://addons/gspec/gspec.gd"

var counter = 0

func after():
  counter += 1

func test_after_first():
  should_eq(0, counter)

func test_after_second():
  should_eq(1, counter)

func test_after_third():
  should_eq(2, counter)
