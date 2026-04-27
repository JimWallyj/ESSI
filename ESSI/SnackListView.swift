//
//  SnackListView.swift
//  ESSI
//
//  Created by Jim Walejko on 4/22/26.
//

import SwiftUI
import SwiftData

struct SnackListView: View {
    @Query private var snacks: [Snack]
    @State private var sheetIsPresented = false
    @Environment(\.modelContext) private var modelContext  //  for holding temporary data before saving
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(snacks){ snack in
                    NavigationLink{
                        SnackDetailView(snack: snack)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(snack.name)
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .lineLimit(1)
                        
                            HStack{
                                Text("Qty: \(snack.onHand)")
                                Text(snack.notes)
                                    .italic()
                                    .lineLimit(1)
                                    .foregroundStyle(.secondary)
                            }
                            .font(.body)
                        }
                    }
                    .swipeActions{
                        Button("Delete", role: .destructive){
                            modelContext.delete(snack)
                            guard let _ = try? modelContext.save() else{
                                print("😡 Swipe to delete didn't work")
                                return
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Snacks on Hand:")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        sheetIsPresented.toggle()
                    }label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $sheetIsPresented){
                NavigationStack{
                    SnackDetailView(snack: Snack())
                }
            }
        }
    }
}

#Preview {
    SnackListView()
        .modelContainer(Snack.preview)  //  show Mock Data in the Preview
}
