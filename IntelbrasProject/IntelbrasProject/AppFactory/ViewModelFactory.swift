//
//  ViewModelFactory.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 15/05/23.
//

import Foundation

class ViewModelFactory {
    private static let alarmCentralRepository = AlarmCentralRepository(token: Constants.API_TOKEN)
    private static let videoDeviceRepository = VideoDeviceRepository(token: Constants.API_TOKEN)
    private static var favoriteService = FavoritesService(favoriteRepo: favoritesRepository)
    private static var favoritesRepository = InMemoryFavoriteRepository()

    private static func getDeviceService() -> DeviceService {
        return DeviceService(alarmCentralRepository: alarmCentralRepository,
                             videoDeviceRepository: videoDeviceRepository,
                             favoritesRepository: favoritesRepository)
    }

    private static func getFavoriteService() -> FavoritesService {
        return favoriteService
    }

    static func getDevicesViewModel() -> DevicesViewModel {
        return DevicesViewModel(deviceService: getDeviceService(),
                                favoriteService: getFavoriteService())
    }

    static func getCreateDevicesViewModel() -> CreateDeviceViewModel {
        return CreateDeviceViewModel(deviceService: getDeviceService())
    }

}
