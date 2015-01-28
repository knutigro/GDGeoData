#
# Be sure to run `pod lib lint GDGeoData.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "GDGeoData"
  s.version          = "0.1.2"
  s.summary          = "Swift wrapper for easy use of countries and regiones with ISO codes"
  s.description      = <<-DESC
                        Swift wrapper for easy use of country and region data from https://github.com/knutigro/ISO-3166-Countries-with-Regional-Codes
                        DESC
  s.homepage         = "https://github.com/knutigro/GDGeoData"
  s.license          = 'MIT'
  s.author           = { "Knut Inge Grosland" => "”hei@knutinge.com”" }
  s.source           = { :git => "https://github.com/knutigro/GDGeoData.git", :tag => "0.1.2" }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'GDGeoData' => ['Pod/Assets/*.json']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
