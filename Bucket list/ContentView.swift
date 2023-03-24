//
//  ContentView.swift
//  Bucket list
//
//  Created by Harshit Agarwal on 24/03/23.
//

import SwiftUI
struct User:Identifiable,Comparable{
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func<(lhs: User,rhs:User)->Bool{
        lhs.lastName<rhs.lastName
    }
}
struct ContentView: View {
    let values = [1,3,4,56,7,2,-7].sorted()
    let users = [User(firstName: "Taylor", lastName: "Swift"),
                 User(firstName: "Liam", lastName: "Payne"),
                 User(firstName: "Louis", lastName: "Tomilson")].sorted()
    var body: some View {
        Form{
            List(values,id: \.self){
                Text(String($0))
            }
            
            List(users) { user in
                Text("\(user.firstName) \(user.lastName)")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
