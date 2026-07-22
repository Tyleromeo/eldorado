import SwiftUI
import UIKit

@main
struct PalmaresApp: App {
    // The Info.plist already declares portrait-only (INFOPLIST_KEY_UISupported
    // InterfaceOrientations). This AppDelegate is belt-and-suspenders: iOS asks
    // the app delegate for supported orientations at runtime and always honors
    // the answer, so this locks portrait even in the cases where the plist alone
    // isn't respected. Both must agree; both say portrait.
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
}
