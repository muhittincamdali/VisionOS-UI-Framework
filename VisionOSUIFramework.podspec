Pod::Spec.new do |s|
  s.name             = 'VisionOSUIFramework'
  s.version          = '1.0.0'
  s.summary          = 'UI framework for visionOS with spatial computing components.'
  s.description      = <<-DESC
    VisionOSUIFramework provides UI components for visionOS spatial computing.
    Features include 3D UI elements, spatial layouts, hand gesture support,
    eye tracking integration, and immersive view components.
  DESC

  s.homepage         = 'https://github.com/muhittincamdali/VisionOS-UI-Framework'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Muhittin Camdali' => 'contact@muhittincamdali.com' }
  s.source           = { :git => 'https://github.com/muhittincamdali/VisionOS-UI-Framework.git', :tag => s.version.to_s }

  s.visionos.deployment_target = '1.0'
  s.ios.deployment_target = '17.0'

  s.swift_versions = ['5.9', '5.10', '6.0']
  s.source_files = 'Sources/**/*.swift'
  s.frameworks = 'Foundation', 'SwiftUI', 'RealityKit'
end
