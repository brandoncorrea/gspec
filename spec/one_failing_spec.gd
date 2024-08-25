extends "res://addons/gspec/gspec.gd"

func test_one_failure():
  should_eq(1, 2)
