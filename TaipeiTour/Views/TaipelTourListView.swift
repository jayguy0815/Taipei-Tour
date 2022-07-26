//
//  TaipelTourListView.swift
//  TaipeiTour
//
//  Created by Leo Huang on 2022/7/26.
//

import SwiftUI

struct TaipelTourListView: View {
    let dataBank = ["Coding", "Buy Milk", "Go to school"]
    @State var places: Places?
    var body: some View {
        List{
            if let data = places?.data {
                ForEach(data.indices, id: \.self) { index in
                    ListCellView(data: data[index])
                }
            }
//            ForEach(dataBank, id: \.self){ data in
//                ListCellView(data: data)
//            }
        }.onAppear(perform: self.loadData)
    }
    
    func loadData(){
        let urlString = "https://www.travel.taipei/open-api/zh-tw/Attractions/All?page=1"
        
        guard let url = URL(string: urlString) else {
            print("illegle url")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "Get"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error{
                print(error.localizedDescription)
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let places = try JSONDecoder().decode(Places.self, from: data)
                DispatchQueue.main.async {
                    self.places = places
                    print(places.data)
                }
            } catch let error{
                fatalError(error.localizedDescription)
            }
        }.resume()
    }
}

struct Places: Codable{
    var data: [Place]
    struct Place: Codable{
        var name: String
        var introduction: String
        var tel: String
    }
}

struct TaipelTourListView_Previews: PreviewProvider {
    static var previews: some View {
        TaipelTourListView()
    }
}

struct ListCellView: View{
    
    var data : Places.Place
    init(data: Places.Place){
        self.data = data
    }
    
    var body: some View {
        HStack{
            Text("。")
            VStack{
                Text(data.name)
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(data.introduction)
                    .fontWeight(.medium)
                    .font(.system(.body))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Text(data.tel)
                    .fontWeight(.light)
                    .font(.system(.body))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
        
            }
        }
    }
}
