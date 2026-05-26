//
//  LiveActivityManager.swift
//  InfiniLink
//
//  Created by Titus Kendzorra on 26.05.26.
//

import ActivityKit
import Foundation

class LiveActivityManager {
    static let shared = LiveActivityManager()
    
    private var activity: Activity<InfiniLinkWidgetsAttributes>?
    
    func start(name: String, icon: String, hasSteps: Bool) {
        let attributes = InfiniLinkWidgetsAttributes(activityName: name)
        let state = InfiniLinkWidgetsAttributes.ContentState(
            icon: icon,
            duration: 0,
            heartRate: nil,
            steps: hasSteps ? 0 : nil,
            calories: hasSteps ? 0 : nil
        )
        
        do {
            activity = try Activity.request(
                attributes: attributes,
                content: .init(state: state, staleDate: nil)
            )
            print("Live Activity started: \(activity?.id ?? "nil")")
        } catch {
            print("Live Activity error: \(error.localizedDescription)")
        }
    }
    
    func update(duration: TimeInterval, heartRate: Int?, steps: Int?, calories: Int?, icon: String) {
        let state = InfiniLinkWidgetsAttributes.ContentState(
            icon: icon,
            duration: duration,
            heartRate: heartRate,
            steps: steps,
            calories: calories
        )
        Task {
            await activity?.update(.init(state: state, staleDate: nil))
        }
    }
    
    func stop() {
        Task {
            await activity?.end(nil, dismissalPolicy: .immediate)
            activity = nil
        }
    }
}
