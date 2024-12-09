import Foundation

struct GameScreenViewModel {
    private var game: BullsEyeGame = BullsEyeGame()
    
    // Outputs
    var scoreText: String {
        return "Score: \(game.score)"
    }
    
    var roundText: String {
        return "Round: \(game.round)"
    }
    
    var targetText: String {
        return "Put the Bull's Eye as close as you can to: \(game.targetValue)"
    }
    
    var sliderValue: Float {
        return Float(game.currentValue)
    }
    
    var sliderTintAlpha: Float {
        let quickDiff = abs(game.targetValue - game.currentValue)
        return Float(quickDiff) / 100.0
    }
    
    // Methods to modify game state
    mutating func startNewGame() {
        game.score = 0
        game.round = 0
        startNewRound()
    }
    
    mutating func startNewRound() {
        game.round += 1
        game.targetValue = Int.random(in: 1...100)
        game.currentValue = 50
    }
    
    mutating func updateSliderValue(_ value: Float) {
        game.currentValue = Int(value.rounded())
    }
    
    mutating func calculateScore() -> (String, String) {
        return calculatePoints()
    }
    
    mutating func calculatePoints() -> (String, String) {
        let difference = abs(game.targetValue - game.currentValue)
        var points = 100 - difference
        
        game.score += points
    
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
        
        return (title, message)
    }
}
