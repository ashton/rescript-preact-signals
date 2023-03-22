# rescript-preact-signals
Rescript bindings for [@preact/signals](https://github.com/preactjs/signals#guide--api)

## Installation

```sh
npm install @preact/signals-core rescript-preact-signals
```

Or if you want the react integration:

```sh
npm install @preact/signals-react rescript-preact-signals
```

## Usage

### Create a signal

```rescript
let signal = PreactSignals.Core.make("initial value")
```

### Basic Usage

```rescript
open PreactSignals.Core
let signal = PreactSignals.Core.make("initial value")

// Get signal current value
signal->val->Js.console.log

// Update a signal's value
signal->set("new value")
```

### Computed (derived) values

```rescript
open PreactSignals.Core
let signal = PreactSignals.Core.make("initial value")

let uppercaseSignal = computed(() => signal->val->Js.String2.toUpperCase)
uppercaseSignal->val->Js.Console.log // Would print "INITIAL VALUE"
```

### Effects

```rescript
open PreactSignals.Core
let signal = PreactSignals.Core.make("initial value")

effect(() => Js.Console.log(signal->val))
signal->set("new value") // Will trigger the console.log
```

You can delete an effect and all things that listen to it:

```rescript
open PreactSignals.Core
let signal = PreactSignals.Core.make("initial value")

let dispose = effectWithCleanup(() => Js.Console.log(signal->val))
dispose()
signal->set("new value") // Nothing will happen
```

### Batch updates

```rescript
open PreactSignals.Core
let signal = PreactSignals.Core.make("initial value")
let otherSignal = PreactSignals.Core.make("other initial value")

// All updates happens after the callback executes
batch(() => {
  signal->set("new value")
  otherSignal->set("other new value")
})
```

## RescriptReact integration

### Re-rendering
```rescript
let counterSignal = PreactSignals.React.make(0)

@react.component
let make = () => 
  //Everytime signal's value updates, component will re-render
  <span>counter value is: {counterSignal->val}</span>
```

### Hooks
If you need to instantiate new signals inside your components, you can use the `useSignal` or `useComputed` hook.

```rescript
open PreactSignals.ReactHooks

@react.component
let make = () => {
  let counter = useSignal(0)
  let double = useComputed(() => counter->val * 2)
  
  <div>
    <span>Counter value is: {counter->val} and it's double is: {double->val}</span>
    <button onClick={() => counter->set(counter->val + 1)}>Increment counter</button>
  </div>
}
```
