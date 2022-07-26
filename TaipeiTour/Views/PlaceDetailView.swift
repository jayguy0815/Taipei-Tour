//
//  PlaceDetailView.swift
//  TaipeiTour
//
//  Created by Leo Huang on 2022/7/26.
//

import SwiftUI

struct PlaceDetailView: View {
    
    @State var place: Place
    
    var body: some View {
        VStack(alignment: .leading){
            AsyncImage(url: URL(string: place.image)) { phase in
                if let image = phase.image {
                    image // Displays the loaded image.
                } else if phase.error != nil {
                    Color.red // Indicates an error.
                } else {
                    Color.blue // Acts as a placeholder.
                }
            }
        }
    }
}

struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let test = Place(name: "Test", introduction: "Test", address: "Test", tel: "Test", image: "Test", isFavor: false)
        PlaceDetailView(place: test)
    }
}
