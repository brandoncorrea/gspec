# GSpec

A simple testing library for Godot.

## Install

Copy the addons/gspec directory from this project into your project's addons directory.

## Usage

To run your tests, execute this in the command line:

```
godot --headless -s addons/gspec/run_specs.gd
```

### Your first test

In the root of your project, create a `spec` directory and a `*_spec.gd` file anywhere within that directory.

For example: `spec/example_spec.gd`

```godot
extends "res://addons/gspec/gspec.gd"

func test_fails():
  should_eq(2, 2) # Passes
  should_eq(3, 2) # Fails
```

### Before and After

You may optionally add behavior to execute `before` and `after` your tests.

```godot
extends "res://addons/gspec/gspec.gd"

func before():
  # Do something before each test
  pass

func after():
  # Do something after each test
  pass

func before_all():
  # Do something once, before any test runs
  pass

func after_all():
  # Do something once, after every tests runs
  pass

func test_fails():
  should_eq(2, 2)
  should_eq(3, 2)
```


## Development

### Tests

```
godot --headless -s spec/gspec_test.gd
```
