# DeviceX SDK - Configuration System

Complete iOS implementation of the DeviceX configuration and environment management system with **full Android parity**.

## Overview

The DeviceX SDK configuration system provides:
- ✅ **Environment selection** (Sandbox/Production)
- ✅ **Hardcoded URLs** matching Android implementation
- ✅ **HTTPS-only enforcement**
- ✅ **Builder pattern with fluent API**
- ✅ **Info.plist support** for zero-code configuration
- ✅ **Thread-safe** and **Sendable** types
- ✅ **Comprehensive validation** with clear error messages

## Hardcoded URLs (Android Parity)

The SDK uses these exact URLs from `EnvironmentResolver.kt`:

| Environment | Base URL |
|------------|----------|
| Sandbox | `https://api.sandbox.gatekeeperx.com` |
| Production | `https://api.gatekeeperx.com` |

**Events Path Template:** `/{tenant}/device-signals/api/events/v1`

### Example Full URLs:

- **Sandbox**: `https://api.sandbox.gatekeeperx.com/acme/device-signals/api/events/v1`
- **Production**: `https://api.gatekeeperx.com/acme/device-signals/api/events/v1`

## API Reference

### DeviceXEnvironment

```swift
public enum DeviceXEnvironment: String, Sendable {
    case sandbox = "SANDBOX"
    case production = "PRODUCTION"
}
```

**Environment parsing** (case-insensitive, Android parity):
- `"sandbox"`, `"stage"`, `"staging"` → `.sandbox`
- `"prod"`, `"production"` → `.production`
- Unknown values → `.production` (fail secure)

### DeviceXConfiguration

Immutable configuration struct with all SDK settings:

```swift
public struct DeviceXConfiguration: Sendable {
    public let tenant: String
    public let environment: DeviceXEnvironment
    public let baseURL: URL
    public let eventsPath: String
    public let headers: [String: String]
    
    public var ingestionEndpoint: URL
}
```

### Configuration.Builder

Fluent API for building configurations:

```swift
public final class DeviceXConfiguration.Builder {
    public func setTenant(_ value: String) -> Self
    public func setApiKey(_ value: String) -> Self
    public func setEnvironment(_ value: DeviceXEnvironment) -> Self
    public func setOrganizationId(_ value: String) -> Self
    public func setBaseURL(_ value: URL) throws -> Self
    public func setEventsPath(_ value: String) -> Self
    public func addHeader(name: String, value: String) -> Self
    public func setHeaders(_ values: [String: String]) -> Self
    public func build() throws -> DeviceXConfiguration
}
```

## Usage Examples

### 1. Basic Configuration (Production)

```swift
let devicex = try Devicex.configure { config in
    config.setTenant("acme-corp")
    config.setApiKey(apiKey)
}

// Result:
// Environment: production
// URL: https://api.gatekeeperx.com/acme-corp/device-signals/api/events/v1
```

### 2. Sandbox Environment

```swift
let devicex = try Devicex.configure { config in
    config.setTenant("test-tenant")
    config.setApiKey(apiKey)
    config.setEnvironment(.sandbox)
}

// Result:
// Environment: sandbox
// URL: https://api.sandbox.gatekeeperx.com/test-tenant/device-signals/api/events/v1
```

### 3. With Custom Organization ID

```swift
let devicex = try Devicex.configure { config in
    config.setTenant("acme")
    config.setApiKey(apiKey)
    config.setOrganizationId("org-123")  // Optional, defaults to tenant
}

// Headers:
// X-Tenant: acme
// X-Organization-Id: org-123
```

### 4. Custom Base URL (Enterprise/On-premise)

```swift
let devicex = try Devicex.configure { config in
    config.setTenant("enterprise")
    config.setApiKey(apiKey)
    try config.setBaseURL(URL(string: "https://internal-api.company.com")!)
    config.setEventsPath("/custom/events/v1")
}
```

