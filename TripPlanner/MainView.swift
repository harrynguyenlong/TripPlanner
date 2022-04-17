//
//  ViewController.swift
//  TripPlanner
//
//  Created by Long Nguyen on 30.12.2021.
//

import UIKit
import SwiftUI
import SwiftDate
import Swinject

struct MainView: View {
    @State var trips: [Trip] = [
                                Trip(name: "Amsterdam", startDate: Date() - 7.months, endDate: Date() - 6.months, budget: 1200, notes: "Some test notes", tripImage: "danang"),
                                Trip(name: "Amsterdam", startDate: Date() - 7.months, endDate: Date() - 6.months, budget: 1200, notes: "Some test notes", tripImage: "seoul"),
                                Trip(name: "Amsterdam", startDate: Date() - 7.months, endDate: Date() - 6.months, budget: 1200, notes: "Some test notes", tripImage: "amsterdam"),
                                Trip(name: "Amsterdam", startDate: Date() - 7.months, endDate: Date() - 6.months, budget: 1200, notes: "Some test notes", tripImage: "amsterdam")
                               ]
    @ObservedObject var viewModel: MainViewViewModel = Container.sharedContainer.resolve(MainViewViewModel.self)!

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    HStack {
                        Text("Upcomming trips")
                            .bold()
                            .font(.title3)
                            .padding([.all])

                        Spacer()
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(self.viewModel.upcomingTrips, id: \.self) { trip in
                                TripItem(trip: trip, itemStype: .detail)
                                    .padding([.leading, .trailing], 5)
                            }
                        }
                    }

                    HStack {
                        Text("Recent trips")
                            .bold()
                            .font(.title3)
                            .padding([.all])

                        Spacer()
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(self.viewModel.recentTrips, id: \.self) { trip in
                                TripItem(trip: trip, itemStype: .simple)
                                    .padding([.leading, .trailing], 5)
                            }
                        }
                    }

                    HStack {
                        Text("Explore more")
                            .bold()
                            .font(.title3)
                            .padding([.all])

                        Spacer()
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(self.viewModel.exploreMoreTrips, id: \.self) { trip in
                                TripItem(trip: trip, itemStype: .explore)
                                    .padding([.leading, .trailing], 5)
                            }
                        }
                    }

                    Spacer()
                }
            }.navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {

                        } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .fixedSize()
                                .aspectRatio(contentMode: .fit)
                        }
                    }

                    ToolbarItem(placement: .principal) {
                        Text("Ezitrip")
                            .bold()
                    }
                }
        }.onAppear {
            self.viewModel.getUpcomingTrips()
            self.viewModel.getRecentTrips()
            self.viewModel.getExploreTrips()
        }
    }
}

enum TripItemStyle {
    case detail
    case simple
    case explore
}

struct TripItem: View {
    var trip: Trip
    var itemStype: TripItemStyle

    var body: some View {
        ZStack(alignment: .bottom) {
            Image(trip.tripImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: self.itemStype == .detail ? 255 : 120, height: self.itemStype == .detail ? 225 : 180, alignment: .center)


            VStack(alignment: .leading) {
                switch self.itemStype {
                case .detail:
                    HStack {
                        Text(trip.tripDurationStr)
                            .foregroundColor(.white)
                            .padding([.top, .leading])

                        Spacer()
                    }

                    HStack {
                        Text("€ \(trip.budget)")
                            .padding([.top, .bottom], 5)
                            .padding([.leading, .trailing], 16)
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .strokeBorder()
                                    .foregroundColor(.white)
                            )

                        Spacer()
                    }.padding([.leading])

                    HStack {
                        Text(trip.name)
                            .bold()
                            .foregroundColor(.white)

                        Spacer()
                    }.padding([.leading])

                    HStack {
                        Text("See trip")
                            .foregroundColor(.white)
                            .padding([.top, .bottom], 5)
                            .padding([.leading, .trailing], 16)
                            .background(TPColors.buttonBackground)
                            .cornerRadius(10)

                        Spacer()
                    }.padding([.leading, .bottom])
                case .simple:
                    HStack {
                        Text(trip.tripSimpleName)
                            .font(.callout)
                            .bold()
                            .foregroundColor(.white)

                        Spacer()
                    }.padding([.leading, .top])

                    HStack {
                        Text("\(self.trip.numberOfTripInDays) days")
                            .font(.footnote)
                            .foregroundColor(.white)

                        Spacer()
                    }.padding([.leading, .trailing, .bottom])
                case .explore:
                    HStack {
                        Text(trip.name)
                            .font(.callout)
                            .bold()
                            .foregroundColor(.white)

                        Spacer()
                    }.padding([.leading, .top, .bottom])
                }
            }.background(TPColors.background)
            .cornerRadius(15)
        }
        .frame(width: self.itemStype == .detail ? 255 : 120, height: self.itemStype == .detail ? 225 : 180, alignment: .center)
        .cornerRadius(15)
    }
}

