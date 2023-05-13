//
//  Device.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 12/05/23.
//

import Foundation
import UIKit

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

protocol Device {
    var id: String { get }
    var name: String { get set }
    var serial: String? { get set }
    var macAddress: String? { get set }
    var username: String? { get set }
    var password: String { get set }
    var type: DeviceType { get set }
}
