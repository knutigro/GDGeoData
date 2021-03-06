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
    
    public static func == (lhs: GDRegion, rhs: GDRegion) -> Bool {
        return lhs.name == rhs.name || lhs.code == rhs.code
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(code)
    }
    
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
            if (region.name.lowercased() == name.lowercased()) { tempRegion = region; break }
        }
        self.init(region: tempRegion)
    }

    public convenience init?(code: String) {
        var tempRegion : GDRegion?
        for region in GDRegion.regions {
            if (region.code.lowercased() == code.lowercased()) { tempRegion = region; break }
        }
        self.init(region: tempRegion)
    }
    
    public convenience init?(subRegionCode: String) {
        var tempRegion : GDRegion?
        for region in GDRegion.regions {
            for subRegion in region.subRegions {
                if (subRegion.code.lowercased() == subRegionCode.lowercased()) { tempRegion = region; break }
            }
        }
        self.init(region: tempRegion)
    }
    
    public convenience init?(subRegionName: String) {
        var tempRegion : GDRegion?
        for region in GDRegion.regions {
            for subRegion in region.subRegions {
                if (subRegion.name.lowercased() == subRegionName.lowercased()) { tempRegion = region; break }
            }
        }
        self.init(region: tempRegion)
    }
    
    public static var regions: [GDRegion] = {
        var regionArrayTemp = [GDRegion]()
        let bundle = GDCountry.bundle()
        if let path = bundle?.path(forResource: kGDRegionJSONFilePath, ofType: "json") {
            if let data = NSData(contentsOfFile: path) {
                do {
                    let json:Any = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments)
                    // JSONObjectWithData returns AnyObject so the first thing to do is to downcast this to a known type
                    if let nsArrayObject = json as? NSArray {
                        if let swiftArray = nsArrayObject as? Array<Dictionary<String,AnyObject>> {
                            for object in swiftArray {
                                let region = GDRegion(dictionary: object as NSDictionary)
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
        let regionArrayInstance = regionArrayTemp
        
        return regionArrayInstance
    }()
    
    //  Returns Array with all countries whithin a region
    public var countries : [GDCountry]{
        get {
            var countries = [GDCountry]()
            for country in GDCountry.countries {
                if (country.regionCode?.lowercased() == code.lowercased()) {
                    countries.append(country)
                }
            }
            return countries
        }
    }
}
