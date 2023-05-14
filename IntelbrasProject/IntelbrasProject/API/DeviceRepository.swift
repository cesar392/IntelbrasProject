//
//  DeviceRepository.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 13/05/23.
//

import Foundation
import RxSwift

class AlarmCentralRepository: AlarmCentralRepositoryProtocol, IntelbrasAPIRequestHandler {

    private let token: String

    init(token: String) {
        self.token = token
    }

    func fetchAlarmCentral() -> Observable<[AlarmCentralDTO]> {
        let alarmResponse: Observable<AlarmCentralResponse> = Observable.create {
            observer -> Disposable in
            var request = URLRequest(url: URL(string: Constants.alarmCentralsURL)!)
            request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
            return self.handleRequest(observer: observer, urlRequest: request)
        }
        return alarmResponse.map({ $0.data })
    }
}

class VideoDeviceRepository: VideoDeviceRepositoryProtocol, IntelbrasAPIRequestHandler {

    private let token: String

    init(token: String) {
        self.token = token
    }

    func fetchVideoDevices() -> Observable<[VideoDeviceDTO]> {
        let videoResponse: Observable<VideoDeviceResponse> = Observable.create {
            observer -> Disposable in
            var request = URLRequest(url: URL(string: Constants.videoDevicesURL)!)
            request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
            return self.handleRequest(observer: observer, urlRequest: request)
        }
        return videoResponse.map({ $0.data })
    }
}

enum APIError: Error {
    case invalidResponse
    case noData
    case decodingError
    case missingConnection
}

struct AlarmCentralResponse: Codable {
    let count: Int
    let data: [AlarmCentralDTO]
}

struct VideoDeviceResponse: Codable {
    let count: Int
    let data: [VideoDeviceDTO]
}
