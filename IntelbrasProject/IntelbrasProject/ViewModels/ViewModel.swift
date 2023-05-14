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

    private var devicesList = [BaseDevice]()
    lazy var filteredDevices = [BaseDevice]()

    // MARK: - Fetch
    internal func fetchAlarmCentral() {
        alarmDisposable = networkFetcher.fetchAlarmCentral(withToken: Constants.API_TOKEN)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] devices in
                guard let self = self else { return }
                self.devicesList.append(contentsOf: devices)
                self.filteredDevices = self.devicesList
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
                guard let self = self else { return }
                self.devicesList.append(contentsOf: devices)
                self.filteredDevices = self.devicesList
            }, onError: { [weak self] error in
                //                TODO Handle errors
            }, onCompleted: { [weak self] in
                self?.viewDelegate?.reloadTableView()
            })
    }

    // MARK: - Fetch
    internal func removeFilters() {
        self.filteredDevices = devicesList
        viewDelegate?.reloadTableView()
    }

    internal func filterFavorites() {
    }

    internal func filterVideoDevices() {
        self.filteredDevices = devicesList.filter({ device in
            device is VideoDevice
        })
        viewDelegate?.reloadTableView()
    }

    internal func filterAlarmCentrals() {
        self.filteredDevices = devicesList.filter({ device in
            device is AlarmCentral
        })
        viewDelegate?.reloadTableView()
    }
}
