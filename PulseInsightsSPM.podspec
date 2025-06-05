#
# Be sure to run `pod lib lint PulseInsightsSPM.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PulseInsightsSPM'
  s.module_name      = 'PulseInsights'
  s.version          = '1.0.13'
  s.summary          = 'PulseInsights survey solution for iOS app.'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
  s.description      = <<-DESC
  PulseInsights survey solution for iOS app. Swift Package Manager version.
                       DESC
  s.homepage         = 'https://pulseinsights.com'
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { 'Pulse Insights' => 'hello@pulseinsights.com' }
  s.source           = { :git => 'https://github.com/Pulse-Insights/pi-ios-spm.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '14.0'
  s.swift_version = '5.0'
  
  s.source_files = 'PulseInsights/Sources/PulseInsights/**/*.swift'
  s.resource_bundles = {
    'PulseInsightsSPM' => ['PulseInsights/Sources/PulseInsights/images.xcassets', 'PulseInsights/Sources/PulseInsights/*.xib']
  }
  
  s.frameworks = 'UIKit'
  
end 
