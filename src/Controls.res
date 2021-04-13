@react.component
let make = (~onRandom, ~onTogglePlay, ~isPlaying, ~onClear, ~generation) =>
  <aside>
    <button onClick={_ => onRandom()}> {React.string("Random")} </button>
    <button onClick={_ => onTogglePlay()}> {React.string(isPlaying ? "Stop" : "Start")} </button>
    <button onClick={_ => onClear()}> {React.string("Clear")} </button>
    <span style={ReactDOMRe.Style.make(~float="right", ~color="white", ~fontSize="17px", ())}>
      {React.string("Generation: " ++ string_of_int(generation))}
    </span>
  </aside>
