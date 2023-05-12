//
//  VideoDevice.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 11/05/23.
//

import Foundation

struct VideoDevice: Device {
    let id: String
    let name: String
    let serial: String
    let macAddress: String
    let username: String
    let password: String
    let type = DeviceType.video
}

extension VideoDevice {

    static func getMockVideoDevices() -> [VideoDevice] {
        let videoDevice1 = VideoDevice(id: "1",
                                        name: "Alarm 1",
                                        serial: "Serial 1",
                                        macAddress: "MacAddress 1",
                                        username: "Username 1",
                                        password: "Password 1")

        let videoDevice2 = VideoDevice(id: "2",
                                        name: "Alarm 2",
                                        serial: "Serial 2",
                                        macAddress: "MacAddress 2",
                                        username: "Username 2",
                                        password: "Password 2")

        let videoDevice3 = VideoDevice(id: "3",
                                         name: "Alarm 3",
                                         serial: "Serial 3",
                                         macAddress: "MacAddress 3",
                                         username: "Username 3",
                                         password: "Password 3")

        return [videoDevice1, videoDevice2, videoDevice3]
    }
}
