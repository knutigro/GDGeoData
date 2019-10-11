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
  s.version          = "0.4.0"
  s.summary          = "Swift wrapper for easy use of countries and regiones with ISO codes"
  s.description      = <<-DESC
                        Swift wrapper for easy use of country and region data from https://github.com/knutigro/ISO-3166-Countries-with-Regional-Codes
                        DESC
  s.homepage         = "https://github.com/knutigro/GDGeoData"
  s.license          = 'MIT'
  s.author           = { "Knut Inge Grosland" => "”hei@knutinge.com”" }
  s.source           = { :git => "https://github.com/knutigro/GDGeoData.git", :tag => s.version }
  s.swift_version    = '5.0'
  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'
  s.requires_arc = true

  s.source_files = 'GDGeoData/Classes/*.swift'
  s.resource_bundles = {
    'GDGeoData' => ['GDGeoData/Assets/*.json']
  }
end
