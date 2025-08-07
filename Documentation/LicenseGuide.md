# License Guide

## Overview

This guide explains the licensing terms and usage rights for the VisionOS UI Framework.

## Table of Contents

- [License Information](#license-information)
- [Usage Rights](#usage-rights)
- [Attribution](#attribution)
- [Commercial Use](#commercial-use)
- [Modifications](#modifications)
- [Distribution](#distribution)
- [Limitations](#limitations)

## License Information

### MIT License

The VisionOS UI Framework is licensed under the MIT License, a permissive open-source license that allows for:

- Commercial use
- Modification
- Distribution
- Private use

### License Text

```
MIT License

Copyright (c) 2024 Muhittin Camdali

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## Usage Rights

### What You Can Do

✅ **Commercial Use**: Use in commercial applications
✅ **Modification**: Modify the code for your needs
✅ **Distribution**: Distribute modified versions
✅ **Private Use**: Use in private projects
✅ **Sublicensing**: Sublicense the software

### What You Must Do

📋 **Include License**: Include the MIT license text
📋 **Attribution**: Give appropriate credit
📋 **Copyright Notice**: Include copyright notice

## Attribution

### Required Attribution

When using the VisionOS UI Framework, include:

```swift
// In your app's credits or about section
"VisionOS UI Framework by Muhittin Camdali (MIT License)"
```

### Recommended Attribution

```swift
// In your README.md
"This project uses the VisionOS UI Framework by Muhittin Camdali, 
licensed under the MIT License."
```

## Commercial Use

### Commercial Applications

You can use the framework in:

- Commercial iOS/VisionOS apps
- Enterprise applications
- Paid software
- Freemium applications
- Subscription services

### No Royalties

- No royalties required
- No revenue sharing
- No licensing fees
- No restrictions on monetization

## Modifications

### Modifying the Code

You can:

- Modify any part of the framework
- Add new features
- Remove unwanted functionality
- Customize for your needs
- Fork and maintain your own version

### Distribution of Modifications

When distributing modified versions:

- Include the original MIT license
- Include the original copyright notice
- Clearly indicate your modifications
- Provide source code if requested

## Distribution

### Distribution Rights

You can distribute:

- Original framework
- Modified versions
- Compiled applications using the framework
- Documentation and examples

### Distribution Requirements

When distributing:

```markdown
# Include in your distribution

1. Original MIT license text
2. Copyright notice: "Copyright (c) 2024 Muhittin Camdali"
3. Attribution to original author
4. Clear indication of any modifications
```

## Limitations

### No Warranty

The software is provided "as is" without warranty:

- No guarantee of functionality
- No guarantee of compatibility
- No guarantee of performance
- No guarantee of security

### No Liability

The authors are not liable for:

- Any damages from use
- Data loss or corruption
- Security vulnerabilities
- Compatibility issues

## Examples

### Proper Attribution in README

```markdown
# My VisionOS App

A spatial computing application built with VisionOS UI Framework.

## Dependencies

- **VisionOS UI Framework** by Muhittin Camdali (MIT License)
  - Provides spatial UI components and 3D interactions
  - [GitHub Repository](https://github.com/muhittincamdali/VisionOS-UI-Framework)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
```

### Proper Attribution in Code

```swift
// AppDelegate.swift or main app file
import VisionUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init() {
        // Initialize VisionOS UI Framework
        // Framework by Muhittin Camdali (MIT License)
        VisionUIManager.configure()
    }
}
```

### License File Example

```markdown
# LICENSE

MIT License

Copyright (c) 2024 Your Name

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

---

## Third-Party Licenses

### VisionOS UI Framework
MIT License - Copyright (c) 2024 Muhittin Camdali
```

This License Guide ensures proper understanding and compliance with the MIT License terms.
