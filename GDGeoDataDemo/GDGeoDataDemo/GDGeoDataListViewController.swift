//
//  GDGeoDataListViewController.swift
//  GDGeoDataDemo
//
//  Created by Knut Inge Grosland on 2015-03-21.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import UIKit

class GDGeoDataListViewController: UITableViewController {
    
    var items = [GDCountry]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.items = GDCountry.allCountries
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let country = self.items[indexPath.row]
        
        if let name = country.name {
            cell.textLabel?.text = name
        }

        return cell
    }
    
    // MARK:  UITableViewDelegate Methods
    override  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView .cellForRowAtIndexPath(indexPath)
        let country = self.items[indexPath.row]
        
        self.performSegueWithIdentifier("showDetailSegue", sender: country)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var detailViewController = segue.destinationViewController as GDGeoDataDetailViewController
        detailViewController.geoObject = sender as? GDGeoObject
    }

}
