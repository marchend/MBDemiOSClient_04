import SwiftUI

/// Bootstrap placeholder. Replaced by the MVVM + Coordinator root view in a future PR.
struct ContentView: View {
    var body: some View {
        Text("AcmeBank")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundStyle(.primary)
    }
}

#Preview {
    ContentView()
}
