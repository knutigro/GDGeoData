//
//  GDSubRegion.swift
//  GDGeoDataDemo
//
//  Created by Knut Inge Grosland on 2015-03-22.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import Foundation

let kSubRegions = "sub-regions"
let kSubRegionCode = "sub-region-code"
let kSubRegionName = "name"

@objc public class GDSubRegion : GDGeoDataObjectProtocol {
    
    public var name : String?
    public var code : String?
    
    public var debugDescription : String {
        var description = "SubRegion -"
        description += "Name: " + (name ?? "nil")
        description += "Code: " + (code ?? "nil")
        
        return description
    }
    
    public var description : String {
        var description = "SubRegion -"
        description += "\nName: " + (name ?? "nil")
        description += "\nCode: " + (code ?? "nil")
        
        return description
    }
    
    public convenience init(dictionary : NSDictionary) {
        self.init()
        name = dictionary[kSubRegionName] as? String
        code = dictionary[kSubRegionCode] as? String
    }
    
    public convenience init?(subRegion : GDSubRegion?) {
        self.init()
        if let subRegionTemp = subRegion {
            name = subRegionTemp.name
            code = subRegionTemp.code
        } else {
            return nil
        }
    }
    
    public convenience init?(name: String, regionName: String) {
        var tempSubRegion : GDSubRegion?
        if let region = GDRegion(name: regionName) {
            for subRegion in region.subRegions {
                if (subRegion.name?.lowercaseString == name.lowercaseString) { tempSubRegion = subRegion; break }
            }
        }
        self.init(subRegion: tempSubRegion)
    }
    
    public convenience init?(code: String, regionCode: String) {
        var tempSubRegion : GDSubRegion?
        if let region = GDRegion(code: regionCode) {
            for subRegion in region.subRegions {
                if (subRegion.code?.lowercaseString == code.lowercaseString) { tempSubRegion = subRegion; break }
            }
        }
        self.init(subRegion: tempSubRegion)
    }
    
    public convenience init?(code: String, region: GDRegion) {
        var tempSubRegion : GDSubRegion?
        for subRegion in region.subRegions {
            if (subRegion.code?.lowercaseString == code.lowercaseString) { tempSubRegion = subRegion; break }
        }
        self.init(subRegion: tempSubRegion)
    }
    
    public convenience init?(name: String, region: GDRegion) {
        var tempSubRegion : GDSubRegion?
        for subRegion in region.subRegions {
            if (subRegion.name?.lowercaseString == name.lowercaseString) { tempSubRegion = subRegion; break }
        }
        self.init(subRegion: tempSubRegion)
    }
    
    //  Returns Array with all coutries whithin a subregion
    public var countries : [GDCountry] {
        get {
            var countries = [GDCountry]()
            for country in GDCountry.countries {
                if (country.subRegionCode?.lowercaseString == code?.lowercaseString) {
                    countries.append(country)
                }
            }
            
            return countries
        }
    }
}
