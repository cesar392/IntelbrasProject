//
//  DeviceRepository.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 13/05/23.
//

import Foundation
import RxSwift

class AlarmCentralRepository: AlarmCentralRepositoryProtocol {

    private let token: String

    init(token: String) {
        self.token = token
    }

    func fetchAlarmCentral() -> Observable<[AlarmCentralDTO]> {
        return Observable.create { observer -> Disposable in
            var request = URLRequest(url: URL(string: Constants.alarmCentralsURL)!)
            request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer.onError(error)
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse,
                        (200...299).contains(httpResponse.statusCode) else {
                    observer.onError(APIError.invalidResponse)
                    return
                }

                guard let data = data else {
                    observer.onError(APIError.noData)
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(AlarmCentralResponse.self, from: data)
                    observer.onNext(response.data)
                    observer.onCompleted()
                } catch {
                    observer.onError(APIError.decodingError)
                }
            }

            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}

class VideoDeviceRepository: VideoDeviceRepositoryProtocol {

    private let token: String

    init(token: String) {
        self.token = token
    }


    func fetchVideoDevices() -> Observable<[VideoDeviceDTO]> {
        return Observable.create { observer -> Disposable in
            var request = URLRequest(url: URL(string: Constants.videoDevicesURL)!)
            request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer.onError(error)
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    observer.onError(APIError.invalidResponse)
                    return
                }

                guard let data = data else {
                    observer.onError(APIError.noData)
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(VideoDeviceResponse.self, from: data)
                    observer.onNext(response.data)
                    observer.onCompleted()
                } catch {
                    observer.onError(APIError.decodingError)
                }
            }

            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}

enum APIError: Error {
    case invalidResponse
    case noData
    case decodingError
}

struct AlarmCentralResponse: Codable {
    let count: Int
    let data: [AlarmCentralDTO]
}

struct VideoDeviceResponse: Codable {
    let count: Int
    let data: [VideoDeviceDTO]
}
