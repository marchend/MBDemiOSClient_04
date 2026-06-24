# AcmeBank iOS

An iOS banking app built with SwiftUI, MVVM + Coordinator architecture, and Okta OIDC authentication.

> **Current state:** Bootstrap scaffold — the app launches and shows a placeholder "AcmeBank" screen. Full features ship in subsequent story PRs.

## Prerequisites

- macOS 14+
- Xcode 16.0+
- [Homebrew](https://brew.sh)

## Getting Started

```bash
git clone <repo-url>
cd <repo>
./setup.sh
```

`setup.sh` installs XcodeGen (via Homebrew if missing), generates `AcmeBank.xcodeproj` from `project.yml`, and opens the project in Xcode.

**Manual fallback** (for environments that block shell scripts):
```bash
brew install xcodegen
xcodegen generate
open AcmeBank.xcodeproj
```

## Running Tests

```bash
xcodebuild test \
  -scheme AcmeBank \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  CODE_SIGNING_ALLOWED=NO
```

## Project Structure

```
project.yml          # XcodeGen spec — source of truth; never edit project.pbxproj
AcmeBank/            # App source (SwiftUI, MVVM + Coordinator)
AcmeBankTests/       # XCTest unit tests
AcmeBankUITests/     # XCUITest UI tests
```

See [CLAUDE.md](./CLAUDE.md) for the full architecture guide used by AI agents.
