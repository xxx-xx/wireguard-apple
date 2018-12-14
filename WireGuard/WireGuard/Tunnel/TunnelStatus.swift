// SPDX-License-Identifier: MIT
// Copyright © 2018 WireGuard LLC. All Rights Reserved.

import Foundation
import NetworkExtension

@objc enum TunnelStatus: Int {
    case inactive
    case activating
    case active
    case deactivating
    case reasserting // Not a possible state at present
    case restarting // Restarting tunnel (done after saving modifications to an active tunnel)
    case waiting    // Waiting for another tunnel to be brought down
    
    init(from systemStatus: NEVPNStatus) {
        switch systemStatus {
        case .connected:
            self = .active
        case .connecting:
            self = .activating
        case .disconnected:
            self = .inactive
        case .disconnecting:
            self = .deactivating
        case .reasserting:
            self = .reasserting
        case .invalid:
            self = .inactive
        }
    }
}

extension TunnelStatus: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .inactive: return "inactive"
        case .activating: return "activating"
        case .active: return "active"
        case .deactivating: return "deactivating"
        case .reasserting: return "reasserting"
        case .restarting: return "restarting"
        case .waiting: return "waiting"
        }
    }
}
