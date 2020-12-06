locals {
  lines = [for s in compact(split("\n\n", file("${path.module}/input"))) : compact(split(" ", replace(s, "/[\n:]/", " ")))]
  passports = [for s in local.lines: {for pair in chunklist(s, 2): pair[0] => pair[1]}]
}

output "part1" {
  value = length(
    compact([
      for passport in local.passports:
        setintersection(toset(keys(passport)), toset(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])) == 
          toset(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])
          ? "foo" : ""
    ])
  )
}


output "part2" {
  value = length(
    compact([
      for passport in local.passports:
        (setintersection(toset(keys(passport)), toset(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])) == 
          toset(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])) &&
        try(tonumber(passport.byr) >= 1920 && tonumber(passport.byr) <= 2002, false) &&
        try(tonumber(passport.iyr) >= 2010 && tonumber(passport.iyr) <= 2020, false) &&
        try(tonumber(passport.eyr) >= 2020 && tonumber(passport.eyr) <= 2030, false) &&
        (trimsuffix(lookup(passport, "hgt", ""), "cm") != lookup(passport, "hgt", "") ? try(tonumber(trimsuffix(passport.hgt, "cm")) >= 150 && tonumber(trimsuffix(passport.hgt, "cm")) <= 193) :
          (trimsuffix(lookup(passport, "hgt", ""), "in") != lookup(passport, "hgt", "") ? try(tonumber(trimsuffix(passport.hgt, "in")) >= 59 && tonumber(trimsuffix(passport.hgt, "in")) <= 76) : false)
        ) &&
        try(regex("^#[0-9a-f]{6}$", passport.hcl) != "", false) &&
        contains(["amb","blu","brn","gry","grn","hzl","oth"], try(passport.ecl, "")) &&
        try(regex("^[0-9]{9}$", passport.pid) != "", false)
          ? "foo" : ""
    ])
  )
}