//
//  GDGeoDataListView.swift
//  GDGeoDataDemo
//
//  Created by Knut Inge Grosland on 2019-10-11.
//  Copyright © 2019 Cocmoc. All rights reserved.
//

import SwiftUI

struct GDGeoDataView: View {
    @State private var items = GDRegion.regions

    var body: some View {
        NavigationView {
            RegionListView(regions: $items)
                .navigationBarTitle(Text("GDGeoData"))
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct RegionListView: View {
    @Binding var regions: [GDRegion]
    
    var worldView: some View {
        List {
            ForEach(GDCountry.countries, id: \.self) { country in
                NavigationLink(
                    destination: CountryView(country: country)
                ) {
                    Text(country.name)
                }
            }
        }
    }
    
    func destination(region: GDRegion) -> AnyView {
        switch region.name {
        case "World":
            return AnyView(worldView.navigationBarTitle(Text(region.name)))
        default:
            return AnyView(SubRegionListView(region: region))
        }
    }

    var body: some View {
        List {
            ForEach(regions, id: \.self) { region in
                NavigationLink(
                    destination: self.destination(region: region)
                ) {
                    Text(region.name)
                }
            }
        }
    }
}

struct SubRegionListView: View {
    var region: GDRegion
    
    var body: some View {
        List {
            ForEach(region.subRegions, id: \.self) { subRegion in
                NavigationLink(
                    destination: CountryListView(subRegion: subRegion)
                ) {
                    Text(subRegion.name)
                }
            }
        }.navigationBarTitle(Text(region.name))
    }
}

struct CountryListView: View {
    var subRegion: GDSubRegion

    var body: some View {
        List {
            ForEach(subRegion.countries, id: \.self) { country in
                NavigationLink(
                    destination: CountryView(country: country)
                ) {
                    Text(country.name)
                }
            }
        }.navigationBarTitle(Text(subRegion.name))
    }
}

struct GDGeoDataListView_Previews: PreviewProvider {
    static var previews: some View {
        GDGeoDataView()
    }
}
