open SharedTypes

type retainedProps = {cell: cell}

let classNameOfStatus = (status): string =>
  switch status {
  | Alive => "alive"
  | Dead => "dead"
  }
@react.component
let make = (~onToggle, ~cell: cell) => {
  let status = ref(cell.status)
  cell.status !== status.contents
    ? <div className={"cell " ++ classNameOfStatus(cell.status)} onClick={_ => onToggle()} />
    : <div className={"cell " ++ classNameOfStatus(status.contents)} onClick={_ => onToggle()} />
}
