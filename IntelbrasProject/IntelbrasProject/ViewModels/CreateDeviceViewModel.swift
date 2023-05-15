//
//  CreateDeviceViewModel.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 14/05/23.
//

import Foundation
import RxSwift

class CreateDeviceViewModel {

    // MARK: - Variables
    private let disposeBag = DisposeBag()
    private let deviceService: DeviceService
    private let _onSaveSucceeded = PublishSubject<Void>()
    lazy var onSaveSucceeded = _onSaveSucceeded.asObservable()

    // MARK: - Lifecycle
    init(deviceService: DeviceService) {
        self.deviceService = deviceService
    }

    // MARK: - POST methods
    internal func onSaveButtonSelected(name: String, serial: String, username: String, password: String) {
        let device = CreationVideoDeviceParameters(name: name,
                                                   serial: serial,
                                                   username: username,
                                                   password: password)
        deviceService.createVideoDeviceObject(device)
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onCompleted: {
                self._onSaveSucceeded.onCompleted()
            }).disposed(by: disposeBag)
    }
}
