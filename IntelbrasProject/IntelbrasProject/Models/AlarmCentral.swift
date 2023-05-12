//
//  AlarmCentrals.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 11/05/23.
//

import Foundation

struct AlarmCentrals {
    let id: String
    let name: String
    let macAddress: String
    let password: String
}

extension AlarmCentrals {

    func getMockAlarmCentrals() -> [AlarmCentrals] {
        let alarmCentral1 = AlarmCentrals(id: "1",
                                          name: "Alarm 1",
                                          macAddress: "MacAddress 1",
                                          password: "Password 1")

        let alarmCentral2 = AlarmCentrals(id: "2",
                                          name: "Alarm 2",
                                          macAddress: "MacAddress 2",
                                          password: "Password 2")

        let alarmCentral13 = AlarmCentrals(id: "3",
                                           name: "Alarm 3",
                                           macAddress: "MacAddress 3",
                                           password: "Password 3")

        return [alarmCentral1, alarmCentral2, alarmCentral3]
    }
}
