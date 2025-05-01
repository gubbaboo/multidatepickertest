//
//  iCal.swift
//  multidatepicktest
//
//  Created by Nicholas Allen on 3/20/25.
//

import Foundation

// Define a struct to represent an iCalendar event
struct CalendarEvent {
    let uid: String
    let summary: String
    let startDate: Date
    let endDate: Date
    let location: String?
    let description: String?
}

class ICalParser {
    // Function to load the .ics file from the app bundle or any URL
    func loadIcsFile(from url: URL) -> String? {
        do {
            let icsContent = try String(contentsOf: url, encoding: .utf8)
            return icsContent
        } catch {
            print("Error reading the file: \(error)")
            return nil
        }
    }
    
    // Function to parse the .ics content into calendar events
    func parseIcsContent(_ content: String) -> [CalendarEvent] {
        var events: [CalendarEvent] = []
        
        // Split the content by events (BEGIN:VEVENT and END:VEVENT)
        let eventSections = content.components(separatedBy: "BEGIN:VEVENT")
        
        for eventSection in eventSections.dropFirst() {  // Drop the first section because it's before the first event
            let eventDetails = eventSection.components(separatedBy: "END:VEVENT").first ?? ""
            
            // Extract fields from the event (like UID, SUMMARY, DTSTART, DTEND, LOCATION, DESCRIPTION)
            if let event = extractEventDetails(from: eventDetails) {
                events.append(event)
            }
        }
        
        return events
    }
    
    // Function to extract details from each individual event
    func extractEventDetails(from eventSection: String) -> CalendarEvent? {
        var uid: String?
        var summary: String?
        var startDate: Date?
        var endDate: Date?
        var location: String?
        var description: String?
        
        // Extract each field using regular expressions or simple string matching
        let lines = eventSection.split(separator: "\n")
        
        for line in lines {
            if line.hasPrefix("UID:") {
                uid = String(line.dropFirst(4))
            } else if line.hasPrefix("SUMMARY:") {
                summary = String(line.dropFirst(8))
            } else if line.hasPrefix("DTSTART:") {
                startDate = parseDate(from: String(line.dropFirst(8)))
            } else if line.hasPrefix("DTEND:") {
                endDate = parseDate(from: String(line.dropFirst(6)))
            } else if line.hasPrefix("LOCATION:") {
                location = String(line.dropFirst(9))
            } else if line.hasPrefix("DESCRIPTION:") {
                description = String(line.dropFirst(12))
            }
        }
        
        if let uid = uid, let summary = summary, let startDate = startDate, let endDate = endDate {
            return CalendarEvent(uid: uid, summary: summary, startDate: startDate, endDate: endDate, location: location, description: description)
        }
        
        return nil
    }
    
    // Helper function to parse the date from DTSTART/DTEND fields
    func parseDate(from dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd'T'HHmmssZ"  // iCalendar date format
        return dateFormatter.date(from: dateString)
    }
    
    // Function to find events on a specific date
    func findEventsOn(date: Date, events: [CalendarEvent]) -> [CalendarEvent] {
        // Create a calendar instance for comparison (ignoring time for the comparison)
        let calendar = Calendar.current
        return events.filter { event in
            return calendar.isDate(event.startDate, inSameDayAs: date)
        }
    }
}
