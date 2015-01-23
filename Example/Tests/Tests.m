//
//  GDGeoDataTests.m
//  GDGeoDataTests
//
//  Created by Knut Inge Grosland on 01/23/2015.
//  Copyright (c) 2014 Knut Inge Grosland. All rights reserved.
//

#import "Specs.h"

#import "GDGeoData/GDGeoData-Bridging-Header.h"
#import "GDGeoData/GDGeoData-Swift.h"

SpecBegin(InitialSpecs)

describe(@"these will fail", ^{
    
    it(@"can read", ^{
        expect(@"number").to.equal(@"number");
    });
    
    xit(@"will wait and fail", ^AsyncBlock {
        
    });
});

describe(@"these will pass", ^{
    
    xit(@"will wait and succeed", ^AsyncBlock {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            done();
        });
    });
});

SpecEnd
