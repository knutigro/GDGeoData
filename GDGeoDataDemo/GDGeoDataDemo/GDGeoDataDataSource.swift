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
        if region.name == "World" {
            items = GDCountry.countries
        } else {
            items = region.subRegions
        }
    }

    init(subRegion : GDSubRegion) {
        items = subRegion.countries
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        
        if let geoDataObject = items[(indexPath as NSIndexPath).row] as? GDGeoDataObjectProtocol {
            cell.textLabel?.text = geoDataObject.name
        } else if let menuItem = items[(indexPath as NSIndexPath).row] as? String {
            cell.textLabel?.text = menuItem
        }
        
        return cell
    }
    
    

}
