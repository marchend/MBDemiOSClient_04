# Bootstrap Plan — AcmeBank iOS

## In scope (this PR)

### Project name + tech stack decisions
- **App name:** AcmeBank
- **Platform:** iOS 17+, Swift 5.10
- **UI Framework:** SwiftUI (spec-mandated)
- **Project file mechanism:** XcodeGen (`project.yml`) — no hand-crafted .pbxproj
- **Test framework:** XCTest (unit), XCUITest target declared but filled with one smoke test
- **Minimum Xcode:** 16.0
- **Bundle ID:** `com.acmebank.mobile`

### Directory structure (Hello World only)

```
AcmeBank/                          # source root (XcodeGen glob target)
├── App/
│   ├── AcmeBankApp.swift          # @main SwiftUI App entry
│   └── ContentView.swift          # placeholder "AcmeBank" Text view
└── Resources/
    └── Assets.xcassets/
        ├── Contents.json
        └── AppIcon.appiconset/
            └── Contents.json

AcmeBankTests/
└── AcmeBankTests.swift            # one smoke test: ContentView initialises

AcmeBankUITests/
└── AcmeBankUITests.swift          # one smoke test: app launches

project.yml                        # XcodeGen spec
bootstrap_plan.md
CLAUDE.md
AGENT.md
README.md
.gitignore
setup.sh
```

### Files this PR creates
| File | Purpose |
|---|---|
| `project.yml` | XcodeGen project spec — generates AcmeBank.xcodeproj |
| `AcmeBank/App/AcmeBankApp.swift` | @main SwiftUI App entry |
| `AcmeBank/App/ContentView.swift` | Hello World placeholder view |
| `AcmeBank/Resources/Assets.xcassets/Contents.json` | Asset catalog metadata |
| `AcmeBank/Resources/Assets.xcassets/AppIcon.appiconset/Contents.json` | Satisfies actool AppIcon requirement |
| `AcmeBank/AcmeBank.entitlements` | Keychain access group (CI-safe boilerplate) |
| `AcmeBank/PrivacyInfo.xcprivacy` | Privacy manifest (UserDefaults reason) |
| `AcmeBankTests/AcmeBankTests.swift` | Smoke unit test |
| `AcmeBankUITests/AcmeBankUITests.swift` | Smoke UI test |
| `CLAUDE.md` | Project context for AI agents |
| `AGENT.md` | Same content (other model families) |
| `README.md` | Human-readable project overview |
| `.gitignore` | Standard iOS/XcodeGen ignore set |
| `setup.sh` | One-shot project materialisation script |

### How to run locally
```bash
./setup.sh        # installs xcodegen if needed, generates .xcodeproj, opens Xcode
# or manually:
brew install xcodegen && xcodegen generate
open AcmeBank.xcodeproj
```

### How to run tests
```
xcodebuild test \
  -scheme AcmeBank \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  CODE_SIGNING_ALLOWED=NO
```

### Definition of Hello World
The app launches and displays a single screen with the text **"AcmeBank"** centred on a white background. The unit-test target compiles, links against the app module, and the smoke test `test_contentView_initializes` passes.

---

## Out of scope — deferred to future work

- **Okta OIDC authentication** (`AuthService`, `KeychainStore`, `UserSession`, `Okta.plist`) — future PR
- **MVVM + Coordinator pattern** (`AppCoordinator`, `LoginCoordinator`, `TabBarCoordinator`, `HomeCoordinator`, etc.) — future PR
- **Networking layer** (`APIClient`, `APIRouter`, `APIError`, `RequestInterceptor`) — future PR
- **Domain models** (`Account`, `Transaction`, `Customer`, `TransferRequest`) — future PR
- **Repository protocols** (`AccountRepositoryProtocol`, `TransactionRepositoryProtocol`, etc.) — future PR
- **Mock data layer** (`MockAccountRepository`, `MockTransactionRepository`, `MockCustomerRepository`) — future PR
- **Remote data repositories** (`AccountAPIRepository`, `TransactionAPIRepository`, etc.) — future PR
- **Feature screens** (`LoginView`, `HomeView`, `HomeViewModel`, `TransferView`, `CardsView`) — future PR
- **Design system** (`Colors.swift`, `Typography.swift`, full `Assets.xcassets` palette) — future PR
- **Internal notifications** (`AppNotification`, `NotificationPublisher`, `NotificationKey`) — future PR
- **Extensions** (`Decimal+Currency`, `Date+Greeting`, `String+Initials`) — future PR
- **SwiftLint** `.swiftlint.yml` configuration — future PR
- **CI workflow** (`ios-build.yml`, xcconfig injection, `-warnings-as-errors`) — future PR
- **XCUITest critical flows** (`LoginUITests`, `TransferUITests`) — future PR
- **Home dashboard BFF integration** (`GET /v1/home`, `HomeDashboard` model, `HomeRepository`) — future PR
- **`RootView`** auth-state switching (login vs TabBar) — future PR
