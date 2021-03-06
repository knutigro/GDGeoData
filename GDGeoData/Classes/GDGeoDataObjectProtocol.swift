//
//  GDGeoDataObjectProtocol.swift
//  GDGeoDataDemo
//
//  Created by Knut Inge Grosland on 2015-03-22.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

public protocol GDGeoDataObjectProtocol: Hashable {
    var name: String {get set}
    var code: String {get set}
    var debugDescription: String {get}
    var description: String {get}
}
