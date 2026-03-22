import Foundation
import ShimmerKit

struct DemoProduct: Identifiable, Hashable {
    let id: UUID
    let title: String
    let subtitle: String
    let price: String
}

enum ProfileSelection: String, CaseIterable, Identifiable {
    case custom
    case defaultProfile
    case subtle
    case feedLoading
    case detailPage

    var id: String { rawValue }

    var title: String {
        switch self {
        case .custom: return "Custom"
        case .defaultProfile: return ".default"
        case .subtle: return ".subtle"
        case .feedLoading: return ".feedLoading"
        case .detailPage: return ".detailPage"
        }
    }

    var shimmerProfile: ShimmerProfile? {
        switch self {
        case .custom:
            return nil
        case .defaultProfile:
            return .default
        case .subtle:
            return .subtle
        case .feedLoading:
            return .feedLoading
        case .detailPage:
            return .detailPage
        }
    }
}
