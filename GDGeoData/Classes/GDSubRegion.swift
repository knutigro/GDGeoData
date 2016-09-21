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

open class GDSubRegion: GDGeoDataObjectProtocol {
    
    open var name = ""
    open var code = ""
    
    open var debugDescription: String {
        var description = "SubRegion -"
        description += "Name: " + name
        description += "Code: " + code
        
        return description
    }
    
    open var description: String {
        var description = "SubRegion -"
        description += "\nName: " + name
        description += "\nCode: " + code
        
        return description
    }
    
    public convenience init(dictionary : NSDictionary) {
        self.init()
        if let name = dictionary[kSubRegionName] as? String {
            self.name = name
        }
        if let code = dictionary[kSubRegionCode] as? String {
            self.code = code
        }
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
                if (subRegion.name.lowercased() == name.lowercased()) { tempSubRegion = subRegion; break }
            }
        }
        self.init(subRegion: tempSubRegion)
    }
    
    public convenience init?(code: String, regionCode: String) {
        var tempSubRegion : GDSubRegion?
        if let region = GDRegion(code: regionCode) {
            for subRegion in region.subRegions {
                if (subRegion.code.lowercased() == code.lowercased()) { tempSubRegion = subRegion; break }
            }
        }
        self.init(subRegion: tempSubRegion)
    }
    
    public convenience init?(code: String, region: GDRegion) {
        var tempSubRegion : GDSubRegion?
        for subRegion in region.subRegions {
            if (subRegion.code.lowercased() == code.lowercased()) { tempSubRegion = subRegion; break }
        }
        self.init(subRegion: tempSubRegion)
    }
    
    public convenience init?(name: String, region: GDRegion) {
        var tempSubRegion : GDSubRegion?
        for subRegion in region.subRegions {
            if (subRegion.name.lowercased() == name.lowercased()) { tempSubRegion = subRegion; break }
        }
        self.init(subRegion: tempSubRegion)
    }
    
    //  Returns Array with all coutries whithin a subregion
    open var countries : [GDCountry] {
        get {
            var countries = [GDCountry]()
            for country in GDCountry.countries {
                if (country.subRegionCode?.lowercased() == code.lowercased()) {
                    countries.append(country)
                }
            }
            
            return countries
        }
    }
}
