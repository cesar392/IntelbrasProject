//
//  ServicesProtocol.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 13/05/23.
//

import Foundation
import RxSwift

protocol AlarmCentralServiceProtocol {
    func fetchAlarmCentral(withToken token: String) -> Observable<[AlarmCentral]>
}

protocol VideoDeviceServiceProtocol {
    func fetchVideoDevices(withToken token: String) -> Observable<[VideoDevice]>
}
