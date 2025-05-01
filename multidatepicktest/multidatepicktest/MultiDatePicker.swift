//
//  MultiDatePicker.swift
//  multidatepicktest
//
//  Created by Nicholas Allen on 3/20/25.
//

//
//  multidatepicktestApp.swift
//  multidatepicktest
//
//  Created by Nicholas Allen on 3/20/25.
//

import SwiftUI
import UIKit

// Create the custom MultiDatePicker SwiftUI component using UIKit's UIDatePicker
struct MultiDatePicker: UIViewRepresentable {
    @Binding var selectedDates: Set<Date>  // Track the selected dates (Set to ensure uniqueness)
    
    // Create the DatePicker
    func makeUIView(context: Context) -> UIDatePicker {
        let datePicker = UIDatePicker()
        
        // Set the mode for the date picker
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline // You can choose the style
        
        // Add target action when date is changed
        datePicker.addTarget(context.coordinator, action: #selector(Coordinator.dateChanged(_:)), for: .valueChanged)
        
        return datePicker
    }
    
    // Update the UIView (UIDatePicker) whenever the data changes in SwiftUI
    func updateUIView(_ uiView: UIDatePicker, context: Context) {
        if let firstSelectedDate = selectedDates.first {
            uiView.setDate(firstSelectedDate, animated: false)
        }
    }
    
    // Create a coordinator to handle the actions from the UIDatePicker
    func makeCoordinator() -> Coordinator {
        return Coordinator(selectedDates: $selectedDates)
    }
    
    // Coordinator class for handling date picker actions
    class Coordinator: NSObject {
        @Binding var selectedDates: Set<Date>
        
        init(selectedDates: Binding<Set<Date>>) {
            _selectedDates = selectedDates
        }
        
        // Action when the date is changed
        @objc func dateChanged(_ datePicker: UIDatePicker) {
            // If there’s already a selected date, deselect the previous one and select the new one
            if selectedDates.isEmpty {
                selectedDates.insert(datePicker.date)
            } else {
                selectedDates.removeAll() // Remove all previous selections
                selectedDates.insert(datePicker.date) // Add the new selection
            }
        }
    }
}
