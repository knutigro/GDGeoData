//
//  GDGeoDataDataSource.swift
//  GDGeoDataDemo
//
//  Created by Knut Inge Grosland on 2015-03-22.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import AppKit

class GDGeoDataDataSource : NSObject, NSTableViewDataSource {
 
    var items : [AnyObject]
    
    override init() {
        items = GDRegion.regions
    }

    init(region : GDRegion) {
        if region.name != nil && region.name == "World" {
            items = GDCountry.countries
        } else {
            items = region.subRegions
        }
    }

    init(subRegion : GDSubRegion) {
        items = subRegion.countries
    }
    
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return items.count
    }
}