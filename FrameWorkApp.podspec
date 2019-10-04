Pod::Spec.new do |spec|

  spec.name         = "FrameWorkApp"
  spec.version      = "1.0.2"
  spec.summary      = "FrameWorkApp is a framework."
  spec.description  = "FrameWorkApp is a swift framework which has a logger class and printHelloWorld func"
  spec.homepage     = "https://github.com/IMiMineDigital/FrameWorkApp"
  spec.license      = "MIT"

  spec.author       = { "IMiMineDigital" => "48542324+IMiMineDigital@users.noreply.github.com" }
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/IMiMineDigital/FrameWorkApp.git", :tag => "1.0.2" }
  spec.source_files  = "FrameWorkApp", "FrameWorkApp/**/*.{h,m.Objective C}"
  spec.exclude_files = "FrameWorkApp/Exclude"
  spec.requires_arc = true

  
end