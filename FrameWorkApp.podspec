Pod::Spec.new do |spec|

  spec.name         = "FrameWorkApp"
  spec.version      = "1.1.11"
  spec.summary      = "FrameWorkApp is a framework."
  spec.description  = "FrameWorkApp is a swift framework which has a logger class and printHelloWorld func"
  spec.homepage     = "https://github.com/IMiMineDigital/FrameWorkApp"
  spec.license      = "MIT"

  spec.author       = { "IMiMineDigital" => "48542324+IMiMineDigital@users.noreply.github.com" }
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/IMiMineDigital/FrameWorkApp.git", :tag => "1.1.11" }
  spec.source_files = "FrameWorkApp.framework/Headers/*.{h,m.Objective C}"
  spec.public_header_files = "FrameWorkApp.framework/Headers/*.{h,m.Objective C}"

  spec.vendored_frameworks = "FrameWorkApp.framework"
  spec.exclude_files = "FrameWorkApp/Exclude"
  spec.ios.deployment_target  = '9.0'
  spec.requires_arc = true

 
end