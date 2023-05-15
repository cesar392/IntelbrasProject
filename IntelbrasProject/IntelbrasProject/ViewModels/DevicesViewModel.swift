//
//  ViewModel.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 13/05/23.
//

import Foundation
import RxSwift

class DevicesViewModel {

    // MARK: - Variables
    private let disposeBag = DisposeBag()

    private let deviceService: DeviceService
    private let favoriteService: FavoritesServiceProtocol

    private let _filter = BehaviorSubject<DeviceFilter>(value: .all)
    lazy var filter = _filter.asObservable()

    private let alarmCentrals = BehaviorSubject(value: [AlarmCentral]())
    private let videoDevices = BehaviorSubject(value: [VideoDevice]())

    private lazy var allDevices = Observable.combineLatest(alarmCentrals, videoDevices)
        .map{ alarmList, videoList in
            let devicesList: [Device] = alarmList + videoList
            return devicesList
    }

    lazy var filteredDevices = Observable.combineLatest(allDevices, filter)
        .map{ devices, filter in
            return devices.filter({ device in
                switch filter {
                case .all:
                    return true
                case .alarmCentrals:
                    return device is AlarmCentral
                case .videoDevices:
                    return device is VideoDevice
                case .favorites:
                    return device.favorite
                }
            })
    }

    init(deviceService: DeviceService, favoriteService: FavoritesServiceProtocol) {
        self.deviceService = deviceService
        self.favoriteService = favoriteService
    }

    // MARK: - Fetch
    internal func loadInitialData() {
        fetchAlarmCentral()
        fetchVideoDevice()
    }

    private func fetchAlarmCentral() {
        deviceService.fetchAlarmCentral()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] devices in
                guard let self = self else { return }
                alarmCentrals.onNext(devices)
            }, onError: { error in
                //                TODO Handle errors
            }).disposed(by: disposeBag)
    }

    private func fetchVideoDevice() {
        deviceService.fetchVideoDevices()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] devices in
                guard let self = self else { return }
                videoDevices.onNext(devices)
            }, onError: { error in
                //                TODO Handle errors
            }).disposed(by: disposeBag)
    }

    // MARK: - Filter
    internal func onDashboardSelected() {
        self._filter.onNext(.all)
    }

    internal func onFavoritesSelected() {
        self._filter.onNext(.favorites)
    }

    internal func onVideoDevicesSelected() {
        self._filter.onNext(.videoDevices)
    }

    internal func onAlarmCentralsSelected() {
        self._filter.onNext(.alarmCentrals)
    }

    internal func toggleFavorite(device: Device) {
        if device.favorite {
            favoriteService.removeFavorite(id: device.id)
        } else {
            favoriteService.addFavorite(id: device.id)
        }
    }
}

enum DeviceFilter {
    case all
    case favorites
    case videoDevices
    case alarmCentrals
}

