//
//  ContentView.swift
//  Bucket list
//
//  Created by Harshit Agarwal on 24/03/23.
//
import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.location){location in
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
                            viewModel.selectedPlaces = location
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
                
                
                Circle()
                    .foregroundColor(.blue)
                    .opacity(0.4)
                    .frame(width: 44,height: 44)
                
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button{
                            viewModel.addLocation()
                        }label: {
                            Image(systemName: "plus")
                                .padding()
                                .background(.black.opacity(0.4))
                                .foregroundColor(.white)
                                .font(.title)
                                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                        }
                        .padding(.trailing)
                    }
                }
                
            }
            .sheet(item: $viewModel.selectedPlaces){place in
                EditView(location: place){newlocation in
                    viewModel.update(newlocation:  newlocation)
                }
            }
        }else{
            Button("Unlock Places"){
                viewModel.authenticate()
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
