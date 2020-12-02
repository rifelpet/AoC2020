# AoC2020

This repo contains solutions to [AoC 2020](https://adventofcode.com/2020) using Terraform.

The goal is to minimize the use of "shelling out" to other tools or languages.

## Setup

* Each day has its own terraform module
* Inputs are saved as gitignored files within the module
* Answers are defined through terraform outputs
* Answers are then calculated with `terraform apply`
