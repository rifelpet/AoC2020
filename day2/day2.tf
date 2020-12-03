locals {
  # 1-3 a: abcde
  # min-max letter: password
  lines = [for s in compact(split("\n", file("${path.module}/input"))) : s]

  mins = [for s in local.lines : split("-", s)[0]]
  maxs = [for s in local.lines : split("-", split(" ", s)[0])[1]]
  letters = [for s in local.lines : substr(split(" ", s)[1],0,1)]
  passwords = [for s in local.lines : split(": ", s)[1]]
}

output "part1" {
  value = length(
    compact(
      [for i in range(length(local.lines)) :
        length(regexall(local.letters[i], local.passwords[i])) >= local.mins[i] &&
        length(regexall(local.letters[i], local.passwords[i])) <= local.maxs[i]
        ? "foo" : ""
      ]
    )
  )
}

output "part2" {
  value = length(
    compact(
      [for i in range(length(local.lines)) :
        (
          (
            local.letters[i] == substr(local.passwords[i], local.mins[i] - 1, 1) ||
            local.letters[i] == substr(local.passwords[i], local.maxs[i] - 1, 1)
          ) &&
          !(
            local.letters[i] == substr(local.passwords[i], local.mins[i] - 1, 1) &&
            local.letters[i] == substr(local.passwords[i], local.maxs[i] - 1, 1)
          )

        )
        ? "foo" : ""
      ]
    )
  )
}