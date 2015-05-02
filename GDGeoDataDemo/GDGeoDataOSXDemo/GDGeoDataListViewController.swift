//
//  GDGeoDataListViewController.swift
//  GDGeoDataDemo
//
//  Created by Knut Inge Grosland on 2015-03-21.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import AppKit

class GDGeoDataListViewController: NSViewController, NSTableViewDelegate {
    
    @IBOutlet weak var regionTableView: NSTableView!
    @IBOutlet weak var subRegiontableView: NSTableView!
    @IBOutlet weak var countryTableView: NSTableView!
    @IBOutlet weak var textField: NSTextField?

    var regionDataSource : GDGeoDataDataSource? {
        didSet {
            self.regionTableView.setDataSource(regionDataSource)
            self.regionTableView.reloadData()
        }
    }

    var subRegionDataSource : GDGeoDataDataSource? {
        didSet {
            self.subRegiontableView.setDataSource(subRegionDataSource)
            self.subRegiontableView.reloadData()
        }
    }

    var countryDataSource : GDGeoDataDataSource? {
        didSet {
            self.countryTableView.setDataSource(countryDataSource)
            self.countryTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Default configuration
        if (self.regionDataSource == nil) {
            self.regionDataSource = GDGeoDataDataSource()
        }
    }
    
    // MARK:  UITableViewDelegate Methods

    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let view = tableView.makeViewWithIdentifier("Identifier", owner: self) as! NSTableCellView
        
        if let dataSource = tableView.dataSource() as? GDGeoDataDataSource {
            if let geoDataObject = dataSource.items[row] as? GDGeoDataObjectProtocol {
                if let name = geoDataObject.name {
                    view.textField?.stringValue = name
                }
            } else if let menuItem = dataSource.items[row] as? String {
                view.textField?.stringValue = menuItem
            }
        }

        return view
    }
    
    func tableViewSelectionDidChange(aNotification: NSNotification) {
        if let tableView = aNotification.object as? NSTableView {
            let index = tableView.selectedRow

            if index == -1 { return   }
            
            if tableView == self.regionTableView {
                if let region = self.regionDataSource?.items[index] as? GDRegion {
                    if index == 0 {
                        self.countryDataSource = GDGeoDataDataSource(region: region)
                        self.subRegionDataSource = nil;
                        self.textField?.stringValue = ""
                    } else {
                        self.subRegionDataSource = GDGeoDataDataSource(region: region)
                        self.countryDataSource = nil;
                        self.textField?.stringValue = ""
                    }
                }
            } else if tableView == self.subRegiontableView {
                if let subRegion = self.subRegionDataSource?.items[index] as? GDSubRegion {
                    self.countryDataSource = GDGeoDataDataSource(subRegion: subRegion)
                    self.textField?.stringValue = ""
                }
            } else if tableView == self.countryTableView {
                if let country = self.countryDataSource?.items[index] as? GDCountry {
                    self.textField?.stringValue = country.description
                }
            }
            
        }
    }
    
}
