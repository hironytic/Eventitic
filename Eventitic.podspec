#
# Be sure to run `pod lib lint Eventitic.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Eventitic"
  s.version          = "1.0.0"
  s.summary          = "Dispatching and listening events"

  s.description      = <<-DESC
                       This pod provides an event source object which dispatches events to listeners.
                       DESC

  s.homepage         = "https://github.com/hironytic/Eventitic"
  s.license          = 'MIT'
  s.author           = { "Hironori Ichimiya" => "hiron@hironytic.com" }
  s.source           = { :git => "https://github.com/hironytic/Eventitic.git", :tag => "v#{s.version}" }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Sources/**/*'
end
