//
//  TruckModel.swift
//  TruckApp
//
//  Created by SAGAR SINGH on 01/04/24.
//

import Foundation

struct TruckModel: Codable {
    let data: [TruckDataModel]?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decodeIfPresent([TruckDataModel].self, forKey: .data)
    }
}

struct TruckDataModel: Codable {
    let truckNumber: String?
    let lastWaypoint: LastWaypoint?
    let lastRunningState: LastRunningState?
    let id: Int?
    
    enum CodingKeys: CodingKey {
        case truckNumber
        case lastWaypoint
        case lastRunningState
        case id
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.truckNumber = try container.decodeIfPresent(String.self, forKey: .truckNumber)
        self.lastWaypoint = try container.decodeIfPresent(LastWaypoint.self, forKey: .lastWaypoint)
        self.lastRunningState = try container.decodeIfPresent(LastRunningState.self, forKey: .lastRunningState)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
    }
}

struct LastRunningState: Codable {
    let stopStartTime: Int?
    let truckRunningState: Int?
    
    enum CodingKeys: CodingKey {
        case stopStartTime
        case truckRunningState
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.stopStartTime = try container.decodeIfPresent(Int.self, forKey: .stopStartTime)
        self.truckRunningState = try container.decodeIfPresent(Int.self, forKey: .truckRunningState)
    }
}

struct LastWaypoint: Codable {
    let lat: Double?
    let lng: Double?
    let createTime: Int?
    let speed: Double?
    let ignitionOn: Bool?
    
    enum CodingKeys: CodingKey {
        case lat
        case lng
        case createTime
        case speed
        case ignitionOn
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lat = try container.decodeIfPresent(Double.self, forKey: .lat)
        self.lng = try container.decodeIfPresent(Double.self, forKey: .lng)
        self.createTime = try container.decodeIfPresent(Int.self, forKey: .createTime)
        self.speed = try container.decodeIfPresent(Double.self, forKey: .speed)
        self.ignitionOn = try container.decodeIfPresent(Bool.self, forKey: .ignitionOn)
    }
}
