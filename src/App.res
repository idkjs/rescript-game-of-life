open SharedTypes

type state = {
  size: size,
  generation: int,
  cells: cells,
  timer: ref<option<int>>,
  isPlaying: bool,
}

type action =
  | Evolution
  | Start
  | Stop
  | Clear
  | ToggleCell(position)
  | Random

let initialSize = Logic.getInitialSize()

let initialState = {
  size: initialSize,
  generation: 0,
  cells: Logic.generateRandomCells(initialSize),
  timer: ref(None),
  isPlaying: false,
}

let reducer = (state, action) =>
  switch action {
  | Start => {...state, isPlaying: true}
  | Evolution => {
      ...state,
      cells: Logic.evolution(state.cells),
      generation: state.generation + 1,
    }
  | Stop => {...state, isPlaying: false, timer: ref(None)}
  | ToggleCell(position) => {
      ...state,
      cells: Logic.toggleCell(position, state.cells),
    }
  | Clear => {
      ...state,
      cells: Logic.generateEmptyCells(initialSize),
      generation: 0,
    }
  | Random => {
      ...state,
      cells: Logic.generateRandomCells(state.size),
      generation: 0,
    }
  }

@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, initialState)

  let clearTimerAndStop = () => {
    switch state.timer.contents {
    | None => ()
    | Some(timeout) => Utils.cancelAnimationFrame(timeout)
    }
    dispatch(Stop)
  }

  let togglePlay = () =>
    if state.isPlaying {
      clearTimerAndStop()
    } else {
      let rec play = () => {
        state.timer := Some(Utils.requestAnimationFrame(play))
        dispatch(Evolution)
      }
      play()
      dispatch(Start)
    }
  let clear = () => {
    clearTimerAndStop()
    dispatch(Clear)
  }
  let random = () => {
    clearTimerAndStop()
    dispatch(Random)
  }
  <main>
    <Header />
    <Controls
      onRandom={_ => random()}
      onTogglePlay={_ => togglePlay()}
      isPlaying=state.isPlaying
      onClear={_ => clear()}
      generation=state.generation
    />
    <Board cells=state.cells onToggle={(y, x) => dispatch(ToggleCell((x, y)))} />
    <footer>
      <a
        href="https://github.com/idkjs/rescript-game-of-life"
        style={ReactDOMRe.Style.make(~float="right", ~fontSize="17px", ())}
        target="_blank">
        {React.string("Github")}
      </a>
    </footer>
  </main>
}
