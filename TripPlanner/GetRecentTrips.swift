//
//  GetRecentTrips.swift
//  TripPlanner
//
//  Created by Long Nguyen on 17.4.2022.
//

import Foundation
import Combine

class GetRecentTripsUsecase {
    private let repo: TripDataRepository

    init(repo: TripDataRepository) {
        self.repo = repo
    }

    func execute() -> AnyPublisher<[Trip], Error> {
        return self.repo.getRecentTrips()
    }
}
