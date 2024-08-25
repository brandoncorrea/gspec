extends "res://addons/gspec/gspec.gd"

func test_first_failure():
  should_eq(1, 2)

func test_second_failure():
  should_eq(3, 4)
