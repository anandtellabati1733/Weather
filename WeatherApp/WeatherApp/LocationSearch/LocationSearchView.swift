//
//  LocationSearchView.swift
//  Weather
//
//  Created by Uma on 29/08/24.
//

import SwiftUI

struct LocationSearchView: View {
    @StateObject var searchModel = LocationSearchViewModel()
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            NavigationView {
                List(searchModel.locationResult, id: \.self) { results in
                    Button(action: {
                        searchModel.selectedCity = results.title
                        searchModel.dismiss()
                    }) {
                        Text(results.title)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("close") {
                            searchModel.dismiss()
                        }
                    }
                }
                .navigationTitle("Search For city")
            }
            .searchable(text: $searchModel.searchText).autocorrectionDisabled()
            .onChange(of: searchModel.searchText) { newValue in
                print("newValue \(newValue)")
                searchModel.completer.queryFragment = searchModel.searchText
                
            }
        }
    }
}



struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView()
    }
}
