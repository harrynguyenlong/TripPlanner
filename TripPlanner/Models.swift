//
//  Models.swift
//  TripPlanner
//
//  Created by Long Nguyen on 15.4.2022.
//

import Foundation
import SwiftDate

struct Trip: Codable, Identifiable, Hashable {
    let id: String = UUID().uuidString
    var name: String
    var startDate: Date?
    var endDate: Date?
    var budget: Int
    var notes: String
    var tripImage: String

    var tripDurationStr: String {
        get {
            guard let startDay = startDate?.day, let startMonth = startDate?.month, let startYear = startDate?.year, let endDay = endDate?.day, let endMonth = endDate?.month, let endYear = endDate?.year else {
                return ""
            }

            return "\(startDay)/\(startMonth)/\(startYear) - \(endDay)/\(endMonth)/\(endYear)"
        }
    }

    var tripSimpleName: String {
        get {
            guard let year = self.startDate?.year else {
                return ""
            }

            return "\(name) \(year)"
        }
    }

    var numberOfTripInDays: Int {
        get {
            guard let endDayOfYear = self.endDate?.dayOfYear, let startDayOfYear = self.startDate?.dayOfYear else {
                return 0
            }

            return (endDayOfYear - startDayOfYear)
        }
    }

    enum CodingKeys : String, CodingKey {
        case id
        case name
        case startDate
        case endDate
        case budget
        case notes
        case tripImage
    }
}
