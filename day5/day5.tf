locals {
  lines = [for s in compact(split("\n", file("${path.module}/input"))) :
    {
      row: substr(s, 0, 7),
      col: substr(s, 7, 3),
    }
  ]
  seats = [for l in local.lines:
    {
      row: (substr(l.row, 0, 1) == "B" ? 64 : 0) + (substr(l.row, 1, 1) == "B" ? 32 : 0) + (substr(l.row, 2, 1) == "B" ? 16 : 0) + (substr(l.row, 3, 1) == "B" ? 8 : 0) + (substr(l.row, 4, 1) == "B" ? 4 : 0) + (substr(l.row, 5, 1) == "B" ? 2 : 0) + (substr(l.row, 6, 1) == "B" ? 1 : 0),
      col: (substr(l.col, 0, 1) == "R" ? 4 : 0) + (substr(l.col, 1, 1) == "R" ? 2 : 0) + (substr(l.col, 2, 1) == "R" ? 1 : 0),
    }
  ]
  seat_ids = toset([for s in local.seats: (s.row * 8) + s.col])
  seat_id_range = toset(range(min(local.seat_ids...), max(local.seat_ids...)))
}

output "part1" {
  value = max(local.seat_ids...)
}

output "part2" {
  value = tolist(setsubtract(local.seat_id_range, local.seat_ids))[0]
}
