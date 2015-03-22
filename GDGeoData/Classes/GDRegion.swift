//
//  GDRegion.swift
//  GDGeoData
//
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

/*
*  SubRegion
*/

let kSubRegions = "sub-regions"
let kSubRegionCode = "sub-region-code"
let kSubRegionName = "name"

@objc public class GDSubRegion : GDGeoObject{

    override public var debugDescription : String {
        var description = "SubRegion -"
        description += "Name: " + (self.name ?? "nil")
        description += "Code: " + (self.code ?? "nil")
        
        return description
    }

    override  public var description : String {
        var description = "SubRegion -"
        description += "\nName: " + (self.name ?? "nil")
        description += "\nCode: " + (self.code ?? "nil")
        
        return description
    }
    
    public init(dictionary : NSDictionary) {
        super.init()
        self.name = dictionary[kSubRegionName] as? String
        self.code = dictionary[kSubRegionCode] as? String
    }
    
    public init?(subRegion : GDSubRegion?) {
        super.init()
        if let subRegionTemp = subRegion {
            self.name = subRegionTemp.name
            self.code = subRegionTemp.code
        } else {
            return nil
        }
    }
    
    public convenience init?(regionName: String, subRegionName: String) {
        var tempSubRegion : GDSubRegion?
        if let region = GDRegion(regionName: regionName) {
            for subRegion in region.subRegions {
                if (subRegion.name?.lowercaseString == subRegionName.lowercaseString) { tempSubRegion = subRegion; break }
            }
        }
        self.init(subRegion: tempSubRegion)
    }
    
    public convenience init?(regionCode: String, subRegionCode: String) {
        var tempSubRegion : GDSubRegion?
        if let region = GDRegion(regionCode: regionCode) {
            for subRegion in region.subRegions {
                if (subRegion.code?.lowercaseString == subRegionCode.lowercaseString) { tempSubRegion = subRegion; break }
            }
        }
        self.init(subRegion: tempSubRegion)
    }
    
    public convenience init?(region: GDRegion, subRegionCode: String) {
        var tempSubRegion : GDSubRegion?
        for subRegion in region.subRegions {
            if (subRegion.code?.lowercaseString == subRegionCode.lowercaseString) { tempSubRegion = subRegion; break }
        }
        self.init(subRegion: tempSubRegion)
    }

    public convenience init?(region: GDRegion, subRegionName: String) {
        var tempSubRegion : GDSubRegion?
        for subRegion in region.subRegions {
            if (subRegion.name?.lowercaseString == subRegionName.lowercaseString) { tempSubRegion = subRegion; break }
        }
        self.init(subRegion: tempSubRegion)
    }
    
    /*
    *  Returns Array with all coutries whithin a subregion
    */
    public func countries() -> [GDCountry]{
        var countries = [GDCountry]()
        for country in GDCountry.allCountries {
            if (country.subRegionCode?.lowercaseString == self.code?.lowercaseString) {
                countries.append(country)
            }
        }
        
        return countries;
    }
    
}

/*
*  Region
*/
let kRegionName = "name"
let kRegionCode = "region-code"
let kGDRegionJSONFilePath = "GDRegions"

@objc public class GDRegion : GDGeoObject {
    
    public var subRegions = [GDSubRegion]()
    
    override public var debugDescription : String {
        var description = "SubRegion -"
        description += "Name: " + (self.name ?? "nil")
        description += "Code: " + (self.code ?? "nil")
        
        return description
    }

    override public var description : String {
        var description = "SubRegion -"
        description += "\nName: " + (self.name ?? "nil")
        description += "\nCode: " + (self.code ?? "nil")
        
        return description
    }

    public convenience init(dictionary : NSDictionary) {
        self.init()
        self.name = dictionary[kRegionName] as? String
        self.code = dictionary[kRegionCode] as? String
        
        if let regions = dictionary[kSubRegions] as? Array<NSDictionary> {
            for regionDic in regions {
                var subRegion = GDSubRegion(dictionary: regionDic)
                self.subRegions.append(subRegion)
            }
        }
    }
    
    public convenience init?(region : GDRegion?) {
        self.init()
        if let regionTemp = region {
            self.name = regionTemp.name
            self.code = regionTemp.code
            self.subRegions = regionTemp.subRegions
        } else {
            return nil
        }
    }
    
    public convenience init?(regionName: String) {
        var tempRegion : GDRegion?
        for region in GDRegion.allRegions {
            if (region.name?.lowercaseString == regionName.lowercaseString) { tempRegion = region; break }
        }
        self.init(region: tempRegion)
    }

    public convenience init?(regionCode: String) {
        var tempRegion : GDRegion?
        for region in GDRegion.allRegions {
            if (region.code?.lowercaseString == regionCode.lowercaseString) { tempRegion = region; break }
        }
        self.init(region: tempRegion)
    }
    
    public convenience init?(subRegionCode: String) {
        var tempRegion : GDRegion?
        for region in GDRegion.allRegions {
            for subRegion in region.subRegions {
                if (subRegion.code?.lowercaseString == subRegionCode.lowercaseString) { tempRegion = region; break }
            }
        }
        self.init(region: tempRegion)
    }
    
    public convenience init?(subRegionName: String) {
        var tempRegion : GDRegion?
        for region in GDRegion.allRegions {
            for subRegion in region.subRegions {
                if (subRegion.name?.lowercaseString == subRegionName.lowercaseString) { tempRegion = region; break }
            }
        }
        self.init(region: tempRegion)
    }
    
    public class var allRegions: [GDRegion] {
        get {
            struct Static {
                static var regionArrayInstance : [GDRegion]? = nil
                static var regionOnceToken: dispatch_once_t = 0
            }
            var regionArrayTemp = [GDRegion]()
            dispatch_once(&Static.regionOnceToken) {
                var error:NSError?
                var bundle = NSBundle(forClass: self)

                if let path = bundle.pathForResource(kGDRegionJSONFilePath, ofType: "json") {
                    if let data = NSData(contentsOfFile: path) {
                        if let json:AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error:&error) {
                            // JSONObjectWithData returns AnyObject so the first thing to do is to downcast this to a known type
                            if let nsArrayObject = json as? NSArray {
                                if let swiftArray = nsArrayObject as? Array<Dictionary<String,AnyObject>> {
                                    for object in swiftArray {
                                        let region = GDRegion(dictionary: object)
                                        regionArrayTemp.append(region)
                                    }
                                }
                            }
                        }
                    }
                }
                Static.regionArrayInstance = regionArrayTemp
            }
            
            return Static.regionArrayInstance!
        }
    }
    
    /*
    *  Returns Array with all coutries whithin a region
    */
    public func countries() -> [GDCountry]{
        var countries = [GDCountry]()
        for country in GDCountry.allCountries {
            if (country.regionCode?.lowercaseString == self.code?.lowercaseString) {
                countries.append(country)
            }
        }
        
        return countries;
    }
}