type t<'value>

module Core = {
  @set external set: (t<'value>, 'value) => unit = "value"
  @get external val: t<'value> => 'value = "value"
  @send external peek: t<'value> => 'value = "peek"

  @module("@preact/signals-core")
  external make: 'value => t<'value> = "signal"

  @module("@preact/signals-core")
  external computed: (@uncurry (unit => 'value)) => t<'value> = "computed"

  @module("@preact/signals-core")
  external effect: (@uncurry (unit => unit)) => unit = "effect"

  @module("@preact/signals-core")
  external effectWithCleanup: (@uncurry (unit => unit)) => (@uncurry (unit => unit)) = "effect"

  @module("@preact/signals-core")
  external batch: (@uncurry (unit => unit)) => unit = "batch"
}

module React = {
  @module("@preact/signals-react")
  external make: 'value => t<'value> = "signal"
}

module ReactHooks = {
  @module("@preact/signals-react")
  external useSignal: 'value => t<'value> = "useSignal"

  @module("@preact/signals-react")
  external useComputed: (@uncurry (unit => 'value)) => t<'value> = "useComputed"
}
