//
//  FirebaseAnalyticsProvider.swift
//  BetBasket
//
//  Created by Baran Gungor on 24.03.2022.
//

import FirebaseAnalytics

final class FirebaseAnalyticsProvider: AnalyticsProvider {
   
    // MARK: Functions
    func canTrackScreen() -> Bool {
        return true
    }
    
    func canTrack(event: AnalyticsEvent) -> Bool {
        // etcEvent is example, just for showing canTrack method usage.
        switch event {
        case .etcEvent:
            return false
        default:
            return true
        }
    }
    
    func track(event: AnalyticsEvent, param: AnalyticsParams) {
        Analytics.logEvent(event.value, parameters: map(param))
        print("🚀FirebaseEvent: \(event.value) \(map(param) ?? [:])")
    }

    func trackScreen(event: AnalyticsScreenEvent) {
        Analytics.logEvent(AnalyticsEventScreenView, parameters: [AnalyticsParameterScreenName: event.rawValue])
        print("🚀FirebaseScreenEvent: \(event.rawValue)")
    }
    
}
