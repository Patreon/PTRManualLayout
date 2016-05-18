#
# Be sure to run `pod lib lint PTRManualLayout.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name           = "PTRManualLayout"
    s.version        = "0.7.0"
    s.summary        = "Easily layout your UIs in code"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
PTRManualLayout provides a set of utilities to easily lay out your views in code
                       DESC

  s.homepage         = "https://github.com/Patreon/ManualLayout"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author           = { "Sam Morrison" => "samo@patreon.com", "David Kettler" => "david@patreon.com" }
  s.source           = { :git => "https://github.com/Patreon/ManualLayout.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.1'

  s.source_files = 'PTRManualLayout/Classes/**/*'

  # s.resource_bundles = {
  #   'PTRManualLayout' => ['PTRManualLayout/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'Realm', '~> 0.102.1'
end
