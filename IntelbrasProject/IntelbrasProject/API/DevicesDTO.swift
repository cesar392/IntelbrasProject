//
//  DevicesDTO.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 14/05/23.
//

import Foundation

struct AlarmCentralDTO: Codable {
    let id: String
    var name: String
    var macAddress: String
    var password: String
}

struct VideoDeviceDTO: Codable {
    let id: String
    var name: String
    var serial: String
    var username: String
    var password: String
}
