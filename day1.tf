locals {
  nums = [for s in compact(split("\n", file("${path.module}/day1.input"))) : tonumber(s)]
}

output "day1-part1" {
  value = compact([for i in local.nums : contains(local.nums, 2020 - i) ? i * (2020 - i) : ""])[0]
}
output "day1-part2" {
  value = compact(
    flatten(
      [for i in local.nums :
        [for j in slice(local.nums, index(local.nums, i), length(local.nums)) :
          contains(local.nums, 2020 - i - j) ? i * j * (2020 - i - j) : ""
        ]
      ]
    )
  )[0]
}