### 5. Global Instance Pattern

```swift
// Configure once at app startup
try Devicex.configureGlobally { config in
    config.setTenant("acme")
    config.setApiKey(apiKey)
}

// Use anywhere in the app
if Devicex.hasInstance {
    let devicex = try Devicex.instance
    devicex.sendEventAsync(name: "app_opened") { result in
        // Handle result
    }
}
```

### 6. Info.plist Configuration (Zero-Code)

**Info.plist:**
```xml
<dict>
    <!-- Required -->
    <key>DeviceXTenant</key>
    <string>acme-corp</string>
    
    <!-- Required - use build settings for security -->
    <key>DeviceXAPIKey</key>
    <string>${DEVICE_X_API_KEY}</string>
    
    <!-- Optional - defaults to production -->
    <key>DeviceXEnvironment</key>
    <string>sandbox</string>
    
    <!-- Optional -->
    <key>DeviceXOrganizationId</key>
    <string>org-123</string>
</dict>
```

**Swift Code:**
```swift
// Zero-code configuration
try Devicex.configureGloballyFromPlist()

let devicex = try Devicex.instance
print("Configured from Info.plist")
print("Endpoint: \(devicex.config.ingestionEndpoint)")
```

### 7. Async Configuration

```swift
let devicex = try await Devicex.configureAsync { config in
    // Load API key asynchronously from Keychain
    let apiKey = try await loadAPIKeyFromKeychain()
    
    config.setTenant("acme")
    config.setApiKey(apiKey)
    config.setEnvironment(.production)
}

print("Initialized: \(await devicex.isInitialized)")
```

### 8. SwiftUI App Integration

```swift
import SwiftUI

@main
struct DeviceXApp: App {
    
    init() {
        configureDeviceX()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func configureDeviceX() {
        do {
            try Devicex.configureGlobally { config in
                config.setTenant("acme-corp")
                config.setApiKey(loadAPIKeySecurely())
                
                #if DEBUG
                config.setEnvironment(.sandbox)
                #else
                config.setEnvironment(.production)
                #endif
            }
            
            print("✅ DeviceX initialized")
            
        } catch {
            print("❌ Failed to initialize DeviceX: \(error)")
        }
    }
}
```

### 9. UIKit App Integration

```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        do {
            // Option 1: From Info.plist
            try Devicex.configureGloballyFromPlist()
            
        } catch {
            // Option 2: Programmatic fallback
            try? Devicex.configureGlobally { config in
                config.setTenant("acme-corp")
                config.setApiKey(loadAPIKeyFromKeychain())
                config.setEnvironment(.production)
            }
        }
        
        return true
    }
}
```

## Automatic Headers

The SDK automatically sets these headers:

| Header | Source | Description |
|--------|--------|-------------|
| `X-Api-Key` | `setApiKey()` | API authentication key |
| `X-Tenant` | `setTenant()` | Tenant identifier |
| `X-Organization-Id` | `setOrganizationId()` or tenant | Organization identifier |
| `Content-Type` | Automatic | Always `application/json` |

Custom headers can be added with `addHeader()` or `setHeaders()`.

## Environment Resolution

### Parsing Rules (Android Parity)

```swift
EnvironmentResolver.parseEnvironment("sandbox")   // .sandbox
EnvironmentResolver.parseEnvironment("SANDBOX")   // .sandbox
EnvironmentResolver.parseEnvironment("staging")   // .sandbox
EnvironmentResolver.parseEnvironment("stage")     // .sandbox

EnvironmentResolver.parseEnvironment("production") // .production
EnvironmentResolver.parseEnvironment("PRODUCTION") // .production
EnvironmentResolver.parseEnvironment("prod")       // .production

EnvironmentResolver.parseEnvironment("unknown")    // .production (default)
EnvironmentResolver.parseEnvironment("")           // .production (fail secure)
```

**Important:** Unknown environment strings default to **production** for security (fail secure).

