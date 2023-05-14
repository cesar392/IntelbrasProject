//
//  DeviceService.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 13/05/23.
//

import Foundation
import RxSwift

class DeviceService {
    private let favoritesRepository: FavoritesRepositoryProtocol
    private let alarmCentralRepository: AlarmCentralRepositoryProtocol
    private let videoDeviceRepository: VideoDeviceRepositoryProtocol

    init(alarmCentralRepository: AlarmCentralRepositoryProtocol,
         videoDeviceRepository: VideoDeviceRepositoryProtocol,
         favoritesRepository: FavoritesRepositoryProtocol) {
        self.alarmCentralRepository = alarmCentralRepository
        self.videoDeviceRepository = videoDeviceRepository
        self.favoritesRepository = favoritesRepository
    }

    func fetchAlarmCentral() -> Observable<[AlarmCentral]> {
        let alarmCentralsDTO = alarmCentralRepository.fetchAlarmCentral()
        return Observable.combineLatest(alarmCentralsDTO, favoritesRepository.favorites)
            .map({ dtoList, favorites in
                // This could be extracted to a mapper class/extension if needed
                dtoList.map({ dto in
                    let isFavorite = favorites.contains(dto.id)
                    return AlarmCentral(
                        id: dto.id,
                        name: dto.name,
                        macAddress: dto.macAddress,
                        password: dto.password,
                        favorite: isFavorite
                    )
                })
            })
    }

    func fetchVideoDevices() -> Observable<[VideoDevice]> {
        let videoDevicesDTO = videoDeviceRepository.fetchVideoDevices()
        return Observable.combineLatest(videoDevicesDTO, favoritesRepository.favorites)
            .map({ dtoList, favorites in
                // This could be extracted to a mapper class/extension if needed
                dtoList.map({ dto in
                    let isFavorite = favorites.contains(dto.id)
                    return VideoDevice(
                        id: dto.id,
                        name: dto.name,
                        serial: dto.serial,
                        username: dto.username,
                        password: dto.password,
                        favorite: isFavorite
                    )
                })
            })
    }
}
