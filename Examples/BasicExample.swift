import Foundation
import VisionOS-UI-Framework

/// Basic example demonstrating the core functionality of VisionOS-UI-Framework
@main
struct BasicExample {
    static func main() {
        print("🚀 VisionOS-UI-Framework Basic Example")
        
        // Initialize the framework
        let framework = VisionOS-UI-Framework()
        
        // Configure with default settings
        framework.configure()
        
        print("✅ Framework configured successfully")
        
        // Demonstrate basic functionality
        demonstrateBasicFeatures(framework)
    }
    
    static func demonstrateBasicFeatures(_ framework: VisionOS-UI-Framework) {
        print("\n📱 Demonstrating basic features...")
        
        // Add your example code here
        print("🎯 Feature 1: Core functionality")
        print("🎯 Feature 2: Configuration")
        print("🎯 Feature 3: Error handling")
        
        print("\n✨ Basic example completed successfully!")
    }
}
