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
    private var alarmDisposable: Disposable?
    private var videoDisposable: Disposable?
    weak var viewDelegate: ViewDelegate?
    private let networkFetcher = NetworkFetcher(alarmCentralService: AlarmCentralService(),
                                                videoDeviceService: VideoDeviceService())

    lazy var devicesList: [BaseDevice] = {
        var deviceList = [BaseDevice]()
        return deviceList
    }()

    // MARK: - Fetch
    internal func fetchAlarmCentral() {
        alarmDisposable = networkFetcher.fetchAlarmCentral(withToken: Constants.API_TOKEN)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] devices in
                self?.devicesList.append(contentsOf: devices)
            }, onError: { [weak self] error in
                //                TODO Handle errors
            }, onCompleted: { [weak self] in
                self?.viewDelegate?.reloadTableView()
            })
    }

    internal func fetchVideoDevice() {
        videoDisposable = networkFetcher.fetchVideoDevices(withToken: Constants.API_TOKEN)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] devices in
                self?.devicesList.append(contentsOf: devices)
            }, onError: { [weak self] error in
                //                TODO Handle errors
            }, onCompleted: { [weak self] in
                self?.viewDelegate?.reloadTableView()
            })
    }
}
