import SwiftUI

class GameScreenViewModel: ObservableObject {

    @Published var currentValue = 0.0
    @Published var targetValue = 0
    @Published var score = 0
    @Published var round = 0
    // Outputs
    var scoreText: String {
        return "Score: \(score)"
    }
    
    var roundText: String {
        return "Round: \(round)"
    }
    
    var targetText: String {
        return "Put the Bull's Eye as close as you can to: \(targetValue)"
    }
    
    var sliderValue: Float {
        return Float(currentValue)
    }
    
    var sliderTintAlpha: Float {
        let quickDiff = abs(targetValue - Int(currentValue))
        return Float(quickDiff) / 100.0
    }
    
    // Methods to modify game state
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
    }
    
    func updateSliderValue(_ value: Float) {
        currentValue = Double(value.rounded())
    }
    
    func calculateScore() -> (String, String, Int) {
        return calculatePoints()
    }
    func calculatePoints() -> (String, String, Int) {
        let difference = abs(targetValue - Int(currentValue))
        var points = 100 - difference

        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }

        let message = "You scored \(points) points"
        return (title, message, points)
    }

    func applyScore(points: Int) {
        self.score += points
    }
}
