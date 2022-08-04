//
//  Date+Extension.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 21/07/2022.
//

import Foundation

extension Date {
    
    private static var yearMonthDayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    static func formatDateToString(_ date: Date) -> String {
        yearMonthDayFormatter.string(from: date)
    }
    
    static func formatStringToDate(_ string: String) -> Date? {
        yearMonthDayFormatter.date(from: string)
    }
    
}
