import ActivityKit
import WidgetKit
import SwiftUI

struct InfiniLinkWidgetsAttributes: ActivityAttributes {
   public struct ContentState: Codable, Hashable {
       var icon: String
       var duration: TimeInterval
       var heartRate: Int?
       var steps: Int?
       var calories: Int?
   }

   var activityName: String
}

struct InfiniLinkWidgetsLiveActivity: Widget {
   var body: some WidgetConfiguration {
       ActivityConfiguration(for: InfiniLinkWidgetsAttributes.self) { context in
           VStack(spacing: 10) {
               HStack {
                   Image(systemName: context.state.icon)
                       .font(.largeTitle)
                   Text(context.attributes.activityName)
                       .font(.title2.bold())
                   Text(Duration.seconds(context.state.duration), format: .time(pattern: .minuteSecond))
                       .font(.title2.monospacedDigit())
                       .frame(maxWidth: .infinity, alignment: .trailing)
                       .contentTransition(.numericText())
               }
               HStack(spacing: 16) {
                   if let hr = context.state.heartRate {
                       Label("\(hr)", systemImage: "heart.fill")
                           .foregroundColor(.red)
                           .contentTransition(.numericText())
                   }
                   if let steps = context.state.steps {
                       Label("\(steps)", systemImage: "shoeprints.fill")
                           .foregroundColor(.blue)
                           .contentTransition(.numericText())
                   }
                   if let cal = context.state.calories {
                       Label("\(cal)", systemImage: "flame.fill")
                           .foregroundColor(.orange)
                           .contentTransition(.numericText())
                   }
                   Spacer()
               }
           }
           .padding()
           .activityBackgroundTint(Color.black)
           .activitySystemActionForegroundColor(Color.white)

       } dynamicIsland: { context in
           DynamicIsland {
               DynamicIslandExpandedRegion(.bottom) {
                   VStack(spacing: 10) {
                       HStack {
                           Image(systemName: context.state.icon)
                               .font(.largeTitle)
                           Text(context.attributes.activityName)
                               .font(.title2.bold())
                               .lineLimit(1)
                           Spacer()
                           Text(Duration.seconds(context.state.duration), format: .time(pattern: .minuteSecond))
                               .font(.title2.bold().monospacedDigit())
                               .contentTransition(.numericText())
                               .padding(.trailing, 16)
                       }
                       .padding(.top, 10)
                       HStack(spacing: 16) {
                           if let hr = context.state.heartRate {
                               Label("\(hr)", systemImage: "heart.fill")
                                   .foregroundColor(.red)
                                   .contentTransition(.numericText())
                           }
                           if let steps = context.state.steps {
                               Label("\(steps)", systemImage: "shoeprints.fill")
                                   .foregroundColor(.blue)
                                   .contentTransition(.numericText())
                           }
                           if let cal = context.state.calories {
                               Label("\(cal)", systemImage: "flame.fill")
                                   .foregroundColor(.orange)
                                   .contentTransition(.numericText())
                           }
                           Spacer()
                       }
                       .padding(.leading, 8)
                       .padding(.top, 10)
                   }
                   .padding(.top, -32)
                   .frame(height: 80)
               }
           } compactLeading: {
               Image(systemName: context.state.icon)
                   .padding(.leading, 4)
                   .foregroundColor(.orange)
           } compactTrailing: {
               Text(Duration.seconds(context.state.duration), format: .time(pattern: .minuteSecond))
                   .foregroundColor(.orange)
                   .monospacedDigit()
                   .padding(.trailing, 4)
                   .contentTransition(.numericText())
           } minimal: {
               Image(systemName: context.state.icon)
                   .foregroundColor(.orange)
           }
           .keylineTint(.orange)
       }
   }
}

extension InfiniLinkWidgetsAttributes {
   fileprivate static var preview: InfiniLinkWidgetsAttributes {
       InfiniLinkWidgetsAttributes(activityName: "Strength Training")
   }
}

extension InfiniLinkWidgetsAttributes.ContentState {
   fileprivate static var sample: InfiniLinkWidgetsAttributes.ContentState {
       InfiniLinkWidgetsAttributes.ContentState(
           icon: "figure.run",
           duration: 2438,
           heartRate: 143,
           steps: 1200,
           calories: 260
       )
   }
}

@available(iOS 17.0, *)
#Preview("Live Activity", as: .dynamicIsland(.compact), using: InfiniLinkWidgetsAttributes.preview) {
   InfiniLinkWidgetsLiveActivity()
} contentStates: {
   InfiniLinkWidgetsAttributes.ContentState.sample
}
