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
        description += " Name: " + (self.name ?? "nil")
        description += " Alpha2: " + (self.alpha2 ?? "nil")
        description += " Alpha3: " + (self.alpha3 ?? "nil")
        description += " CountryCode: " + (self.code ?? "nil")
        description += " Iso_3166_2: " + (self.iso_3166_2 ?? "nil")
        description += " RegionCode: " + (self.regionCode ?? "nil")
        description += " SubRegionCode: " + (self.subRegionCode ?? "nil")
        description += " Region: " + (self.region?.name ?? "nil")
        description += " SubRegion: " + (self.subRegion?.name ?? "nil")

        return description
    }
    
    public var description : String {
        var description = "Country -"
        description += "\nName: " + (self.name ?? "nil")
        description += "\nAlpha2: " + (self.alpha2 ?? "nil")
        description += "\nAlpha3: " + (self.alpha3 ?? "nil")
        description += "\nCountryCode: " + (self.code ?? "nil")
        description += "\nIso_3166_2: " + (self.iso_3166_2 ?? "nil")
        description += "\nRegionCode: " + (self.regionCode ?? "nil")
        description += "\nSubRegionCode: " + (self.subRegionCode ?? "nil")
        description += "\nRegion: " + (self.region?.name ?? "nil")
        description += "\nSubRegion: " + (self.subRegion?.name ?? "nil")
        
        return description
    }
    
    // MARK:  Initializers

    public convenience init(dictionary : NSDictionary) {
        self.init()
        self.name = dictionary[kCountryName] as? String
        self.alpha2 = dictionary[kCountryAlpha2] as? String
        self.alpha3 = dictionary[kCountryAlpha3] as? String
        self.code = dictionary[kCountryCode] as? String
        self.iso_3166_2 = dictionary[kCountryIso_3166_2] as? String
        self.regionCode = dictionary[kRegionCode] as? String
        self.subRegionCode = dictionary[kSubRegionCode] as? String
        if let regionCode = self.regionCode {
            self.region = GDRegion(regionCode: regionCode)
            if let region = self.region {
                if let subRegionCode = self.subRegionCode {
                    self.subRegion = GDSubRegion(region: region, subRegionCode: subRegionCode)
                }
            }
        }
    }

    public convenience init?(country : GDCountry?) {
        self.init()
        if let countryTemp = country {
            self.name = countryTemp.name
            self.alpha2 = countryTemp.alpha2
            self.alpha3 = countryTemp.alpha3
            self.code = countryTemp.code
            self.iso_3166_2 = countryTemp.iso_3166_2
            self.regionCode = countryTemp.regionCode
            self.subRegionCode = countryTemp.subRegionCode
            self.region = countryTemp.region
            self.subRegion = countryTemp.subRegion
        } else {
            return nil
        }
    }

    public convenience init?(name: String) {
        var tempCountry : GDCountry?
        for country in GDCountry.allCountries {
            if (country.name?.lowercaseString == name.lowercaseString) { tempCountry = country; break }
        }
        self.init(country: tempCountry)
    }
    
    convenience init?(alpha2: String) {
        var tempCountry : GDCountry?
        for country in GDCountry.allCountries {
            if (country.alpha2?.lowercaseString == alpha2.lowercaseString) { tempCountry = country; break }
        }
        self.init(country: tempCountry)
    }
    
    public convenience init?(alpha3: String) {
        var tempCountry : GDCountry?
        for country in GDCountry.allCountries {
            if (country.alpha3?.lowercaseString == alpha3.lowercaseString) { tempCountry = country; break }
        }
        self.init(country: tempCountry)
    }

    public convenience init?(countryCode: String) {
        var tempCountry : GDCountry?
        for country in GDCountry.allCountries {
            if (country.code?.lowercaseString == countryCode.lowercaseString) { tempCountry = country; break }
        }
        self.init(country: tempCountry)
    }
    
    public convenience init?(iso_3166_2: String) {
        var tempCountry : GDCountry?
        for country in GDCountry.allCountries {
            if (country.iso_3166_2?.lowercaseString == iso_3166_2.lowercaseString) { tempCountry = country; break }
        }
        self.init(country: tempCountry)
    }
    
    // MARK:  Public methods

    public class var allCountries: [GDCountry] {
        get {
            struct Static {
                static var countryArrayInstance : [GDCountry]? = nil
                static var countryOnceToken: dispatch_once_t = 0
            }
            var countryArrayTemp = [GDCountry]()

            dispatch_once(&Static.countryOnceToken) {
                var error:NSError?
                var bundle = NSBundle(forClass: self)
                if let path = bundle.pathForResource(kGDCountryJSONFilePath, ofType: "json") {
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

}
