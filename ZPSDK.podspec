#
#  Be sure to run `pod spec lint ZPSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|


  spec.name         = "ZPSDK"
  spec.version      = "0.1.3"
  spec.summary      = "A short description of ZPSDK."

  spec.description  = "zhangpengSDK"

  spec.homepage     = "https://github.com/LeiWon9fbank/Zhangpeng"


  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "zhangpeng" => "522623697@qq.com" }


  spec.source       = { :git => "https://github.com/LeiWon9fbank/Zhangpeng.git", :tag => "#{spec.version}" }

  spec.vendored_frameworks = 'ZPSDK.framework'
  spec.frameworks = "Foundation"


  #依赖第三方框架
  #spec.dependency 'AFNetworking','~>4.0.0'
  #spec.dependency 'YYModel'
  #spec.dependency 'Toast'

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"

  spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
