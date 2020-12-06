locals {
  groups = [for s in compact(split("\n\n", file("${path.module}/input"))) : s]
  sums = [for g in local.groups : length(toset(split("", replace(g, "\n", ""))))]
  intersections = [for g in local.groups:
    setintersection([for p in split("\n", g):
      toset(split("", p))
    ]...)
  ]
}

output "part1" {
  value = sum(local.sums)
}

output "part2" {
  value = sum([for i in local.intersections: length(i)])
}