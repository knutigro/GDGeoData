//
//  GDGeoDataListViewController.swift
//  GDGeoDataDemo
//
//  Created by Knut Inge Grosland on 2015-03-21.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import UIKit

class GDGeoDataListViewController: UITableViewController, UITableViewDelegate {
    
    var geoDataSource : GDGeoDataDataSource? {
        didSet {
            tableView.dataSource = geoDataSource
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Default configuration
        if (geoDataSource == nil) {
            geoDataSource = GDGeoDataDataSource()
        }
    }

    // MARK:  UITableViewDelegate Methods

    override  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if let dataSource = tableView.dataSource as? GDGeoDataDataSource {
            let cell = tableView .cellForRowAtIndexPath(indexPath)
            
            if let region = dataSource.items[indexPath.row] as? GDRegion {
                if let listViewController = storyboard?.instantiateViewControllerWithIdentifier("GDGeoDataListViewController") as? GDGeoDataListViewController {
                    listViewController.geoDataSource = GDGeoDataDataSource(region: region)
                    listViewController.title = region.name
                    navigationController?.pushViewController(listViewController, animated: true)
                }
            } else if let subRegion = dataSource.items[indexPath.row] as? GDSubRegion {
                if let listViewController = storyboard?.instantiateViewControllerWithIdentifier("GDGeoDataListViewController") as? GDGeoDataListViewController {
                    listViewController.geoDataSource = GDGeoDataDataSource(subRegion: subRegion)
                    listViewController.title = subRegion.name
                    navigationController?.pushViewController(listViewController, animated: true)
                }
            } else if let country = dataSource.items[indexPath.row] as? GDCountry {
                if let detailViewController = storyboard?.instantiateViewControllerWithIdentifier("GDGeoDataDetailViewController") as? GDGeoDataDetailViewController {
                    detailViewController.geoObject = country
                    detailViewController.title = country.name
                    navigationController?.pushViewController(detailViewController, animated: true)
                }
            }
        }
    }
}
