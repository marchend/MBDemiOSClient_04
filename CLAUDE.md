# AcmeBank — Project Context

## Overview
AcmeBank is an iOS banking app that lets customers view accounts and transactions, make
transfers, pay bills, and manage cards — all authenticated via Okta OIDC. This repo
currently contains the bootstrap scaffold (Hello World SwiftUI shell); full features
are added in subsequent story PRs.

## Tech Stack
| Item | Value |
|---|---|
| Platform | iOS 17+, Swift 5.10, Xcode 16+ |
| UI Framework | SwiftUI |
| Architecture | MVVM + Coordinator (NavigationStack) |
| Auth | Okta OIDC via `okta-mobile-swift` 2.x |
| Networking | URLSession + async/await |
| DI | Constructor injection (no service locator) |
| Notifications | NotificationCenter (typed wrappers) |
| Project file | XcodeGen — edit `project.yml`, never `project.pbxproj` |
| Bundle ID | `com.acmebank.mobile` |
| Test (unit) | XCTest → target `AcmeBankTests` |
| Test (UI) | XCUITest → target `AcmeBankUITests` |

## Running Locally
```bash
./setup.sh          # installs xcodegen, generates .xcodeproj, opens Xcode
# manual fallback:
brew install xcodegen && xcodegen generate && open AcmeBank.xcodeproj
```

## Running Tests
```bash
xcodebuild test \
  -scheme AcmeBank \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  CODE_SIGNING_ALLOWED=NO
```

## Key Directory Structure
```
project.yml                  # XcodeGen spec — source of truth for the project
AcmeBank/
├── App/                     # Entry point (implemented)
│   ├── AcmeBankApp.swift    # @main SwiftUI App
│   └── ContentView.swift    # Hello World placeholder → replaced by RootView (deferred)
├── Core/                    # Auth, Networking, Notifications, Extensions (deferred)
├── Domain/                  # Models + Repository protocols (deferred)
├── Data/                    # Remote + Mock repository implementations (deferred)
├── Features/                # Login, Home, Transfer, Cards screens (deferred)
├── DesignSystem/            # Colors, Typography, Assets (deferred)
└── Resources/               # Assets.xcassets, PrivacyInfo.xcprivacy, entitlements
AcmeBankTests/               # XCTest unit tests (smoke test implemented; feature tests deferred)
AcmeBankUITests/             # XCUITest UI tests (smoke test implemented; flow tests deferred)
```

## Planned Architecture

### MVVM + Coordinator (deferred — future PR)
- **View** (SwiftUI struct): renders from ViewModel `@Published` state; zero business logic.
- **ViewModel** (`ObservableObject`): holds `@Published` state, calls repositories, posts notifications.
- **Coordinator** (`ObservableObject`): owns `NavigationPath`; drives push/sheet/fullScreenCover.
- **Repository protocols** in `Domain/`; concrete implementations in `Data/`.

### Coordinator Hierarchy (deferred — future PR)
```
AppCoordinator → LoginCoordinator (no session)
              → TabBarCoordinator → HomeCoordinator
                                  → TransferCoordinator
                                  → CardsCoordinator
                                  → MoreCoordinator
```

### Authentication — Okta OIDC (deferred — future PR)
- `AuthService` wraps `okta-mobile-swift` browser-based OIDC flow.
- Tokens persisted to Keychain via `KeychainStore`.
- `UserSession` value type passed forward through coordinators (never stored in UserDefaults).
- `RequestInterceptor` refreshes token before every request; on failure posts `AppNotification.sessionExpired`.
- **Keychain in CI:** always include `kSecUseDataProtectionKeychain: true` in every Keychain query dict so simulator tests pass with `CODE_SIGNING_ALLOWED=NO`.

### Networking (deferred — future PR)
- `APIClient` wraps URLSession with `.convertFromSnakeCase` + `.iso8601` decoding.
- `APIRouter` enum with associated values for all endpoints.
- Base URL read from `Info.plist` key `API_BASE_URL` (injected by CI xcconfig — never hardcoded).

### Design System (deferred — future PR)
- Strictly monochrome palette: navy (`#1B2A4A`), background (`#F2F3F5`), surface (white), text (`#1A1A1A`), subtext (`#6B7280`). No semantic colours (no red/green for amounts).
- Typography: `acmeTitle`, `acmeHeadline`, `acmeBody`, `acmeCaption`, `acmeMonoBalance` — all Dynamic Type–compatible.

### Internal Notifications (deferred — future PR)
- `AppNotification` typed `Notification.Name` constants.
- `NotificationPublisher.post(...)` static helper.
- Subscriptions live in coordinators only (never in ViewModels or Views).

## Deferred Work
- Okta OIDC authentication (`AuthService`, `KeychainStore`, `UserSession`) — future PR
- MVVM + Coordinator root structure (`AppCoordinator`, `RootView`, `LoginCoordinator`) — future PR
- Networking layer (`APIClient`, `APIRouter`, `APIError`, `RequestInterceptor`) — future PR
- Domain models (`Account`, `Transaction`, `Customer`, `TransferRequest`) — future PR
- Repository protocols + Mock/Remote implementations — future PR
- Feature screens: Login, Home, Transfer, Cards — future PR
- Home dashboard BFF integration (`GET /v1/home`, `HomeRepository`) — future PR
- Design system (`Colors.swift`, `Typography.swift`) — future PR
- Internal notifications (`AppNotification`, `NotificationPublisher`) — future PR
- Swift extensions (`Decimal+Currency`, `Date+Greeting`, `String+Initials`) — future PR
- SwiftLint configuration (`.swiftlint.yml`) — future PR
- CI workflow (`ios-build.yml`, xcconfig injection, `-warnings-as-errors`) — future PR
- XCUITest critical flows (`LoginUITests`, `TransferUITests`) — future PR

## Git Workflow

> **Default PR target branch: `develop`.** Every feature/refactor/docs PR
> opens against `develop`. PRs are only opened against `qa`, `uat`, or
> `main` for explicit promotion PRs.

**Branch model (`develop` → `qa` → `uat` → `main`):**

| Branch  | Role                                 | Receives PRs from              | Promotes to |
|---------|--------------------------------------|--------------------------------|-------------|
| develop | Default integration branch           | feature branches               | qa          |
| qa      | First quality gate                   | develop (promotion PR)         | uat         |
| uat     | Pre-prod acceptance                  | qa (promotion PR)              | main        |
| main    | Production / release tags            | uat (promotion PR)             | tagged only |

All feature PRs MUST target `develop`. Never open a feature PR against
`qa`, `uat`, or `main`. Promotions happen via dedicated promotion PRs.
