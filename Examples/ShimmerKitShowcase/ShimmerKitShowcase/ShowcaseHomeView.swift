import SwiftUI
import ShimmerKit

struct ShowcaseHomeView: View {
    var body: some View {
        List {
            Section("Playground Controls") {
                NavigationLink("Global Controls") {
                    ControlPanelView()
                }
            }

            Section("API Demonstrations") {
                NavigationLink("1. Basic smartSkeleton") {
                    DemoBasicView()
                }
                NavigationLink("2. kind + shape + cornerRadius") {
                    DemoKindsAndShapesView()
                }
                NavigationLink("3. Partial scopes") {
                    DemoScopedPartialView()
                }
                NavigationLink("4. List identity with skeletonID") {
                    DemoListIdentityView()
                }
                NavigationLink("5. Advanced toggles") {
                    DemoAdvancedView()
                }
                NavigationLink("6. Preset profiles + config constructors") {
                    DemoProfilesView()
                }
                NavigationLink("7. Apple .redacted vs ShimmerKit") {
                    DemoRedactedComparisonView()
                }
                NavigationLink("8. Text gradient") {
                    DemoTextGradientView()
                }
            }
        }
        .navigationTitle("ShimmerKit Showcase")
    }
}
