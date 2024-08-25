extends "res://addons/gspec/gspec.gd"

var counter = 0

func before_all():
  counter += 1

func test_before_first():
  should_eq(1, counter)

func test_before_second():
  should_eq(1, counter)
