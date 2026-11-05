# CXoneGuideUtility

## Overview
CXoneGuideUtility is a robust logging framework designed for iOS applications, providing flexible and powerful logging capabilities through a clean, type-safe interface.


## Requirements
- iOS 16.0+
- Swift 6.0+ (Xcode 16 or later)


## Modules

- Utility
- [Core](https://github.com/nice-devone/nice-cxone-mobile-sdk-ios)
- [UI](https://github.com/nice-devone/nice-cxone-mobile-ui-ios)
- [Sample](https://github.com/nice-devone/nice-cxone-mobile-sample-ios)

## Core Architecture

### 1. LogWriter Protocol
The foundation of the logging system that defines the basic logging behavior:

```swift
public protocol LogWriter {
    func log(record: LogRecord)
}
```

### 2. Core Writers

#### PrintLogWriter
Console output logging:

```swift
let writer = PrintLogWriter()
```

#### FileLogWriter
File-based logging:

```swift
let writer = FileLogWriter(path: fileURL)
```

#### SystemLogWriter
System logging using os.Logger:

```swift
let writer = SystemLogWriter()
```

#### ForkLogWriter
Multi-destination logging:

```swift
let writer = ForkLogWriter(
    FileLogWriter(path: fileURL),
    PrintLogWriter()
)
```

### 3. Configuration Options

#### Filters
Control log output:

```swift
// Level-based filtering
logWriter.filter(level: .warning)

// Category-based filtering
logWriter.filter(categories: "NETWORK")
```

#### Formatters
Control log appearance:

```swift
logWriter.format(.simple)
logWriter.format(.full)
```

## Implementation Guide

### Basic Setup

```swift
enum Log: StaticLogger {
    nonisolated(unsafe) static var instance: (any LogWriter)? = PrintLogWriter()
    static let category: String? = "Application"
}
```

### Advanced Configuration

Compose writers, formatters and filters, then assign the result to your logger's `instance`:

```swift
Log.instance = ForkLogWriter(
    PrintLogWriter(),
    FileLogWriter(path: fileURL),
    SystemLogWriter()
).format(.full)
```

The sample app wraps this composition in its own `Log.configure(format:isPrintEnabled:isWriteToFileEnabled:isCrashlyticsEnabled:isSystemEnabled:)` helper (`sample/iOSSDKExample/Sources/Utilities/Log/Log.swift`); it is sample-app code, not part of CXoneGuideUtility.

## Usage Examples

### Basic Logging

```swift
Log.trace("Debug message")
Log.warning("Warning message")
Log.error("Error message")
```

### Category-based Logging

```swift
Log.info("Network request started", category: "NETWORK")
Log.log("Network request started", level: .debug, category: "NETWORK")
```

### Multi-destination Logging

```swift
Log.instance = ForkLogWriter(
    FileLogWriter(path: fileURL).format(.full),
    PrintLogWriter().format(.simple)
).filter(level: .warning)
```

## File Management

`FileLogWriter` appends to the file at the URL you pass; CXoneGuideUtility does not share or delete log files. Manage the file yourself — for example with `FileManager.default.removeItem(at: fileURL)` — or see the sample app's `Log.logFileUrl` and `Log.removeLogs()` helpers (sample-app code, not framework API).

## Integration Support

### SDK Integration
CXoneChat and CXoneChatUI log through their own writers. Both default to a `PrintLogWriter`, so they print to the console until you replace the writer — or set it to `nil` to turn their logging off, e.g. in release builds:

```swift
CXoneChat.logWriter = writer
CXoneChatUI.LogManager.instance = writer

// Or silence both
CXoneChat.logWriter = nil
CXoneChatUI.LogManager.instance = nil
```

## Best Practices
- Configure appropriate log levels for different environments
- Use categories for better log organization
- Implement proper error handling
- Regular log file maintenance
