//
//  ContentView-ViewModel.swift
//  Bucket list
//
//  Created by Harshit Agarwal on 13/04/23.
//

import Foundation
import MapKit
import LocalAuthentication


extension ContentView{
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published  var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 27.582256, longitude: 77.697083), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 15))
        @Published  private(set) var location: [Location]
        @Published  var selectedPlaces: Location?
        @Published var isUnlocked = false
        
        let savedPath = FileManager.documentDirectory.appendingPathComponent("SavedPlaces")
        
        init(){
            do{
                let data = try Data(contentsOf: savedPath)
                location = try JSONDecoder().decode( [Location].self, from: data)
            }catch{
                location = [ ]
            }
        }
        
        func save(){
            do {
                let data = try JSONEncoder().encode(location)
                try data.write(to: savedPath, options: [.atomic,.completeFileProtection])
            }catch{
                print("Unable to save data")
            }
        }
        
        func addLocation(){
            let newLocation = Location(name: "New Location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            location.append(newLocation)
            save()
        }
        func update(newlocation: Location){
            guard let selectedPlaces = selectedPlaces else { return }
            
            if let index = location.firstIndex(of: selectedPlaces){
                location[index] = newlocation
            }
            save()
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
                let reason = "We need to unlock your data"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,  localizedReason: reason) { success, authenticateError in
                    if success {
                        Task { @MainActor in
                            self.isUnlocked = true
                        }
                    }else{
                        //Error
                    }
                }
            }else{
                //No biometric
            }
        }
        
        
    }
}
