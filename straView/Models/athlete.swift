//
//  athlete.swift
//  straView
//
//  Created by Jonas Wangelin on 03.11.24.
//

import Foundation

struct Athlete: Codable {
    let id: Int
    let username: String?
    let resourceState: Int?
    let firstname: String?
    let lastname: String?
    let city: String?
    let state: String?
    let country: String?
    let sex: String?
//    let premium: Bool?
//    let createdAt: String?
//    let updatedAt: String?
//    let profileMedium: String?
//    let profile: String?
//    let friend: Int?
//    let follower: Int?
//    let followerCount: Int?
//    let friendCount: Int?
//    let mutualFriendCount: Int?
//    let athleteType: Int?
//    let datePreference: String?
//    let measurementPreference: String?
//    let ftp: Int?
//    let weight: Double?
}


extension Athlete {
    static let TEST_ATHLETE = Athlete(
        id: 1,
        username: "test",
        resourceState: 1,
        firstname: "Test",
        lastname: "User",
        city: "Test",
        state: "Test",
        country: "Test",
        sex: "Test"
    )
}
