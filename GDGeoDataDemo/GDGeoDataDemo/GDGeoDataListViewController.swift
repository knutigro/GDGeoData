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
            self.tableView.dataSource = geoDataSource
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Default configuration
        if (self.geoDataSource == nil) {
            self.geoDataSource = GDGeoDataDataSource()
        }
    }

    // MARK:  UITableViewDelegate Methods

    override  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if let dataSource = self.tableView.dataSource as? GDGeoDataDataSource {
            let cell = tableView .cellForRowAtIndexPath(indexPath)
            
            if let region = dataSource.items[indexPath.row] as? GDRegion {
                if let listViewController = self.storyboard?.instantiateViewControllerWithIdentifier("GDGeoDataListViewController") as? GDGeoDataListViewController {
                    listViewController.geoDataSource = GDGeoDataDataSource(region: region)
                    self.navigationController?.pushViewController(listViewController, animated: true)
                }
            } else if let subRegion = dataSource.items[indexPath.row] as? GDSubRegion {
                if let listViewController = self.storyboard?.instantiateViewControllerWithIdentifier("GDGeoDataListViewController") as? GDGeoDataListViewController {
                    listViewController.geoDataSource = GDGeoDataDataSource(subRegion: subRegion)
                    self.navigationController?.pushViewController(listViewController, animated: true)
                }
            } else if let country = dataSource.items[indexPath.row] as? GDCountry {
                if let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("GDGeoDataDetailViewController") as? GDGeoDataDetailViewController {
                    detailViewController.geoObject = country
                    self.navigationController?.pushViewController(detailViewController, animated: true)
                }
            }
        }
    }
}