## Validation

### Required Fields

- ✅ **Tenant**: Must be non-empty after trimming whitespace
- ✅ **API Key**: Must be non-empty after trimming whitespace

### HTTPS Enforcement

All URLs must use HTTPS:

```swift
// ✅ Allowed
try config.setBaseURL(URL(string: "https://secure.com")!)

// ❌ Rejected with ConfigurationError.insecureURL
try config.setBaseURL(URL(string: "http://insecure.com")!)
```

### Validation Timing

All validation occurs at **build time**, not at usage time:

```swift
// Validation happens here ↓
let config = try builder.build()

// Not here - config is already validated
devicex.sendEventAsync(...)
```

## Error Handling

### ConfigurationError

```swift
public enum ConfigurationError: Error {
    case missingTenant
    case missingAPIKey
    case insecureURL(URL)
    case invalidURLString(String)
    case invalidEnvironment(String)
}
```

### Example Error Handling

```swift
do {
    let devicex = try Devicex.configure { config in
        config.setTenant("acme")
        config.setApiKey(apiKey)
    }
    
} catch ConfigurationError.missingTenant {
    print("❌ Tenant is required")
    
} catch ConfigurationError.missingAPIKey {
    print("❌ API key is required")
    
} catch ConfigurationError.insecureURL(let url) {
    print("❌ URL must use HTTPS: \(url)")
    
} catch {
    print("❌ Configuration failed: \(error)")
}
```

## Security Best Practices

### ⚠️ Never Hardcode API Keys

```swift
// ❌ BAD - Never hardcode sensitive values
config.setApiKey("sk_live_abc123...")

// ✅ GOOD - Load from secure storage
let apiKey = try loadAPIKeyFromKeychain()
config.setApiKey(apiKey)

// ✅ GOOD - Use environment variables (development)
let apiKey = ProcessInfo.processInfo.environment["DEVICE_X_API_KEY"]!
config.setApiKey(apiKey)

// ✅ GOOD - Use Info.plist with build settings
// Info.plist: <string>${DEVICE_X_API_KEY}</string>
try Devicex.configureGloballyFromPlist()
```

### Recommended: Keychain Storage

```swift
import Security

func loadAPIKeyFromKeychain() throws -> String {
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrService as String: "com.yourapp.devicex",
        kSecAttrAccount as String: "api-key",
        kSecReturnData as String: true
    ]
    
    var result: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &result)
    
    guard status == errSecSuccess,
          let data = result as? Data,
          let apiKey = String(data: data, encoding: .utf8) else {
        throw KeychainError.notFound
    }
    
    return apiKey
}
```

### Recommended: Info.plist with Build Settings

**Info.plist:**
```xml
<key>DeviceXAPIKey</key>
<string>${DEVICE_X_API_KEY}</string>
```

**Build Settings (xcconfig or Xcode):**
```
DEVICE_X_API_KEY = your-api-key-here
```

Or use environment variables:
```bash
export DEVICE_X_API_KEY="your-api-key"
```

## Thread Safety

All configuration types are **Sendable** and thread-safe:

- ✅ `DeviceXEnvironment` - Enum (thread-safe)
- ✅ `DeviceXConfiguration` - Immutable struct with `let` properties
- ✅ `DeviceXConfiguration.Builder` - Designed for single-threaded use
- ✅ `Devicex` - Thread-safe singleton access

### Concurrent Configuration

```swift
// Multiple instances can be created concurrently
DispatchQueue.concurrentPerform(iterations: 10) { i in
    let devicex = try! Devicex.configure { config in
        config.setTenant("tenant-\(i)")
        config.setApiKey("key-\(i)")
    }
}
```

## Performance

Configuration is lightweight and fast:

- **Validation**: < 1ms
- **URL resolution**: Hardcoded, no network calls
- **Header construction**: Simple dictionary operations
- **Thread-safe**: No locking overhead for immutable config

