//
//  Repositories.swift
//  TripPlanner
//
//  Created by Long Nguyen on 17.4.2022.
//

import Foundation
import Combine

protocol TripDataRepository {
    func getUpcomingTrips() -> AnyPublisher<[Trip], Error>
    func getRecentTrips() -> AnyPublisher<[Trip], Error>
    func getExploreTrips() -> AnyPublisher<[Trip], Error>
}

class TripDataRepositoryImpl: TripDataRepository {
    private let tripService: TripServiceProtocol
    private let inMemoryCache: InMemoryCacheService

    init(tripService: TripServiceProtocol, inMemoryCache: InMemoryCacheService) {
        self.tripService = tripService
        self.inMemoryCache = inMemoryCache
    }

    func getUpcomingTrips() -> AnyPublisher<[Trip], Error> {
        if let cachedUpcomingTrips = self.inMemoryCache.getUpcomingTrips() {
            return Just(cachedUpcomingTrips)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
        }

        return self.tripService.getUpcomingTrips()
    }

    func getRecentTrips() -> AnyPublisher<[Trip], Error> {
        return self.tripService.getRecentTrips()
    }

    func getExploreTrips() -> AnyPublisher<[Trip], Error> {
        return self.tripService.getExploreTrips()
    }
}
