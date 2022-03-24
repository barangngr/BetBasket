//
//  AnalyticsManager.swift
//  BetBasket
//
//  Created by Baran Gungor on 24.03.2022.
//

final class AnalyticsManager {
    
    // MARK: Properties
    static let shared = AnalyticsManager()
    private var providers: [AnalyticsProvider] = []
    
    // MARK: Functions
    func initialize(_ providers: [AnalyticsProvider]) {
        self.providers = providers
    }
    
    func track(event: AnalyticsEvent, param: AnalyticsParams = nil) {
        providers.forEach {
            if $0.canTrack(event: event) {
                $0.track(event: event, param: param)
            }
        }
    }
    
    func trackScreen(event: AnalyticsScreenEvent) {
        providers.forEach {
            if $0.canTrackScreen() {
                $0.trackScreen(event: event)
            }
        }
    }
    
}

// MARK: - AnalyticsProvider
protocol AnalyticsProvider {
    func canTrack(event: AnalyticsEvent) -> Bool
    func canTrackScreen() -> Bool
    func track(event: AnalyticsEvent, param: AnalyticsParams)
    func trackScreen(event: AnalyticsScreenEvent)
    func map(_ params: AnalyticsParams) -> [String: Any]?
}

extension AnalyticsProvider {
    func map(_ params: AnalyticsParams) -> [String: Any]? {
        guard let params = params else { return nil }
        var paramsDict: [String: Any] = [ : ]
        for key in params.keys {
            let keyId = key.value
            paramsDict[keyId] = params[key]
        }
        return paramsDict
    }
    
    func trackScreen(event: AnalyticsScreenEvent) {}
}
