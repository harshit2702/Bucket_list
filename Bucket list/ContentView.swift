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
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion, annotationItems: location){location in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
            }
                .edgesIgnoringSafeArea(.all)
            
            
            Circle()
                .stroke(.blue,lineWidth: 5)
                .opacity(0.4)
                .frame(width: 11,height: 11)
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        let newLocation = Location(name: "New Location", discription: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
                        location.append(newLocation)
                    }label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(.black.opacity(0.4))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    .padding(.trailing)
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
