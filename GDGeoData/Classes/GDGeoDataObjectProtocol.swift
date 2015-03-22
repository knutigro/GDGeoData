//
//  GDGeoDataObjectProtocol.swift
//  GDGeoDataDemo
//
//  Created by Knut Inge Grosland on 2015-03-22.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import Foundation

@objc protocol GDGeoDataObjectProtocol {
    var name : String? {get set}
    var code : String? {get set}
    var debugDescription : String {get}
    var description : String {get}
}