//
//  GDCountry.swift
//  GDGeoData
//
//Copyright (c) 2015 Knut Inge Grosland
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
//

import Foundation

let kCountryName = "name"
let kCountryAlpha2 = "alpha-2"
let kCountryAlpha3 = "alpha-3"
let kCountryCode = "country-code"
let kCountryIso_3166_2 = "iso_3166-2"

let kGDCountryJSONFilePath = "GDCountries"

@objc public class GDCountry : GDGeoDataObjectProtocol {

    public var name : String?
    public var code : String?
    public var alpha2 : String?
    public var alpha3 : String?
    public var iso_3166_2 : String?
    public var region : GDRegion?
    public var subRegion : GDSubRegion?
    public var regionCode : String?
    public var subRegionCode : String?
    
    public var debugDescription : String {
        var description = "Country -"
        description += " Name: " + (name ?? "nil")
        description += " Alpha2: " + (alpha2 ?? "nil")
        description += " Alpha3: " + (alpha3 ?? "nil")
        description += " CountryCode: " + (code ?? "nil")
        description += " Iso_3166_2: " + (iso_3166_2 ?? "nil")
        description += " RegionCode: " + (regionCode ?? "nil")
        description += " SubRegionCode: " + (subRegionCode ?? "nil")
        description += " Region: " + (region?.name ?? "nil")
        description += " SubRegion: " + (subRegion?.name ?? "nil")

        return description
    }
    
    public var description : String {
        var description = "Country -"
        description += "\nName: " + (name ?? "nil")
        description += "\nAlpha2: " + (alpha2 ?? "nil")
        description += "\nAlpha3: " + (alpha3 ?? "nil")
        description += "\nCountryCode: " + (code ?? "nil")
        description += "\nIso_3166_2: " + (iso_3166_2 ?? "nil")
        description += "\nRegionCode: " + (regionCode ?? "nil")
        description += "\nSubRegionCode: " + (subRegionCode ?? "nil")
        description += "\nRegion: " + (region?.name ?? "nil")
        description += "\nSubRegion: " + (subRegion?.name ?? "nil")
        
        return description
    }
    
    // MARK:  Initializers

    public convenience init(dictionary : NSDictionary) {
        self.init()
        name = dictionary[kCountryName] as? String
        alpha2 = dictionary[kCountryAlpha2] as? String
        alpha3 = dictionary[kCountryAlpha3] as? String
        code = dictionary[kCountryCode] as? String
        iso_3166_2 = dictionary[kCountryIso_3166_2] as? String
        regionCode = dictionary[kRegionCode] as? String
        subRegionCode = dictionary[kSubRegionCode] as? String
        if let regionCode = regionCode {
            region = GDRegion(code: regionCode)
            if let region = region {
                if let subRegionCode = subRegionCode {
                    subRegion = GDSubRegion(code: subRegionCode, region: region)
                }
            }
        }
    }

    public convenience init?(country : GDCountry?) {
        self.init()
        if let countryTemp = country {
            name = countryTemp.name
            alpha2 = countryTemp.alpha2
            alpha3 = countryTemp.alpha3
            code = countryTemp.code
            iso_3166_2 = countryTemp.iso_3166_2
            regionCode = countryTemp.regionCode
            subRegionCode = countryTemp.subRegionCode
            region = countryTemp.region
            subRegion = countryTemp.subRegion
        } else {
            return nil
        }
    }

    public convenience init?(name: String) {
        var tempCountry : GDCountry?
        for country in GDCountry.countries {
            if (country.name?.lowercaseString == name.lowercaseString) { tempCountry = country; break }
        }
        self.init(country: tempCountry)
    }
    
    convenience init?(alpha2: String) {
        var tempCountry : GDCountry?
        for country in GDCountry.countries {
            if (country.alpha2?.lowercaseString == alpha2.lowercaseString) { tempCountry = country; break }
        }
        self.init(country: tempCountry)
    }
    
    public convenience init?(alpha3: String) {
        var tempCountry : GDCountry?
        for country in GDCountry.countries {
            if (country.alpha3?.lowercaseString == alpha3.lowercaseString) { tempCountry = country; break }
        }
        self.init(country: tempCountry)
    }

    public convenience init?(code: String) {
        var tempCountry : GDCountry?
        for country in GDCountry.countries {
            if (country.code?.lowercaseString == code.lowercaseString) { tempCountry = country; break }
        }
        self.init(country: tempCountry)
    }
    
    public convenience init?(iso_3166_2: String) {
        var tempCountry : GDCountry?
        for country in GDCountry.countries {
            if (country.iso_3166_2?.lowercaseString == iso_3166_2.lowercaseString) { tempCountry = country; break }
        }
        self.init(country: tempCountry)
    }
    
    // MARK:  Public methods

    public class var countries: [GDCountry] {
        get {
            struct Static {
                static var countryArrayInstance : [GDCountry]? = nil
                static var countryOnceToken: dispatch_once_t = 0
            }
            var countryArrayTemp = [GDCountry]()

            dispatch_once(&Static.countryOnceToken) {
                var error:NSError?
                
                var bundle = GDCountry.bundle()

                if let path = bundle?.pathForResource(kGDCountryJSONFilePath, ofType: "json") {
                    if let data = NSData(contentsOfFile: path) {
                        if let json:AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error:&error) {
                            // JSONObjectWithData returns AnyObject so the first thing to do is to downcast this to a known type
                            if let nsArrayObject = json as? NSArray {
                                if let swiftArray = nsArrayObject as? Array<Dictionary<String,String>> {
                                    for object in swiftArray {
                                        let country = GDCountry(dictionary: object)
                                        countryArrayTemp.append(country)
                                    }
                                }
                            }
                        }
                    }
                }
                Static.countryArrayInstance = countryArrayTemp
            }
            
            return Static.countryArrayInstance!
        }
    }
    
    public class func bundle() -> NSBundle? {
        var bundle : NSBundle?
        if let bundleUrl = NSBundle(forClass: self).URLForResource("GDGeoData", withExtension: "bundle") {
            bundle = NSBundle(URL: bundleUrl)
        } else {
            bundle = NSBundle.mainBundle()
        }
        
        return bundle
    }

}
