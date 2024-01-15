//
//  WeatherAlert.swift
//  WeatherTest
//
//  Created by Егор Ярошук on 13.01.24.
//

import Foundation

struct WeatherAlert: Decodable {
    let type: String
    let features: [WeatherFeature]
    
    struct WeatherFeature: Decodable {
        let id: String
        let type: String
        let properties: Property
        
        struct Property: Decodable {
            let event: String
            let effective: String
            let ends: String?
            let senderName: String
            
            var duration: String {
                var startDate = ""
                var endDate = "..."
                let isoDateFormatter = ISO8601DateFormatter()
                let convertDateFormatter = DateFormatter()
                convertDateFormatter.dateFormat = "dd.MM.yyyy-hh:mm"
                if let isoStartDate = isoDateFormatter.date(from: effective) {
                    startDate = convertDateFormatter.string(from: isoStartDate)
                }
                if let isoEndDate = isoDateFormatter.date(from: ends ?? "") {
                    endDate = convertDateFormatter.string(from: isoEndDate)
                }
                return "\(startDate) - \(endDate)"
            }
        }
    }
}
