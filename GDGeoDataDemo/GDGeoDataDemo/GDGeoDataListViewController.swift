//
//  GDGeoDataListViewController.swift
//  GDGeoDataDemo
//
//  Created by Knut Inge Grosland on 2015-03-21.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import UIKit

class GDGeoDataListViewController: UITableViewController {
    
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

    override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let dataSource = tableView.dataSource as? GDGeoDataDataSource {
            if let region = dataSource.items[(indexPath as NSIndexPath).row] as? GDRegion {
                if let listViewController = storyboard?.instantiateViewController(withIdentifier: "GDGeoDataListViewController") as? GDGeoDataListViewController {
                    listViewController.geoDataSource = GDGeoDataDataSource(region: region)
                    listViewController.title = region.name
                    navigationController?.pushViewController(listViewController, animated: true)
                }
            } else if let subRegion = dataSource.items[(indexPath as NSIndexPath).row] as? GDSubRegion {
                if let listViewController = storyboard?.instantiateViewController(withIdentifier: "GDGeoDataListViewController") as? GDGeoDataListViewController {
                    listViewController.geoDataSource = GDGeoDataDataSource(subRegion: subRegion)
                    listViewController.title = subRegion.name
                    navigationController?.pushViewController(listViewController, animated: true)
                }
            } else if let country = dataSource.items[(indexPath as NSIndexPath).row] as? GDCountry {
                if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "GDGeoDataDetailViewController") as? GDGeoDataDetailViewController {
                    detailViewController.geoObject = country
                    detailViewController.title = country.name
                    navigationController?.pushViewController(detailViewController, animated: true)
                }
            }
        }
    }
}
