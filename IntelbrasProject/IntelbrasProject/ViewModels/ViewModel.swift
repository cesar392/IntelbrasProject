//
//  ViewModel.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 13/05/23.
//

import Foundation
import RxSwift

class ViewModel {

    // MARK: - Variables
    var alarmDisposable: Disposable?
    var videoDisposable: Disposable?
    private let networkFetcher = NetworkFetcher(alarmCentralService: AlarmCentralService(),
                                                videoDeviceService: VideoDeviceService())

    lazy var devicesList: [Device] = {
        var deviceList = [Device]()
//        deviceList.append(contentsOf: AlarmCentral.getMockAlarmCentrals())
//        deviceList.append(contentsOf: VideoDevice.getMockVideoDevices())
        return deviceList
    }()

    // MARK: - Fetch

    internal func fetchAlarmCentral(onCompleted: @escaping () -> Void) {
        alarmDisposable = networkFetcher.fetchAlarmCentral(withToken: Constants.API_TOKEN)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] devices in
                self?.devicesList.append(contentsOf: devices)
            },
                       onError: { [weak self] error in
                //                TODO Handle errors
            }, onCompleted: onCompleted)
    }

    internal func fetchVideoDevice(onCompleted: @escaping () -> Void) {
        videoDisposable = networkFetcher.fetchVideoDevices(withToken: Constants.API_TOKEN)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] devices in
                self?.devicesList.append(contentsOf: devices)
            },
                       onError: { [weak self] error in
                //                TODO Handle errors
            }, onCompleted: onCompleted)
    }
}
