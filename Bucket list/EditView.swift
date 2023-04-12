//
//  EditView.swift
//  Bucket list
//
//  Created by Harshit Agarwal on 26/03/23.
//

import SwiftUI

struct EditView:View{
    enum Loading{
        case loading,loaded,failed
    }
    
    @Environment(\.dismiss) var dismiss
    var location: Location
    
    var onSave: (Location)-> Void
    
    @State private var name: String
    @State private var description: String
    
    @State private var loadingState = Loading.loading
    @State private var pages = [Page]()
    
    var body: some View{
        NavigationView{
            Form{
                Section{
                    TextField("Place Name",text: $name)
                    TextField("Description",text: $description)
                }
                Section("Nearby.."){
                    switch loadingState{
                    case .loading:
                        Text("Loading")
                    case .failed:
                        Text("Failed, Please try again later.")
                    case .loaded:
                        ForEach(pages,id: \.pageid) { page in
                            /*@START_MENU_TOKEN@*/Text(page.title)/*@END_MENU_TOKEN@*/
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                            
                        }
                    }
                }
            }
            .navigationTitle("Place Details")
            .toolbar{
                Button("Save"){
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
                    onSave(newLocation)
                    dismiss()
                }
                .task {
                   await fetchNearbyPlaces()
                }
            }
        }
    }
    
    init(location: Location,onSave: @escaping (Location)->Void) {
        self.location = location
        self.onSave = onSave
        
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinates.latitude)%7C\(location.coordinates.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            pages = items.query.pages.values.sorted()
            loadingState = .loaded
        }catch{
            loadingState = .failed
        }
    }
    
}
struct EditView_Previews: PreviewProvider{
    static var previews: some View {
        EditView(location: Location.examples){ newlocation in }
    }
}
