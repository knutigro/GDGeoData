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

let kRegionName = "name"
let kRegionCode = "region-code"

let kGDRegionJSONFilePath = "GDRegions"

public class GDRegion: GDGeoDataObjectProtocol {

    public var name = ""
    public var code = ""
    public var subRegions = [GDSubRegion]()
    
    public var debugDescription : String {
        var description = "SubRegion -"
        description += "Name: " + name
        description += "Code: " + code
        
        return description
    }

    public var description : String {
        var description = "SubRegion -"
        description += "\nName: " + name
        description += "\nCode: " + code
        
        return description
    }

    public convenience init(dictionary : NSDictionary) {
        self.init()
        if let name = dictionary[kRegionName] as? String {
            self.name = name
        }
        
        if let code = dictionary[kRegionCode] as? String {
            self.code = code
        }

        if let regions = dictionary[kSubRegions] as? Array<NSDictionary> {
            for regionDic in regions {
                let subRegion = GDSubRegion(dictionary: regionDic)
                subRegions.append(subRegion)
            }
        }
    }
    
    public convenience init?(region : GDRegion?) {
        self.init()
        if let regionTemp = region {
            name = regionTemp.name
            code = regionTemp.code
            subRegions = regionTemp.subRegions
        } else {
            return nil
        }
    }
    
    public convenience init?(name: String) {
        var tempRegion : GDRegion?
        for region in GDRegion.regions {
            if (region.name.lowercaseString == name.lowercaseString) { tempRegion = region; break }
        }
        self.init(region: tempRegion)
    }

    public convenience init?(code: String) {
        var tempRegion : GDRegion?
        for region in GDRegion.regions {
            if (region.code.lowercaseString == code.lowercaseString) { tempRegion = region; break }
        }
        self.init(region: tempRegion)
    }
    
    public convenience init?(subRegionCode: String) {
        var tempRegion : GDRegion?
        for region in GDRegion.regions {
            for subRegion in region.subRegions {
                if (subRegion.code.lowercaseString == subRegionCode.lowercaseString) { tempRegion = region; break }
            }
        }
        self.init(region: tempRegion)
    }
    
    public convenience init?(subRegionName: String) {
        var tempRegion : GDRegion?
        for region in GDRegion.regions {
            for subRegion in region.subRegions {
                if (subRegion.name.lowercaseString == subRegionName.lowercaseString) { tempRegion = region; break }
            }
        }
        self.init(region: tempRegion)
    }
    
    public class var regions: [GDRegion] {
        get {
            struct Static {
                static var regionArrayInstance : [GDRegion]? = nil
                static var regionOnceToken: dispatch_once_t = 0
            }
            var regionArrayTemp = [GDRegion]()
            dispatch_once(&Static.regionOnceToken) {
                let bundle = GDCountry.bundle()
                if let path = bundle?.pathForResource(kGDRegionJSONFilePath, ofType: "json") {
                    if let data = NSData(contentsOfFile: path) {
                        do {
                            let json:AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                            // JSONObjectWithData returns AnyObject so the first thing to do is to downcast this to a known type
                            if let nsArrayObject = json as? NSArray {
                                if let swiftArray = nsArrayObject as? Array<Dictionary<String,AnyObject>> {
                                    for object in swiftArray {
                                        let region = GDRegion(dictionary: object)
                                        regionArrayTemp.append(region)
                                    }
                                }
                            }
                        } catch let error as NSError {
                            print("Error \(error)")
                        } catch {
                            fatalError()
                        }
                    }
                }
                Static.regionArrayInstance = regionArrayTemp
            }
            
            return Static.regionArrayInstance!
        }
    }
    
    //  Returns Array with all countries whithin a region
    public var countries : [GDCountry]{
        get {
            var countries = [GDCountry]()
            for country in GDCountry.countries {
                if (country.regionCode?.lowercaseString == code.lowercaseString) {
                    countries.append(country)
                }
            }
            return countries
        }
    }
}
