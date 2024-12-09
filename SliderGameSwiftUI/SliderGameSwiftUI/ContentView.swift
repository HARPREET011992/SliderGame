import SwiftUI

struct ContentView: View {
    @StateObject private var model = GameScreenViewModel()
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            Text(model.targetText)
                .font(.system(size: 30))
                .fontWeight(.medium)
                .padding()
            
            Slider(value: $model.currentValue, in: 0...100)
            Spacer()
            Button("Hit Me!") {
                let (_, _, points) = model.calculatePoints()
                model.applyScore(points: points) // Update score only once
                showingAlert = true
            }
            .alert(isPresented: $showingAlert) {
                let (message, title, _) = model.calculatePoints() // Reuse title and message for alert
                return Alert(
                    title: Text(title),
                    message: Text(message),
                    dismissButton: .default(Text("OK"), action: {
                        model.startNewRound()
                    }))
            }
            .padding()
            
            HStack {
                Button("Start Over"){
                    model.startNewGame()
                }
                Spacer()
                Text(model.scoreText)
                Spacer()
                Text(model.roundText)
            }
            .padding()
        }.onAppear {
            model.startNewGame()
        }
    }
}

#Preview {
    ContentView()
}
