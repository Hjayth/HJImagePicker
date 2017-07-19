
Pod::Spec.new do |s|

  s.name         = "HJImagePicker"
  s.version      = "0.0.1"
  s.summary      = "imagePicker"

  s.description  = <<-DESC
            模仿咸鱼的ImagePicker
                   DESC

  s.homepage     = "https://github.com/Hjayth/HJImagePicker"

  s.license      = "MIT"


  s.author             = { "hjayth" => "18622995206@163.com" }


  s.platform     = :ios, "8.0"


  s.ios.deployment_target = "8.0"


  s.source       = { :git => "https://github.com/Hjayth/HJImagePicker.git", :tag => "#{s.version}" }



  s.source_files  ="HJImagePicker/*.{h,m}"


  s.resource  = "HJImagePicker/imagePicker.xcassets"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  s.framework  = "Photos"
  # s.frameworks = "SomeFramework", "AnotherFramework"


  s.requires_arc = true

  s.dependency "Masonry", "~> 1.0.2"

end
