//
//  ContentView.swift
//  Bucket list
//
//  Created by Harshit Agarwal on 24/03/23.
//

import SwiftUI

struct ContentView: View {
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
                .onTapGesture {
                    let str = "Test Message"
                    let url = getDocumentsDirectory().appendingPathComponent("message.txt")
                    do {
                        try str.write(to: url,atomically: true,encoding: .utf8)
                        let input = try String(contentsOf: url)
                        print(input)
                    }catch{
                        print(error.localizedDescription)
                    }
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
