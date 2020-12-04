locals {
  lines = [for s in compact(split("\n", file("${path.module}/input"))) : [for c in split("", s): c == "#" ? true : false]]

  part2_motions = [
    [1, 1],
    [3, 1],
    [5, 1],
    [7, 1],
    [1, 2],
  ]

  part2_results = [
    for motion in local.part2_motions:
      length(
        compact(
          [
            for rowNum in range(length(local.lines) / motion[1]):
              local.lines[rowNum * motion[1]][
                (rowNum * motion[0]) % length(local.lines[rowNum * motion[1]])
              ] ? "foo" : ""
          ]
        )
      )
  ]
}

output "part1" {
  value = length(
    compact(
      [
        for rowNum in range(length(local.lines)):
          local.lines[rowNum][
            (rowNum * 3) % length(local.lines[rowNum])
          ] ? "foo" : ""
      ]
    )
  )

}

output "part2" {
  value = local.part2_results[0] * local.part2_results[1] * local.part2_results[2] * local.part2_results[3] * local.part2_results[4]
}