# Aphorismophilia - Terraform Module

This repository contains Terraform to manage a Kubernetes deployment for the [aphorismophilia service](https://github.com/mikeroach/aphorismophilia).

The [IaC Template Pipeline](https://github.com/mikeroach/iac-template-pipeline) composes this module along with other unrelated services into a complete environment stack template containing all their required infrastructure dependencies.

I was inspired to experiment with this approach by Kief Morris' [Template Stack Pattern](https://infrastructure-as-code.com/patterns/stack-replication/template-stack.html) as described in [Infrastructure as Code](https://infrastructure-as-code.com) and Nicki Watt's [Terraservices presentation slides](https://www.slideshare.net/opencredo/hashidays-london-2017-evolving-your-infrastructure-with-terraform-by-nicki-watt) and [video](https://www.youtube.com/watch?v=wgzgVm7Sqlk).

Currently this pseudo-Terraservice's pipeline simply performs rudimentary Terraform formatting and syntax validation checks; integration testing is conducted as part of the [IaC Template Pipeline](https://github.com/mikeroach/iac-template-pipeline).

#### Development Workflow

1. IaC engineer develops and tests locally in feature branch.
1. IaC engineer commits feature branch and submits pull request.
1. Jenkins examines pull request, runs validation tests, and merges into `main` upon success.
1. Jenkins repeats validation tests against `main` branch and tags new release upon success.
1. Stack and template owners update their ephemeral environment definitions and templates with new version tag.
