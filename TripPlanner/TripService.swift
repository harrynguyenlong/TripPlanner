//
//  TripService.swift
//  TripPlanner
//
//  Created by Long Nguyen on 17.4.2022.
//

import Foundation
import Combine
import SwiftDate

///
protocol TripServiceProtocol {
    func getUpcomingTrips() -> AnyPublisher<[Trip], Error>
    func getRecentTrips() -> AnyPublisher<[Trip], Error>
    func getExploreTrips() -> AnyPublisher<[Trip], Error> 
}

/// TripService: Handle get data for trips. Currently return mocked data. In reality, URLSession should be injected to make actual requests.
class TripService: TripServiceProtocol {

    init() {
    }

    /**
        Get upcoming trips

        - Returns: A publisher that emits current upcoming trips.
     */
    func getUpcomingTrips() -> AnyPublisher<[Trip], Error> {
        let trips = [
                        Trip(name: "Amsterdam", startDate: Date() + 4.months, endDate: Date() + 4.months + 4.days, budget: 1200, notes: "", tripImage: "amsterdam"),
                        Trip(name: "Paris", startDate: Date() + 3.months, endDate: Date() + 3.months + 14.days, budget: 1500, notes: "", tripImage: "paris")
                    ]
        return Just(trips).mapError { _ -> Error in
        }.eraseToAnyPublisher()
    }

    /**
        Get recent trips

        - Returns: A publisher that emits current upcoming trips.
     */
    func getRecentTrips() -> AnyPublisher<[Trip], Error> {
        let trips = [
                        Trip(name: "Da Nang", startDate: Date() - 6.months - 4.days, endDate: Date() - 6.months, budget: 1000, notes: "", tripImage: "danang"),
                        Trip(name: "Thailand", startDate: Date() - 4.months - 6.days, endDate: Date() - 4.months, budget: 800, notes: "", tripImage: "thailand"),
                        Trip(name: "Tokyo", startDate: Date() - 3.months - 7.days, endDate: Date() - 3.months, budget: 1800, notes: "", tripImage: "tokyo")
                    ]
        return Just(trips).mapError { _ -> Error in
        }.eraseToAnyPublisher()
    }


    /**
        Get explore trips

        - Returns: A publisher that emits current explore trips.
     */
    func getExploreTrips() -> AnyPublisher<[Trip], Error> {
        let trips = [
                        Trip(name: "Bali", budget: 1000, notes: "", tripImage: "bali"),
                        Trip(name: "Singapore", budget: 1200, notes: "", tripImage: "singapore"),
                        Trip(name: "Seoul", budget: 1800, notes: "", tripImage: "seoul")
                    ]
        return Just(trips).mapError { _ -> Error in
        }.eraseToAnyPublisher()
    }
}
