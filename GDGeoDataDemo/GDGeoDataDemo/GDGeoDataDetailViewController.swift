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
    var geoObject : GDGeoDataObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let textView = textView {
            if let geoObject = geoObject {
                textView.text  = geoObject.description
            }
        }
    }
}
