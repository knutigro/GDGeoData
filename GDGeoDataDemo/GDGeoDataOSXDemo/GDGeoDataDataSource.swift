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
        self.items = GDRegion.regions
    }

    init(region : GDRegion) {
        if region.name != nil && region.name == "World" {
            self.items = GDCountry.countries
        } else {
            self.items = region.subRegions
        }
    }

    init(subRegion : GDSubRegion) {
        self.items = subRegion.countries
    }
    
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return self.items.count
    }
}