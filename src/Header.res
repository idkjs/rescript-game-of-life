@react.component
let make = () =>
  <header>
    <h1> {React.string("Rescript Game of Life")} </h1>
    <h2>
      {React.string("An implementation of ")}
      <a href="https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life" target="_blank">
        {React.string("Conway's Game of Life")}
      </a>
      {React.string(" in ")}
      <a href="https://rescript-lang.org/" target="_blank"> {React.string("Rescript")} </a>
      {React.string(" and ")}
      <a href="https://rescript-lang.org/docs/react/latest/introduction" target="_blank">
        {React.string("RescriptReact")}
      </a>
    </h2>
  </header>
