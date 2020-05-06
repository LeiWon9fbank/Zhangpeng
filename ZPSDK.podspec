#
#  Be sure to run `pod spec lint ZPSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "ZPSDK"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of ZPSDK."

  spec.description  = "zhangpengSDK"

  spec.homepage     = "https://github.com/LeiWon9fbank/Zhangpeng"


  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "zhangpeng" => "522623697@qq.com" }


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  spec.source       = { :git => "https://github.com/LeiWon9fbank/Zhangpeng.git", :tag => "#{spec.version}" }




 
  spec.vendored_frameworks = 'ZPSDK.framework'
  spec.frameworks = "Foundation"


  #依赖第三方框架
  #spec.dependency 'AFNetworking'
  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"

  spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
