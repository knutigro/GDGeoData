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

public class GDCountry: GDGeoDataObjectProtocol {

    public var name = ""
    public var code = ""
    public var alpha2: String?
    public var alpha3: String?
    public var iso_3166_2: String?
    public var region: GDRegion?
    public var subRegion: GDSubRegion?
    public var regionCode: String?
    public var subRegionCode: String?
    
    public static func == (lhs: GDCountry, rhs: GDCountry) -> Bool {
        return lhs.name == rhs.name || lhs.code == rhs.code
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(code)
    }

    public var debugDescription : String {
        var description = "Country -"
        description += " Name: " + name
        description += " Alpha2: " + (alpha2 ?? "nil")
        description += " Alpha3: " + (alpha3 ?? "nil")
        description += " CountryCode: " + code
        description += " Iso_3166_2: " + (iso_3166_2 ?? "nil")
        description += " RegionCode: " + (regionCode ?? "nil")
        description += " SubRegionCode: " + (subRegionCode ?? "nil")
        description += " Region: " + (region?.name ?? "nil")
        description += " SubRegion: " + (subRegion?.name ?? "nil")

        return description
    }
    
    public var description : String {
        var description = "Country -"
        description += "\nName: " + name
        description += "\nAlpha2: " + (alpha2 ?? "nil")
        description += "\nAlpha3: " + (alpha3 ?? "nil")
        description += "\nCountryCode: " + code
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
        if let name = dictionary[kCountryName] as? String {
            self.name = name
        }
        if let code = dictionary[kCountryCode] as? String {
            self.code = code
        }
        alpha2 = dictionary[kCountryAlpha2] as? String
        alpha3 = dictionary[kCountryAlpha3] as? String
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
            if (country.name.lowercased() == name.lowercased()) { tempCountry = country; break }
        }
        self.init(country: tempCountry)
    }
    
    convenience init?(alpha2: String) {
        var tempCountry : GDCountry?
        for country in GDCountry.countries {
            if let countryAlpha2 = country.alpha2?.lowercased() {
                if (countryAlpha2.lowercased() == alpha2.lowercased()) { tempCountry = country; break }
            }
        }
        self.init(country: tempCountry)
    }
    
    public convenience init?(alpha3: String) {
        var tempCountry : GDCountry?
        for country in GDCountry.countries {
            if (country.alpha3?.lowercased() == alpha3.lowercased()) { tempCountry = country; break }
        }
        self.init(country: tempCountry)
    }

    public convenience init?(code: String) {
        var tempCountry : GDCountry?
        for country in GDCountry.countries {
            if (country.code.lowercased() == code.lowercased()) { tempCountry = country; break }
        }
        self.init(country: tempCountry)
    }
    
    public convenience init?(iso_3166_2: String) {
        var tempCountry : GDCountry?
        for country in GDCountry.countries {
            if (country.iso_3166_2?.lowercased() == iso_3166_2.lowercased()) { tempCountry = country; break }
        }
        self.init(country: tempCountry)
    }
    
    // MARK:  Public methods
    
    public static var countries: [GDCountry] = {
        var countryArrayTemp = [GDCountry]()
        
        let bundle = GDCountry.bundle()
        
        if let path = bundle?.path(forResource: kGDCountryJSONFilePath, ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                do {
                    let json:Any = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments)
                    // JSONObjectWithData returns AnyObject so the first thing to do is to downcast this to a known type
                    if let nsArrayObject = json as? NSArray {
                        if let swiftArray = nsArrayObject as? Array<Dictionary<String,String>> {
                            for object in swiftArray {
                                let country = GDCountry(dictionary: object as NSDictionary)
                                countryArrayTemp.append(country)
                            }
                        }
                    }
                } catch let error as NSError {
                    print("Error: \(error)")
                } catch {
                    fatalError()
                }
            }
        }
        let countryArrayInstance = countryArrayTemp
        
        return countryArrayInstance
    }()

    public class func bundle() -> Bundle? {
        var bundle : Bundle?
        if let bundleUrl = Bundle(for: self).url(forResource: "GDGeoData", withExtension: "bundle") {
            bundle = Bundle(url: bundleUrl)
        } else {
            bundle = Bundle.main
        }
        
        return bundle
    }

}
