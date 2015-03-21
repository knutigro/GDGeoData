//
//  GDGeoDataDemoTests.swift
//  GDGeoDataDemoTests
//
//  Created by Knut Inge Grosland on 2015-03-20.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import UIKit
import XCTest

class GDGeoDataDemoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}

//SpecBegin(GDCountry)
//
//describe(@"GDCountry data is loading", ^{
//    
//    it(@"AllCountries is loaded", ^{
//        expect([GDCountry allCountries].count).to.beGreaterThan(0);
//    });
//    
//    it(@"Norway loaded by name", ^{
//    GDCountry *country = [[GDCountry alloc] initWithName:@"Norway"];
//    NSLog(@"%@", country.description);
//    expect(country.alpha2).to.equal(@"NO");
//    });
//    
//    it(@"Region for Norway should be Europe", ^{
//    GDCountry *country = [[GDCountry alloc] initWithName:@"Norway"];
//    expect(country.region.regionName).to.equal(@"Europe");
//    });
//    
//    it(@"SubRegion for Norway should be Northern Europe", ^{
//    GDCountry *country = [[GDCountry alloc] initWithName:@"Norway"];
//    expect(country.subRegion.subRegionName).to.equal(@"Northern Europe");
//    });
//});
//
//SpecEnd
//
//
//SpecBegin(GDRegion)
//
//describe(@"GDRegion data is loading", ^{
//
//it(@"All regions is loaded", ^{
//expect([GDRegion allRegions].count).to.beGreaterThan(0);
//});
//
//it(@"Oceania loaded by name", ^{
//GDRegion *region = [[GDRegion alloc] initWithRegionName:@"Oceania"];
//NSLog(@"%@", region.description);
//expect(region.regionCode).to.equal(@"009");
//});
//
//it(@"Oceania loaded by subregioncode", ^{
//GDRegion *region = [[GDRegion alloc] initWithSubRegionCode:@"057"];
//expect(region.regionName).to.equal(@"Oceania");
//});
//
//xit(@"Europe should have array of countries", ^{
//GDRegion *region = [[GDRegion alloc] initWithRegionName:@"Europe"];
//expect(region.countries.count).to.beGreaterThan(0);
//});
//
//xit(@"Europe should have array of SubRegions", ^{
//GDRegion *region = [[GDRegion alloc] initWithRegionName:@"Europe"];
//expect(region.subRegions.count).to.beGreaterThan(0);
//});
//
//});
//
//SpecEnd
//
//
//SpecBegin(GDSubRegion)
//
//describe(@"GDSubRegion data is loading", ^{
//
//it(@"Micronesia is loaded by region and regioncode", ^{
//GDRegion *region = [[GDRegion alloc] initWithRegionName:@"Oceania"];
//GDSubRegion *subRegion = [[GDSubRegion alloc] initWithRegion:region subRegionCode:@"057"];
//NSLog(@"%@", subRegion.description);
//expect(subRegion.subRegionName).to.equal(@"Micronesia");
//});
//
//it(@"Micronesia is loaded by region and regioncode", ^{
//GDSubRegion *subRegion = [[GDSubRegion alloc] initWithRegionName:@"Oceania" subRegionName:@"Micronesia"];
//expect(subRegion.subRegionCode).to.equal(@"057");
//});
//
//});
//
//SpecEnd
