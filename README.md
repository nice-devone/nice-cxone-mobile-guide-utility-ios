# CXoneGuideUtility Documentation

## Overview
CXoneGuideUtility is a robust logging framework designed for iOS applications, providing flexible and powerful logging capabilities through a clean, type-safe interface.

## Requirements
- iOS 15.0+
- Swift 5+

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
logWriter.filter(minLevel: .warning)

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
    nonisolated(unsafe) static var instance: LogWriter = PrintLogWriter()
    static let category: String? = "Application"
}
```

### Advanced Configuration

```swift
Log.configure(
    format: .full,
    isPrintEnabled: true,
    isWriteToFileEnabled: true,
    isCrashlyticsEnabled: true,
    isSystemEnabled: true
)
```

## Usage Examples

### Basic Logging

```swift
Log.trace("Debug message")
Log.warning("Warning message")
Log.error("Error message")
```

### Category-based Logging

```swift
Log.log("Network request started", category: "NETWORK")
```

### Multi-destination Logging

```swift
Log.instance = ForkLogWriter(
    FileLogWriter(path: fileURL).format(.full),
    PrintLogWriter().format(.simple)
).filter(minLevel: .warning)
```

## File Management

### Log Sharing

```swift
let shareDialog = try Log.getLogShareDialog()
```

### Log Cleanup

```swift
try Log.removeLogs()
```

## Integration Support

### SDK Integration
The logger automatically integrates with:
- CXoneChat
- CXoneChatUI

## Best Practices
- Configure appropriate log levels for different environments
- Use categories for better log organization
- Implement proper error handling
- Regular log file maintenance
