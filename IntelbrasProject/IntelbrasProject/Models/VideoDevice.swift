//
//  VideoDevice.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 11/05/23.
//

import Foundation
import UIKit

struct VideoDevice: Device {
    let id: String
    let name: String
    let serial: String
    let username: String
    let password: String
    let favorite: Bool
    let image: UIImage? = R.image.icVideoDevice()
    let deviceType: DeviceType = .video
}

// MARK: - Mock Data
extension VideoDevice {
    static func getMockVideoDevices() -> [VideoDevice] {
        let videoDevice1 = VideoDevice(id: "1",
                                       name: "Video 1",
                                       serial: "Serial 1",
                                       username: "Username 1",
                                       password: "Password 1",
                                       favorite: false)

        let videoDevice2 = VideoDevice(id: "2",
                                       name: "Video 2",
                                       serial: "Serial 2",
                                       username: "Username 2",
                                       password: "Password 2",
                                       favorite: true)

        let videoDevice3 = VideoDevice(id: "3",
                                       name: "Video 3",
                                       serial: "Serial 3",
                                       username: "Username 3",
                                       password: "Password 3",
                                       favorite: false)

        return [videoDevice1, videoDevice2, videoDevice3]
    }
}
