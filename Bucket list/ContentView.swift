//
//  ContentView.swift
//  Bucket list
//
//  Created by Harshit Agarwal on 24/03/23.
//
import MapKit
import SwiftUI
struct Location: Identifiable{
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
struct ContentView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 27.582256, longitude: 77.697083), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 15))
    
    let locations = [
        Location(name: "Banke Bihari Temple", coordinate: CLLocationCoordinate2D(latitude: 27.582256, longitude: 77.697083)),
    ]
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion)
                .edgesIgnoringSafeArea(.all)
            
            
            Circle()
                .stroke(.blue,lineWidth: 3)
                .opacity(0.6)
                .frame(width: 22,height: 22)
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        
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
