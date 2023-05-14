//
//  NetworkFetcher.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 13/05/23.
//

import Foundation
import RxSwift

class NetworkFetcher {

    private let alarmCentralService: AlarmCentralServiceProtocol
    private let videoDeviceService: VideoDeviceServiceProtocol

    init(alarmCentralService: AlarmCentralServiceProtocol,
         videoDeviceService: VideoDeviceServiceProtocol) {
        self.alarmCentralService = alarmCentralService
        self.videoDeviceService = videoDeviceService
    }

    func fetchAlarmCentral(withToken token: String) -> Observable<[AlarmCentral]> {
        return alarmCentralService.fetchAlarmCentral(withToken: token)
    }

    func fetchVideoDevices(withToken token: String) -> Observable<[VideoDevice]> {
        return videoDeviceService.fetchVideoDevices(withToken: token)
    }
}
