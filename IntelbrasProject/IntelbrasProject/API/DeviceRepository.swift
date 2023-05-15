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

    func createVideoDevice(_ device: CreationVideoDeviceParameters) -> Completable {
        Completable.create(subscribe: { observer in
            let url = URL(string: Constants.videoDevicesURL)!

            let jsonData = try! JSONSerialization.data(withJSONObject: device, options: [])

            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("Bearer " + self.token, forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

            return self.handleRequest(observer: observer, urlRequest: request)
        })
    }

    func deleteVideoDevice(withID id: String) -> Completable {
        Completable.create(subscribe: { observer in
            let urlString = Constants.videoDevicesURL + id
            let url = URL(string: urlString)!
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.delete.rawValue
            request.addValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")

            return self.handleRequest(observer: observer, urlRequest: request)
        })
    }
}

enum APIError: Error {
    case invalidResponse
    case noData
    case decodingError
    case missingConnection
    case unknown
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

struct AlarmCentralResponse: Codable {
    let count: Int
    let data: [AlarmCentralDTO]
}

struct VideoDeviceResponse: Codable {
    let count: Int
    let data: [VideoDeviceDTO]
}
