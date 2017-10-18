working_path = Dir.pwd
Pod::Spec.new do |spec|
  spec.name = "UC360SDK"
  spec.version = "1.0"
  spec.summary = "ULTRACAST 360° Virtual Reality Player for iOS Apps"
  spec.homepage = "http://ultracast.com"
  spec.license = { type: 'custom', file: 'LICENSE' }
  spec.authors = { "ULTRACAST Team" => 'help@ultracast.com' }
  
  spec.platform = :ios, "9.2"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/ultracast/ULTRACAST-360-IOS-SDK.git", tag: "v#{spec.version}", submodules: true }
  spec.ios.vendored_frameworks = "UC360SDK.framework"
end