//
//  ContentView.swift
//  Bucket list
//
//  Created by Harshit Agarwal on 24/03/23.
//
import LocalAuthentication
import SwiftUI

struct ContentView: View {
    @State private var isUnlocked = true
    
    var body: some View {
        VStack {
            if isUnlocked{
                Text("Unlocked")
            }else{
                Text("Locked")
            }
        }
        .padding()
    }
    
    
    
    func authenticate(){
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "We need to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){success , authenticatioError in
                if success{
                    
                }else{
                    
                }
                
                
            }
        }
        else{
            //No biometrics
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
