#
# Be sure to run `pod lib lint WebView-Utilities.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WebView-Utilities'
  s.version          = '0.0.1'
  s.summary          = 'A library of helper functions to manipulate the DOM within a WKWebView.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A library of helper functions (available through an extension to WKWebView) to manipulate the DOM within a WKWebView. Functions available:
* stripAllOtherElementsFromBody - removes all except one element from HTML body.
* clearHead - removes all inner HTML from the head element.
* addElementToHead - adds an element to the head.
* removeElement - removes an element from the DOM.
* addCSS - add CSS to the document head.
                       DESC

  s.homepage         = 'https://github.com/StevenPreston/webview-utilities'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Steven Preston' => 'stevenpreston@stellar16.com' }
  s.source           = { :git => 'https://github.com/StevenPreston/webview-utilities.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/StevenPreston'

  s.ios.deployment_target = '8.0'

  s.source_files = 'WebView-Utilities/Classes/**/*'
  
  # s.resource_bundles = {
  #   'WebView-Utilities' => ['WebView-Utilities/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
