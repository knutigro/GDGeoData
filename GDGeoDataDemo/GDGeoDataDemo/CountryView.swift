//
//  CountryView.swift
//  GDGeoDataDemo
//
//  Created by Knut Inge Grosland on 2019-10-12.
//  Copyright © 2019 Cocmoc. All rights reserved.
//

import SwiftUI

struct CountryView: View {
    var country: GDCountry

    var body: some View {
        Group {
            Text(country.description).lineSpacing(10).font(Font.system(size: 20)).padding(20).minimumScaleFactor(0.5)
        }.navigationBarTitle(Text(country.name))
    }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(country: GDCountry(name: "Norway")!)
    }
}
