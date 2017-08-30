
Pod::Spec.new do |s|


  s.name         = "YGTool"
  s.version      = "1.0"
  s.summary      = "工具类"

  s.description  = <<-DESC
                   YGTool 保存一些常用工具类
                   DESC

  s.homepage     = "https://github.com/wyggg/YGClass-.git"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"



  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "wuyinggang" => "773678819@qq.com" }
  # Or just: s.author    = "wuyinggang"
  # s.authors            = { "wuyinggang" => "773678819@qq.com" }
  # s.social_media_url   = "http://twitter.com/wuyinggang"

  # s.platform     = :ios
  s.platform     = :ios, "7.0"

  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/wyggg/YGClass-.git", :tag => "#{s.version}" }

  s.source_files  = "YGClassCollection", "YGClassCollection/YGClass/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  s.frameworks  = "Accelerate","UIKit"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency "Masonry", "~> 1.0.2"
  s.dependency "SDWebImage", "~> 4.0.0"

end
