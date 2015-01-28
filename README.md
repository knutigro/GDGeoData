# GDGeoData

[![CI Status](http://img.shields.io/travis/Knut Inge Grosland/GDGeoData.svg?style=flat)](https://travis-ci.org/Knut Inge Grosland/GDGeoData)
[![Version](https://img.shields.io/cocoapods/v/GDGeoData.svg?style=flat)](http://cocoadocs.org/docsets/GDGeoData)
[![License](https://img.shields.io/cocoapods/l/GDGeoData.svg?style=flat)](http://cocoadocs.org/docsets/GDGeoData)
[![Platform](https://img.shields.io/cocoapods/p/GDGeoData.svg?style=flat)](http://cocoadocs.org/docsets/GDGeoData)

Swift wrapper for easy use of country and region data. [DataSource](https://github.com/knutigro/ISO-3166-Countries-with-Regional-Codes).

## Usage

GDGeoData can be imported into both Swift and Objective-C projects.

Objective-C example: 

```Objective-C
#import "GDGeoData/GDGeoData-Swift.h"

x@interface GDCountry (Dummy)
+ (instancetype)alloc;
@end

@interface GDRegion (Dummy)
+ (instancetype)alloc;
@end

@interface GDSubRegion (Dummy)
+ (instancetype)alloc;
@end

NSLog(@"all countries count %li", (long)[GDCountry allCountries].count);

GDCountry *country = [[GDCountry alloc] initWithName:@"Norway"];
NSLog(@"Norway %@", country.description);
```

## Installation

GDGeoData is available through a private [CocoaPod](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod 'GDGeoData', :git => 'https://github.com/knutigro/GDGeoData.git'


## Author

Knut Inge Grosland, ”hei@knutinge.com”

## License

GDGeoData is available under the MIT license. See the LICENSE file for more info.

