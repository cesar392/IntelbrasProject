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

protocol IntelbrasAPIRequestHandler {
    func handleRequest<T: Codable>(observer: AnyObserver<T>, urlRequest: URLRequest) -> Disposable
}

extension IntelbrasAPIRequestHandler {
    func handleRequest<T: Codable>(observer: AnyObserver<T>,
                                   urlRequest: URLRequest) -> Disposable {
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                observer.onError(APIError.missingConnection)
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
                let response = try decoder.decode(T.self, from: data)
                observer.onNext(response)
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
