//
//  DependencyManager.swift
//  TripPlanner
//
//  Created by Long Nguyen on 17.4.2022.
//

import Foundation
import Swinject

public extension Container {

    // All the dependecies should be define here.
    /// Container will remain in the scope until all the dependecies get resolved
    static let sharedContainer : Container = {
        let container = Container()

        // MARK: Services
        container.register(TripServiceProtocol.self) { (r) in
            return TripService()
        }.inObjectScope(.container)

        container.register(InMemoryCacheService.self) { (r) in
            return InMemoryCacheService()
        }.inObjectScope(.container)

        // MARK: Repository
        container.register(TripDataRepository.self) { (r) in
            let tripService = container.resolve(TripServiceProtocol.self)!
            let inMemoryCache = container.resolve(InMemoryCacheService.self)!

            return TripDataRepositoryImpl(tripService: tripService, inMemoryCache: inMemoryCache)
        }.inObjectScope(.container)

        // MARK: Usecases
        container.register(GetUpcomingTripsUsecase.self) { (r) in
            let repository = container.resolve(TripDataRepository.self)!

            return GetUpcomingTripsUsecase(repo: repository)
        }

        container.register(GetRecentTripsUsecase.self) { (r) in
            let repository = container.resolve(TripDataRepository.self)!

            return GetRecentTripsUsecase(repo: repository)
        }

        container.register(GetExploreTripsUsecase.self) { (r) in
            let repository = container.resolve(TripDataRepository.self)!

            return GetExploreTripsUsecase(repo: repository)
        }

        // MARK: ViewModel
        container.register(MainViewViewModel.self) { (r) in
            let getUpcomingTripsUsecase = container.resolve(GetUpcomingTripsUsecase.self)!
            let getRecentTripsUsecase = container.resolve(GetRecentTripsUsecase.self)!
            let getExploreTripsUsecase = container.resolve(GetExploreTripsUsecase.self)!

            return MainViewViewModel(getUpcomingTripsUsecase: getUpcomingTripsUsecase, getRecentTripsUsecase: getRecentTripsUsecase, getExploreTripsUsecase: getExploreTripsUsecase)
        }

        return container
    }()
}

