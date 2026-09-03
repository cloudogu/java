# Build & Release

Apply your changes, e.g.:

1. In `Makefile`, update the `*_VERSION` and `CHANGE_COUNTER` fields.
2. Create a section for the new version in the `CHANGELOG.md`.

### Build Locally

1. Build with `make build`.
2. Test with `make unit-test-shell-local`.

### Publish Release

PR/merge the development changeset into the respective main branch (`java8`, `java11`, ...).

Use Pipeline parameter `PublishPrerelease` to publish a prerelease image to namespace `registry.cloudogu.com/prerelease_official/`.

Use Pipeline parameter `PublishRelease` to publish an image to namespace `registry.cloudogu.com/official/` and create a GitHub release.
The release tag will be generated automatically from the `Makefile` variables.
