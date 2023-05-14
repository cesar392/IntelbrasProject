//
//  DeviceRepositoryProtocol.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 13/05/23.
//

import Foundation
import RxSwift

protocol AlarmCentralRepositoryProtocol {
    func fetchAlarmCentral() -> Observable<[AlarmCentralDTO]>
}

protocol VideoDeviceRepositoryProtocol {
    func fetchVideoDevices() -> Observable<[VideoDeviceDTO]>
}
