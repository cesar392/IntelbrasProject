//
//  AlarmCentral.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 11/05/23.
//

import Foundation
import UIKit

struct AlarmCentral: Codable {
    let id: String
    var name: String
    var macAddress: String
    var password: String
}

// MARK: - Extension BaseDevice
extension AlarmCentral: BaseDevice {
    func getImage() -> UIImage? {
        return R.image.icAlarmDevice()
    }

    func getType() -> DeviceType {
        return .alarm
    }
}

// MARK: - Mock Data
extension AlarmCentral {
    static func getMockAlarmCentrals() -> [AlarmCentral] {
        let alarmCentral1 = AlarmCentral(id: "1",
                                         name: "Alarm 1",
                                         macAddress: "MacAddress 1",
                                         password: "Password 1")

        let alarmCentral2 = AlarmCentral(id: "2",
                                         name: "Alarm 2",
                                         macAddress: "MacAddress 2",
                                         password: "Password 2")

        let alarmCentral3 = AlarmCentral(id: "3",
                                         name: "Alarm 3",
                                         macAddress: "MacAddress 3",
                                         password: "Password 3")

        return [alarmCentral1, alarmCentral2, alarmCentral3]
    }
}
