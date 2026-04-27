//
//  ESSIApp.swift
//  ESSI
//
//  Created by Jim Walejko on 4/22/26.
//

import SwiftUI
import SwiftData

@main
struct ESSIApp: App {
    var body: some Scene {
        WindowGroup {
            SnackListView()
                .modelContainer(for: Snack.self)  //  sets up the 'container' or database structure - it will hold Snack types
        }
    }
    
    //  print out the application path where simulator data can be found - if browsing with DB Browser
    init(){
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
