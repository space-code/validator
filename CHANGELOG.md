# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

#### 1.x Releases
- `1.3.x` Releases - [1.3.0](#130)
- `1.2.x` Releases - [1.2.0](#120)
- `1.1.x` Releases - [1.1.0](#110)
- `1.0.x` Releases - [1.0.1](#101) | [1.0.0](#100)

---


## [1.3.0](https://github.com/space-code/validator/releases/tag/1.3.0)

Released on 2025-11-28. All issues associated with this milestone can be found using this [filter](https://github.com/space-code/validator/milestones?state=closed&q=1.3.0).

### Bug Fixes
- Fix the lint action
  - Fixed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#77](https://github.com/space-code/validator/pull/77).
- Ensure form manager correctly updates isValid
  - Fixed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#55](https://github.com/space-code/validator/pull/55).
- Update paths
  - Fixed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#56](https://github.com/space-code/validator/pull/56).
- Fix changelog configuration
  - Fixed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#35](https://github.com/space-code/validator/pull/35).
- Fix conventional commit script execution in GitHub Actions
  - Fixed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#29](https://github.com/space-code/validator/pull/29).

### Documentation
- Add a documentation
  - Documented by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#68](https://github.com/space-code/validator/pull/68).
- Update project structure
  - Documented by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#54](https://github.com/space-code/validator/pull/54).

### Features
- Add validationResult property to UI validation flow
  - Implemented by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#73](https://github.com/space-code/validator/pull/73).
- Add debounce to text field input to reduce validation calls
  - Implemented by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#72](https://github.com/space-code/validator/pull/72).
- Add nil validation rule
  - Implemented by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#66](https://github.com/space-code/validator/pull/66).
- Add characters validation rule
  - Implemented by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#67](https://github.com/space-code/validator/pull/67).
- Add email validation rule
  - Implemented by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#63](https://github.com/space-code/validator/pull/63).
- Add labels for major, minor, swift and GitHub Actions updates
  - Implemented by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#57](https://github.com/space-code/validator/pull/57).
- Add CODEOWNERS file for automatic code review assignments
  - Implemented by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#49](https://github.com/space-code/validator/pull/49).
- Add release workflow for GitHub Actions
  - Implemented by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#32](https://github.com/space-code/validator/pull/32).

### Miscellaneous Tasks
- Pass outputs parameters
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#79](https://github.com/space-code/validator/pull/79).
- Update the changelog file generation
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#78](https://github.com/space-code/validator/pull/78).
- Add skipping commit verification
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#76](https://github.com/space-code/validator/pull/76).
- Add docs generation into the release github action
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#75](https://github.com/space-code/validator/pull/75).
- Add usage examples to the examples directory
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#74](https://github.com/space-code/validator/pull/74).
- Add `.spi.yml`
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#65](https://github.com/space-code/validator/pull/65).
- Add explicit permissions to satisfy CodeQL
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#62](https://github.com/space-code/validator/pull/62).
- Move pull request template
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#61](https://github.com/space-code/validator/pull/61).
- Add explicit permissions to satisfy CodeQL
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#60](https://github.com/space-code/validator/pull/60).
- Update a link to the github actions
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#59](https://github.com/space-code/validator/pull/59).
- Update release version in `README.md`
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#58](https://github.com/space-code/validator/pull/58).
- Add GitHub issue and PR templates
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#52](https://github.com/space-code/validator/pull/52).
- Delete dependabot
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#51](https://github.com/space-code/validator/pull/51).
- Rename actions
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#50](https://github.com/space-code/validator/pull/50).
- Update config
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#46](https://github.com/space-code/validator/pull/46).
- Add --no-verify flag to commit_options in GitHub Action
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#41](https://github.com/space-code/validator/pull/41).
- Automate code formatting and linting with git hooks
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#39](https://github.com/space-code/validator/pull/39).
- Update workflow to run tests and build project
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#33](https://github.com/space-code/validator/pull/33).
- Merge `dev` into `main`
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#31](https://github.com/space-code/validator/pull/31).
- Update `dependabot.yml`
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#28](https://github.com/space-code/validator/pull/28).
- Add `conventional-pr.yml` for PR validation
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#27](https://github.com/space-code/validator/pull/27).

### Refactor
- Simplify CI workflow configuration
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#42](https://github.com/space-code/validator/pull/42).

### Uncategorized Changes
- Add renovate.json
  - Contributed by [@renovate[bot]](https://github.com/renovate[bot]) in Pull Request [#40](https://github.com/space-code/validator/pull/40).
- Add `CreditCardValidationRule` implementation
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#26](https://github.com/space-code/validator/pull/26).
- Add `URLValidationRule` implementation
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#25](https://github.com/space-code/validator/pull/25).
- Update `Mintfile`
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#24](https://github.com/space-code/validator/pull/24).
- Bump actions/checkout from 2 to 5
  - Contributed by [@dependabot[bot]](https://github.com/dependabot[bot]) in Pull Request [#22](https://github.com/space-code/validator/pull/22).
- Bump actions/upload-artifact from 4 to 5
  - Contributed by [@dependabot[bot]](https://github.com/dependabot[bot]) in Pull Request [#23](https://github.com/space-code/validator/pull/23).
- Add `dependabot.yml`
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#21](https://github.com/space-code/validator/pull/21).
- Update `README.md`
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#20](https://github.com/space-code/validator/pull/20).

### New Contributors
* @renovate[bot] made their first contribution in [#69](https://github.com/space-code/validator/pull/69)
* @dependabot[bot] made their first contribution in [#22](https://github.com/space-code/validator/pull/22)

## [1.2.0](https://github.com/space-code/validator/releases/tag/1.2.0)

Released on 2025-11-14. All issues associated with this milestone can be found using this [filter](https://github.com/space-code/validator/milestones?state=closed&q=1.2.0).

### Uncategorized Changes
- Add support for Swift 6.2
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#19](https://github.com/space-code/validator/pull/19).
- Add support for Swift 6.2
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#18](https://github.com/space-code/validator/pull/18).

## [1.1.0](https://github.com/space-code/validator/releases/tag/1.1.0)

Released on 2024-12-24. All issues associated with this milestone can be found using this [filter](https://github.com/space-code/validator/milestones?state=closed&q=1.1.0).

### Uncategorized Changes
- Release `1.1.0`
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#16](https://github.com/space-code/validator/pull/16).
- Update `README.md`
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#17](https://github.com/space-code/validator/pull/17).
- Update gem dependencies
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#15](https://github.com/space-code/validator/pull/15).
- Update `CHANGELOG.md`
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#14](https://github.com/space-code/validator/pull/14).
- Increase the `Swift` version to 6.0
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#13](https://github.com/space-code/validator/pull/13).

## [1.0.1](https://github.com/space-code/validator/releases/tag/1.0.1)

Released on 2024-01-10. All issues associated with this milestone can be found using this [filter](https://github.com/space-code/validator/milestones?state=closed&q=1.0.1).

### Uncategorized Changes
- Release `1.0.1`
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#11](https://github.com/space-code/validator/pull/11).
- Update `CHANGELOG.md`
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#12](https://github.com/space-code/validator/pull/12).

## [1.0.0](https://github.com/space-code/validator/releases/tag/1.0.0)

Released on 2023-10-09. All issues associated with this milestone can be found using this [filter](https://github.com/space-code/validator/milestones?state=closed&q=1.0.0).

### Uncategorized Changes
- Update `CHANGELOG.md`
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#4](https://github.com/space-code/validator/pull/4).
- Update `CHANGELOG.md`
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#3](https://github.com/space-code/validator/pull/3).
- Implement `Validator` package
  - Contributed by [@ns-vasilev](https://github.com/ns-vasilev) in Pull Request [#1](https://github.com/space-code/validator/pull/1).

[1.3.0]: https://github.com/space-code/validator/compare/1.2.0..1.3.0
[1.2.0]: https://github.com/space-code/validator/compare/1.1.0..1.2.0
[1.1.0]: https://github.com/space-code/validator/compare/1.0.1..1.1.0
[1.0.1]: https://github.com/space-code/validator/compare/1.0.0..1.0.1

