# GDGeoData

[![CI Status](http://img.shields.io/travis/knutigro/GDGeoData.svg?style=flat)](https://travis-ci.org/Knut Inge Grosland/GDGeoData)
[![Version](https://img.shields.io/cocoapods/v/GDGeoData.svg?style=flat)](http://cocoadocs.org/docsets/GDGeoData)
[![License](https://img.shields.io/cocoapods/l/GDGeoData.svg?style=flat)](http://cocoadocs.org/docsets/GDGeoData)
[![Platform](https://img.shields.io/cocoapods/p/GDGeoData.svg?style=flat)](http://cocoadocs.org/docsets/GDGeoData)

Swift wrapper for easy use of country and region data. [DataSource](https://github.com/knutigro/ISO-3166-Countries-with-Regional-Codes).

## Usage

```
if let norway = GDCountry(name: "Norway") {
    println("testCountryLoadedByName \(norway.description)")
}
```

List all countries
```
GDCountry.countries
```

## Installation

GDGeoData is available through [CocoaPod](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

CocoaPods 0.36 adds supports for Swift and embedded frameworks. You can install it with the following command:

```
$ gem install cocoapods
```

To integrate GDGeoData into your Xcode project using CocoaPods, specify it in your Podfile:

```
pod 'GDGeoData', '~> 0.1'
```

Then, run the following command:

```
$ pod install
```

## Author

Knut Inge Grosland, ”hei@knutinge.com”

## License

GDGeoData is available under the MIT license. See the LICENSE file for more info.

