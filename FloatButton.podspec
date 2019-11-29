#
# Be sure to run `pod lib lint FloatButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FloatButton'
  s.version          = '0.1.0'
  s.summary          = '悬浮按钮 FloatButton'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
自定义悬浮按钮，可随手势在屏幕任意位置滑动，类似于苹果手机自带辅助触控按钮！Swift5.0版本
                       DESC

  s.homepage         = 'https://github.com/SmallaXQ/FloatButton'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SmallaXQ' => 'smallaxq@gmail.com' }
  s.source           = { :git => 'https://github.com/SmallaXQ/FloatButton.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'FloatButton/Classes/**/*'
  
  # s.resource_bundles = {
  #   'FloatButton' => ['FloatButton/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
