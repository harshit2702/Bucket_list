//
//  ContentView.swift
//  Bucket list
//
//  Created by Harshit Agarwal on 24/03/23.
//
import MapKit
import SwiftUI

struct ContentView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 27.582256, longitude: 77.697083), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 15))
    @State private var location = [Location]()
    @State private var selectedPlaces: Location?
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion, annotationItems: location){location in
                MapAnnotation(coordinate: location.coordinates ){
                    VStack{
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundColor(.blue)
                            .frame(width: 44,height: 44)
                            .background(.white)
                            .clipShape(Circle())
                        Text(location.name)
                            .font(.callout)
                            .fontWeight(.bold)
                            
                        
                    }
                    .onTapGesture {
                        selectedPlaces = location
                    }
                }
            }
                .edgesIgnoringSafeArea(.all)
            
            
            Circle()
                .stroke(.blue,lineWidth: 5)
                .opacity(0.4)
                .frame(width: 44,height: 44)
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        let newLocation = Location(name: "New Location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
                        location.append(newLocation)
                    }label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(.black.opacity(0.4))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0))
                    .padding(.trailing)
                }
            }
            
        }
        .sheet(item: $selectedPlaces){place in
            EditView(location: place){newlocation in
                if let index = location.firstIndex(of: place){
                    location[index] = newlocation
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
