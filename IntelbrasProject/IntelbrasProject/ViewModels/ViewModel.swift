//
//  ViewModel.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 13/05/23.
//

import Foundation

class ViewModel {

    // MARK: - Variables
    lazy var devicesList: [Device] = {
        var deviceList = [Device]()
        deviceList.append(contentsOf: AlarmCentral.getMockAlarmCentrals())
        deviceList.append(contentsOf: VideoDevice.getMockVideoDevices())
        return deviceList
    }()

}
