//
//  GDGeoDataTest.swift
//  GDGeoDataDemo
//
//  Created by Knut Inge Grosland on 2015-03-21.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import Foundation
import UIKit
import XCTest

class GDGeoDataTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: GDCountry
    
    func testAllCountries() {
        XCTAssertGreaterThan(GDCountry.countries.count, 0, "AllCountries should be grater than 0")
    }

    func testCountryLoadedByName() {
        if let norway = GDCountry(name: "Norway") {
            println("testCountryLoadedByName \(norway.description)")
            XCTAssertTrue(norway.alpha2 == "NO", "Norway should have alpha2 NO")
        } else {
            XCTAssertTrue(false, "Norway should be loaded by name")
        }
    }

    func testRegionForCountry() {
        if let norway = GDCountry(name: "Norway") {
            XCTAssertTrue(norway.region?.name == "Europe", "Region for Norway should be Europe")
        } else {
            XCTAssertTrue(false, "Norway should be loaded by name")
        }
    }

    func testSubRegionForCountry() {
        if let norway = GDCountry(name: "Norway") {
            XCTAssertTrue(norway.subRegion?.name == "Northern Europe", "Subregion for Norway should be Northern Europe")
        } else {
            XCTAssertTrue(false, "Norway should be loaded by name")
        }
    }
    
    // MARK: GDRegion
    
    func testAllRegions() {
        XCTAssertGreaterThan(GDRegion.regions.count, 0, "Allregions should be grater than 0")
    }

    func testRegionLoadedByName() {
        if let region = GDRegion(name: "Oceania") {
            println("testRegionLoadedByName \(region.description)")
            XCTAssertTrue(region.code == "009", "Oceania should have code 009")
        } else {
            XCTAssertTrue(false, "Oceania should be loaded by name")
        }
    }

    func testRegionLoadedBySubregionCode() {
        if let region = GDRegion(subRegionCode: "057") {
            XCTAssertTrue(region.name == "Oceania", "Oceania should have code 057")
        } else {
            XCTAssertTrue(false, "Oceania should be loaded by code")
        }
    }

    func testRegionHaveArrayOfCountries() {
        if let region = GDRegion(name: "Europe") {
            XCTAssertGreaterThan(region.countries.count, 0, "Europe should have array of countries greater than 0")
        } else {
            XCTAssertTrue(false, "Europe should be loaded by name")
        }
    }

    func testRegionHaveArrayOfSubRegions() {
        if let region = GDRegion(name: "Europe") {
            XCTAssertGreaterThan(region.subRegions.count, 0, "Europe should have array of subRegions greater than 0")
        } else {
            XCTAssertTrue(false, "Europe should be loaded by name")
        }
    }
    
    // MARK: GDSubRegion

    func testSubRegionByRegionAndSubRegionCode() {
        if let region = GDRegion(name: "Oceania") {
            if let subRegion = GDSubRegion(code: "057", region: region) {
                println("testSubRegionByRegionAndSubRegionCode \(subRegion.description)")
                XCTAssertTrue(subRegion.name == "Micronesia", "Micronesia should be loaded with Oceania and code 057")
            } else {
                XCTAssertTrue(false, "Micronesia should be loaded by region and code")
            }
        } else {
            XCTAssertTrue(false, "Oceania should be loaded by name")
        }
    }
    
    func testSubRegionByRegionAndSubRegionName() {
        if let subRegion = GDSubRegion(name: "Micronesia", regionName: "Oceania") {
            XCTAssertTrue(subRegion.code == "057", "Micronesia have code code 057")
        } else {
            XCTAssertTrue(false, "Micronesia should be loaded with Oceania and Micronesia")
        }
    }
}
