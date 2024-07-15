import SwiftUI

@main
struct RPSApp: App {
    @StateObject var appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            /*#-code-walkthrough(mlgameview.replace)*/
            GameView()
                .environmentObject(appModel)
            /*#-code-walkthrough(mlgameview.replace)*/
            //#-learning-code-snippet(mlgameview.replace)
        }
    }
}

