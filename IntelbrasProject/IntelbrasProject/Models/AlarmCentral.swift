//
//  AlarmCentral.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 11/05/23.
//

import Foundation
import UIKit

struct AlarmCentral: Device {
    let id: String
    let name: String
    let macAddress: String
    let password: String
    let favorite: Bool
    let image: UIImage? = R.image.icAlarmDevice()
    let deviceType: DeviceType = .alarm
}

// MARK: - Mock Data
extension AlarmCentral {
    static func getMockAlarmCentrals() -> [AlarmCentral] {
        let alarmCentral1 = AlarmCentral(id: "1",
                                         name: "Alarm 1",
                                         macAddress: "MacAddress 1",
                                         password: "Password 1",
                                         favorite: true)

        let alarmCentral2 = AlarmCentral(id: "2",
                                         name: "Alarm 2",
                                         macAddress: "MacAddress 2",
                                         password: "Password 2",
                                         favorite: false)

        let alarmCentral3 = AlarmCentral(id: "3",
                                         name: "Alarm 3",
                                         macAddress: "MacAddress 3",
                                         password: "Password 3",
                                         favorite: true)

        return [alarmCentral1, alarmCentral2, alarmCentral3]
    }
}
