# Contributing Guide

## Overview

Thank you for your interest in contributing to the VisionOS UI Framework! This guide provides information on how to contribute effectively.

## Table of Contents

- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Code Standards](#code-standards)
- [Testing](#testing)
- [Documentation](#documentation)
- [Pull Request Process](#pull-request-process)
- [Code of Conduct](#code-of-conduct)

## Getting Started

### Prerequisites

- **Xcode**: 15.0 or later
- **VisionOS**: 1.0 or later
- **Swift**: 5.9 or later
- **Git**: Latest version

### Fork and Clone

```bash
# Fork the repository on GitHub
# Clone your fork
git clone https://github.com/your-username/VisionOS-UI-Framework.git
cd VisionOS-UI-Framework

# Add upstream remote
git remote add upstream https://github.com/muhittincamdali/VisionOS-UI-Framework.git
```

## Development Setup

### Project Structure

```
VisionOS-UI-Framework/
├── Sources/
│   ├── VisionUI/
│   ├── VisionUISpatial/
│   ├── VisionUIGestures/
│   └── VisionUIAccessibility/
├── Tests/
├── Examples/
├── Documentation/
└── Package.swift
```

### Building the Project

```bash
# Build the framework
swift build

# Run tests
swift test

# Build for VisionOS
xcodebuild -scheme VisionOS-UI-Framework -destination 'platform=visionOS Simulator,name=Apple Vision Pro'
```

## Code Standards

### Swift Style Guide

- Follow [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- Use SwiftLint for code formatting
- Maximum line length: 120 characters
- Use meaningful variable and function names

### Code Example

```swift
// Good: Clear, descriptive naming
func createSpatialButton(title: String, action: @escaping () -> Void) -> SpatialButton {
    return SpatialButton(title) {
        action()
    }
}

// Good: Proper documentation
/// Creates a spatial button with the specified title and action.
/// - Parameters:
///   - title: The button title
///   - action: The action to perform when tapped
/// - Returns: A configured SpatialButton
public func createSpatialButton(title: String, action: @escaping () -> Void) -> SpatialButton {
    return SpatialButton(title) {
        action()
    }
}
```

### Architecture Guidelines

- Follow Clean Architecture principles
- Use dependency injection
- Implement proper error handling
- Write testable code
- Use protocols for abstraction

## Testing

### Writing Tests

```swift
import XCTest
import VisionUI

@available(visionOS 1.0, *)
class SpatialComponentTests: XCTestCase {
    
    func testSpatialComponentCreation() {
        // Given
        let title = "Test Button"
        
        // When
        let component = SpatialButton(title) {
            // Action
        }
        
        // Then
        XCTAssertNotNil(component)
        XCTAssertEqual(component.title, title)
    }
    
    func testSpatialComponentConfiguration() {
        // Given
        let component = SpatialComponent()
        
        // When
        component.configure()
        
        // Then
        XCTAssertTrue(component.isConfigured)
    }
}
```

### Test Coverage

- Aim for 90%+ test coverage
- Test all public APIs
- Include unit tests, integration tests, and performance tests
- Test edge cases and error conditions

## Documentation

### Code Documentation

```swift
/// A spatial button component for VisionOS applications.
///
/// This component provides a 3D interactive button that responds to spatial interactions
/// including hand gestures, eye tracking, and voice commands.
///
/// ## Example Usage
/// ```swift
/// let button = SpatialButton("Tap Me") {
///     print("Button tapped!")
/// }
/// ```
///
/// - Note: This component requires VisionOS 1.0 or later.
/// - Important: Always configure accessibility features for inclusive design.
@available(visionOS 1.0, *)
public struct SpatialButton: View {
    // Implementation
}
```

### Documentation Standards

- Document all public APIs
- Include usage examples
- Explain complex algorithms
- Update documentation with code changes
- Use clear, concise language

## Pull Request Process

### Before Submitting

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes**
4. **Write tests**
5. **Update documentation**
6. **Run all tests**
   ```bash
   swift test
   ```

### Pull Request Guidelines

- **Title**: Clear, descriptive title
- **Description**: Detailed description of changes
- **Tests**: Include relevant tests
- **Documentation**: Update documentation if needed
- **Breaking Changes**: Clearly mark breaking changes

### Example Pull Request

```markdown
## Description
Adds support for custom spatial gestures in the VisionUI framework.

## Changes
- Added `CustomGesture` struct
- Implemented gesture recognition system
- Added gesture configuration options
- Updated documentation

## Testing
- Added unit tests for gesture recognition
- Added integration tests for gesture handling
- All tests pass

## Breaking Changes
None

## Checklist
- [x] Code follows style guidelines
- [x] Tests added and passing
- [x] Documentation updated
- [x] No breaking changes
```

## Code of Conduct

### Our Standards

- Be respectful and inclusive
- Use welcoming and inclusive language
- Be collaborative and constructive
- Focus on what is best for the community
- Show empathy towards other community members

### Enforcement

- Unacceptable behavior will not be tolerated
- Violations will be addressed promptly
- Maintainers have the right to remove contributions
- Community members should report violations

### Reporting Issues

If you experience or witness unacceptable behavior:

1. Contact the project maintainers
2. Provide specific details about the incident
3. Include relevant context and evidence
4. Expect a timely response

## Getting Help

### Resources

- **Issues**: Use GitHub Issues for bug reports and feature requests
- **Discussions**: Use GitHub Discussions for questions and ideas
- **Documentation**: Check the comprehensive documentation
- **Examples**: Review example implementations

### Contact

- **Email**: [project-email]
- **GitHub**: [@muhittincamdali](https://github.com/muhittincamdali)
- **Discussions**: [GitHub Discussions](https://github.com/muhittincamdali/VisionOS-UI-Framework/discussions)

Thank you for contributing to the VisionOS UI Framework!
