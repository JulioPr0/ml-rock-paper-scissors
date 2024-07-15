import SwiftUI

struct GameView: View {
    @EnvironmentObject var appModel: AppModel

    var body: some View {
        RPSGameView(isMLGame: false)
            .environmentObject(appModel)
    }
}
