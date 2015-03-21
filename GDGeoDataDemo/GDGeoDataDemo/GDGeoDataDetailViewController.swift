//
//  GDGeoDataDetailViewController.swift
//  GDGeoDataDemo
//
//  Created by Knut Inge Grosland on 2015-03-21.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import UIKit

class GDGeoDataDetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView?
    var geoObject : GDGeoObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let unWrappedTextView = self.textView {
            if let unWrappedGeoObject = self.geoObject {
                unWrappedTextView.text  = unWrappedGeoObject.description
            }
        }
    }
}
