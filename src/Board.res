open SharedTypes

let makeCell = (onToggle, x: int, cell) =>
  <Cell key={string_of_int(x)} cell onToggle={_ => onToggle(x)} />
@react.component
let make = (~cells: cells, ~onToggle) =>
  <section>
    {Array.mapi(
      (y, row) =>
        <div className="row" key={string_of_int(y)}>
          {row |> Array.mapi(makeCell(onToggle(y))) |> React.array}
        </div>,
      cells,
    ) |> React.array}
  </section>
