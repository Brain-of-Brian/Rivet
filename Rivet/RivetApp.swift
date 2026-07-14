import SwiftUI

@main
struct RivetApp: App {
    var body: some Scene {
        WindowGroup {
            // phone stays as-is; bigger screens (iPad) scale that same layout up
            PhoneScaledRoot {
                ContentView()
            }
        }
    }
}
