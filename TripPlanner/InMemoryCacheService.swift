//
//  InMemoryCacheService.swift
//  TripPlanner
//
//  Created by Long Nguyen on 17.4.2022.
//

import Foundation

class InMemoryCacheService {
    private var inMemoryCache: Dictionary<String, Any> = Dictionary<String, Any>()
    private let UPCOMING_TRIPS = "UPCOMING_TRIPS"

    init() {
    }

    func getUpcomingTrips() -> [Trip]? {
        let upcomingTrips = inMemoryCache[UPCOMING_TRIPS]

        if let upcomingTrips = upcomingTrips as? [Trip] {
            return upcomingTrips
        }

        return nil
    }

    func setUpcomingTrips(upcomingTrips: [Trip]) {
        self.inMemoryCache[UPCOMING_TRIPS] = upcomingTrips
    }
}
