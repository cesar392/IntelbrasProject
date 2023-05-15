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
    func createVideoDevice(_ device: CreationVideoDeviceParameters) -> Completable
    func deleteVideoDevice(withID id: String) -> Completable
}

protocol IntelbrasAPIRequestHandler {
    func handleRequest<T: Codable>(observer: AnyObserver<T>, urlRequest: URLRequest) -> Disposable
    func handleRequest(observer: @escaping (CompletableEvent) -> Void, urlRequest: URLRequest) -> Disposable
}

extension IntelbrasAPIRequestHandler {
    func handleRequest<T: Codable>(observer: AnyObserver<T>,
                                   urlRequest: URLRequest) -> Disposable {
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Error in GET: missing connection")
                observer.onError(APIError.missingConnection)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error in GET: invalid response")
                observer.onError(APIError.invalidResponse)
                return
            }

            guard let data = data else {
                print("Error in GET: noData error")
                observer.onError(APIError.noData)
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(T.self, from: data)
                print("GET succeeded")
                observer.onNext(response)
                observer.onCompleted()
            } catch {
                print("Error in GET: decoding error")
                observer.onError(APIError.decodingError)
            }
        }

        task.resume()

        return Disposables.create {
            task.cancel()
        }
    }

    func handleRequest(observer: @escaping (CompletableEvent) -> Void,
                       urlRequest: URLRequest) -> Disposable {
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { _, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                if let error = error {
                    print("Error in GET: missing connection")
                    observer(.error(APIError.missingConnection))
                    return
                }

                if (200...299).contains(httpResponse.statusCode) {
                    observer(.completed)
                    print("POST succeeded")
                } else {
                    observer(.error(APIError.unknown))
                    print("Error in POST request: \(httpResponse.statusCode)")
                }
            }
        }
        task.resume()
        return Disposables.create {
            task.cancel()
        }
    }
}
