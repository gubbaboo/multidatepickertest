//
//  ContentView.swift
//  multidatepicktest
//
//  Created by Nicholas Allen on 3/20/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDates: Set<Date> = [] // Track the selected date(s)
    
    var body: some View {
        VStack(alignment: .center) {
            // Add the custom MultiDatePicker here
            MultiDatePicker(selectedDates: $selectedDates)
                .frame(height: 320)
                .padding()
                .background(Color(hue: 0.118
                                  , saturation: 1, brightness: 1))
            
            
            // Button to deselect the current selected date
            Text("Selected Date: \(selectedDates.first?.formatted(date: .complete, time: .omitted) ?? "None")")
                .padding()
            
            Text("hello")
            
            ScrollView {
                VStack(alignment:  .leading) {
                        ForEach(0..<100) {
                            Text("Row \($0)")
                        }
                    }
                }
            
            }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .border(Color(hue: 0.282, saturation: 0.153, brightness: 0.347), width: 10)
        
            .padding()
            .background(Color(hue: 0
                       ,saturation: 0, brightness: 0.953))
        }
    }

#Preview {
    ContentView()
}