**Benchmark (1000 configurations):**
```
testConfigurationPerformance: 0.015 sec
```

## Android Parity Matrix

| Feature | Android | iOS | Status |
|---------|---------|-----|--------|
| Environment enum | ✅ | ✅ | ✅ |
| Sandbox URL | ✅ | ✅ | ✅ |
| Production URL | ✅ | ✅ | ✅ |
| Events path template | ✅ | ✅ | ✅ |
| Environment parsing | ✅ | ✅ | ✅ |
| HTTPS enforcement | ✅ | ✅ | ✅ |
| Builder pattern | ✅ | ✅ | ✅ |
| Fluent API | ✅ | ✅ | ✅ |
| Tenant validation | ✅ | ✅ | ✅ |
| API key validation | ✅ | ✅ | ✅ |
| Organization ID | ✅ | ✅ | ✅ |
| Custom headers | ✅ | ✅ | ✅ |
| Custom base URL | ✅ | ✅ | ✅ |
| Default to production | ✅ | ✅ | ✅ |

## Migration from Android

The iOS API closely mirrors the Android API:

**Android (Kotlin):**
```kotlin
val config = DeviceIntelligenceConfig.Builder()
    .setTenant("acme")
    .setApiKey(apiKey)
    .setEnvironment(Environment.SANDBOX)
    .build()
```

**iOS (Swift):**
```swift
let config = try DeviceXConfiguration.Builder()
    .setTenant("acme")
    .setApiKey(apiKey)
    .setEnvironment(.sandbox)
    .build()
```

### Key Differences

1. **Initialization**: iOS uses throwing `build()` instead of nullable return
2. **Enums**: Swift uses lowercase cases (`.sandbox` vs `SANDBOX`)
3. **URL Type**: Swift uses `URL` type, not `String`
4. **Errors**: Swift uses typed errors, not exceptions

## Testing

Comprehensive test suite included:

- ✅ Environment resolution
- ✅ URL construction
- ✅ Validation rules
- ✅ HTTPS enforcement
- ✅ Environment parsing
- ✅ Header generation
- ✅ Builder API
- ✅ Global instance management
- ✅ Thread safety
- ✅ Performance benchmarks

Run tests:
```bash
xcodebuild test -scheme Devicex -destination 'platform=iOS Simulator,name=iPhone 15'
```

## Troubleshooting

### "Missing Tenant" Error

```swift
// ❌ Forgot to set tenant
let devicex = try Devicex.configure { config in
    config.setApiKey(apiKey)
}
// Error: ConfigurationError.missingTenant

// ✅ Fixed
let devicex = try Devicex.configure { config in
    config.setTenant("acme")
    config.setApiKey(apiKey)
}
```

### "Insecure URL" Error

```swift
// ❌ Using HTTP
try config.setBaseURL(URL(string: "http://api.example.com")!)
// Error: ConfigurationError.insecureURL

// ✅ Fixed - Use HTTPS
try config.setBaseURL(URL(string: "https://api.example.com")!)
```

### "Global Instance Not Initialized"

```swift
// ❌ Forgot to configure globally
let devicex = try Devicex.instance
// Error: DeviceXError.notInitialized

// ✅ Fixed
try Devicex.configureGlobally { config in
    config.setTenant("acme")
    config.setApiKey(apiKey)
}
let devicex = try Devicex.instance
```

## Summary

The DeviceX configuration system provides:

1. ✅ **Production-ready** configuration management
2. ✅ **Android parity** for seamless cross-platform development
3. ✅ **Security-first** with HTTPS enforcement
4. ✅ **Flexible** with multiple configuration methods
5. ✅ **Type-safe** with Swift's strong typing
6. ✅ **Thread-safe** with Sendable conformance
7. ✅ **Well-tested** with comprehensive test coverage
8. ✅ **Well-documented** with extensive examples

The system is ready for production use and maintains full compatibility with the Android SDK implementation.
