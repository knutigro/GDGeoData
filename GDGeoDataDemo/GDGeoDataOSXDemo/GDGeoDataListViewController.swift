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
            regionTableView.setDataSource(regionDataSource)
            regionTableView.reloadData()
        }
    }

    var subRegionDataSource : GDGeoDataDataSource? {
        didSet {
            subRegiontableView.setDataSource(subRegionDataSource)
            subRegiontableView.reloadData()
        }
    }

    var countryDataSource : GDGeoDataDataSource? {
        didSet {
            countryTableView.setDataSource(countryDataSource)
            countryTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Default configuration
        if (regionDataSource == nil) {
            regionDataSource = GDGeoDataDataSource()
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
            
            if tableView == regionTableView {
                if let region = regionDataSource?.items[index] as? GDRegion {
                    if index == 0 {
                        countryDataSource = GDGeoDataDataSource(region: region)
                        subRegionDataSource = nil;
                        textField?.stringValue = ""
                    } else {
                        subRegionDataSource = GDGeoDataDataSource(region: region)
                        countryDataSource = nil;
                        textField?.stringValue = ""
                    }
                }
            } else if tableView == subRegiontableView {
                if let subRegion = subRegionDataSource?.items[index] as? GDSubRegion {
                    countryDataSource = GDGeoDataDataSource(subRegion: subRegion)
                    textField?.stringValue = ""
                }
            } else if tableView == countryTableView {
                if let country = countryDataSource?.items[index] as? GDCountry {
                    textField?.stringValue = country.description
                }
            }
            
        }
    }
    
}
