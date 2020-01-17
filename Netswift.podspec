#
# Be sure to run `pod lib lint Netswift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name              = 'Netswift'
    s.version           = '0.2.0'
    s.summary           = 'A high-level, type-safe networking solution for Swift apps'
    s.swift_version     = '5.0'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    Networking in Swift can be tedious from the get go. Type safety & reusability are often overlooked for the sake of getting up to speed. This is where Netswift comes in!
    
    Netswift allows you to easily write network calls in a very structured and maintainable way. It does so by using protocols with associated types & generic classes very extensively.
    DESC
    
    s.homepage         = 'https://github.com/MrSkwiggs/Netswift'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Dorian Grolaux' => 'dorian@skwiggs.dev' }
    s.source           = { :git => 'https://github.com/MrSkwiggs/Netswift.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '8.0'
    
    s.source_files = 'Sources/**/*.swift'
    
    # s.resource_bundles = {
    #   'Netswift' => ['Netswift/Assets/*.png']
    # }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'
end
