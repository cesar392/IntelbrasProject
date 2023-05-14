//
//  Device.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 12/05/23.
//

import Foundation
import UIKit

protocol Device {
    var id: String { get }
    var name: String { get }
    var image: UIImage? { get }
    var deviceType: DeviceType { get }
    var favorite: Bool { get }
}

enum DeviceType {
    case video
    case alarm

    var image: UIImage? {
        switch self {
        case .video:
            return R.image.icVideoDevice()
        case .alarm:
            return R.image.icAlarmDevice()
        }
    }
}
