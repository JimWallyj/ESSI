//
//  SnackDetailView.swift
//  ESSI
//
//  Created by Jim Walejko on 4/23/26.
//

import SwiftUI
import SwiftData

struct SnackDetailView: View {
  
    enum ComfortLevel: Int, CaseIterable{
        case doesTheJob = 1, solid = 2, cravingSatisfyer = 3, gourmet = 4, emergencyComfort = 5
        
        var label: String{
            switch self{
            case .doesTheJob: return "1 - ✅ Does the job"
            case .solid: return "2 - 👍 Solid"
            case .cravingSatisfyer: return "3 - 😔 Craving met"
            case .gourmet: return "4 - 🧑‍🍳 Gourmet"
            case .emergencyComfort: return "5 - 🚨 Emergency"
            }
        }
    }
    
    @State var snack: Snack  //  passed from SnackListView
    @State private var name: String = ""
    @State private var onHand = 0
    @State private var notes = ""
    @State private var selectedComfortLevel = 1
    
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading){
            TextField("snack name", text: $name)
                .font(.largeTitle)
                .textFieldStyle(.roundedBorder)
            
            HStack{
                Text("Qty:").bold()
                Spacer()
                Text("\(onHand)")
                Stepper("", value: $onHand, in: 0...Int.max)
                    .labelsHidden()
            }
            .padding(.bottom)
            
            HStack{
                Text("Comfort Level:")
                    .bold()
                
                Picker("", selection: $selectedComfortLevel) {
                    ForEach(ComfortLevel.allCases, id: \.self) { comfortLevel in
                        Text(comfortLevel.label)
                            .tag(comfortLevel.rawValue)
                    }
                }
            }
            .padding(.bottom)
            
            Text("Notes:").bold()
            TextField("notes", text: $notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
            
            Spacer()
        }
        .padding(.horizontal)
        .font(.title2)
        .navigationBarBackButtonHidden()
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                Button("Cancel"){
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing){
                Button("Save"){
                    snack.name = name
                    snack.onHand = onHand
                    snack.notes = notes
                    snack.comfortLevel = selectedComfortLevel
                    modelContext.insert(snack)  //  will add new or update existing
                    guard let _ = try? modelContext.save() else{  //  only needed for simulator p forces save so you can browse with DB Browser
                        print("😡 ERROR: modelContext.save didn't work in SnackDetailView")
                        return
                    }
                    dismiss()
                }
            }
        }
        .onAppear{
            name = snack.name
            onHand = snack.onHand
            notes = snack.notes
            selectedComfortLevel = snack.comfortLevel
        }
    }
}

#Preview{
    NavigationStack {
        SnackDetailView(snack: Snack(
            name: "Lil Swifties",
            onHand: 3,
            notes: "Homemade cookies baked by Prof. G. He will bring these for Lunar New Year.",
            comfortLevel: 5
        ))
    }
}
