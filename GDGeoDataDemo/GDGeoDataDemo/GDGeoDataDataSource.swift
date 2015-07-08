//
//  GDGeoDataDataSource.swift
//  GDGeoDataDemo
//
//  Created by Knut Inge Grosland on 2015-03-22.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import Foundation
import UIKit

class GDGeoDataDataSource : NSObject, UITableViewDataSource {
 
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

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        if let geoDataObject = items[indexPath.row] as? GDGeoDataObjectProtocol {
            if let name = geoDataObject.name {
                cell.textLabel?.text = name
            }
        } else if let menuItem = items[indexPath.row] as? String {
            cell.textLabel?.text = menuItem
        }
        
        return cell
    }
    
    

}