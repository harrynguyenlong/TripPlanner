//
//  MainViewViewModel.swift
//  TripPlanner
//
//  Created by Long Nguyen on 17.4.2022.
//

import Foundation
import Combine

class MainViewViewModel: ObservableObject {
    private let getUpcomingTripsUsecase: GetUpcomingTripsUsecase
    private let getRecentTripsUsecase: GetRecentTripsUsecase
    private let getExploreTripsUsecase: GetExploreTripsUsecase
    private var disposables = Set<AnyCancellable>()

    @Published var upcomingTrips = [Trip]()
    @Published var recentTrips = [Trip]()
    @Published var exploreMoreTrips = [Trip]()

    init(getUpcomingTripsUsecase: GetUpcomingTripsUsecase, getRecentTripsUsecase: GetRecentTripsUsecase, getExploreTripsUsecase: GetExploreTripsUsecase) {
        self.getUpcomingTripsUsecase = getUpcomingTripsUsecase
        self.getRecentTripsUsecase = getRecentTripsUsecase
        self.getExploreTripsUsecase = getExploreTripsUsecase
    }

    func getUpcomingTrips() {
        self.getUpcomingTripsUsecase.execute().sink { completion in
            switch completion {
            case .failure(_):
                break
            case .finished:
                break
            }
        } receiveValue: { trips in
            self.upcomingTrips = trips
        }.store(in: &disposables)
    }

    func getRecentTrips() {
        self.getRecentTripsUsecase.execute().sink { completion in
            switch completion {
            case .failure(_):
                break
            case .finished:
                break
            }
        } receiveValue: { trips in
            self.recentTrips = trips
        }.store(in: &disposables)
    }

    func getExploreTrips() {
        self.getExploreTripsUsecase.execute().sink { completion in
            switch completion {
            case .failure(_):
                break
            case .finished:
                break
            }
        } receiveValue: { trips in
            self.exploreMoreTrips = trips
        }.store(in: &disposables)
    }
}
