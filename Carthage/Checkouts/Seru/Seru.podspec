Pod::Spec.new do |s|

  s.name         = "Seru"
  s.version      = "0.0.4"
  s.summary      = "Seru is Simple Core Data stack"
  s.description  = <<-DESC
                   Seru is Swift framework for working wit Core Data. It setup your core data stack and 
                   gives you nica actions to work with it
                   DESC

  s.homepage     = "https://github.com/kostiakoval/Seru"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Kostiantyn Koval" => "konstantin.koval1@gmail.com" }
  s.social_media_url   = "http://twitter.com/kostiakoval"

  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/kostiakoval/Seru.git", :tag => s.version }

  s.source_files  = "Seru/Classes/**/*.{swift}"
  s.requires_arc = true
  #s.ios.vendored_frameworks = 'Carthage/Build/iOS/Sweet.framework'
  #s.preserve_paths = 'Carthage/Build/iOS/Sweet.framework'

end
