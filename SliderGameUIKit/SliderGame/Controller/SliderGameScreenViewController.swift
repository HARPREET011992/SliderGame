import UIKit

class SliderGameScreenViewController: BaseViewController {
    
    private var viewModel = GameScreenViewModel()
    
    private lazy var scoreLabel = UILabel(text: "Score: 0", lines: 0, alignment: .center, textColor: .secondaryLabel, font: .systemFont(ofSize: 30, weight: .medium))
    
    private lazy var roundLabel = UILabel(text: "Round: 0", lines: 0, alignment: .center, textColor: .secondaryLabel, font: .systemFont(ofSize: 30, weight: .medium))
    
    private lazy var resultLabel = UILabel(text: "Put the Bull's Eye as close as you can to: ", lines: 0, alignment: .center, textColor: .secondaryLabel, font: .systemFont(ofSize: 30, weight: .medium))
    
    private lazy var hitButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Hit Me!", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private let bottomInputView: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemGroupedBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start Over", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private lazy var slider : UISlider = {
        let slider = UISlider(frame:CGRectMake(70, 550, 280, 20))
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.isContinuous = true
        slider.isUserInteractionEnabled = true
        slider.addTarget(self, action: #selector(sliderMoved), for: .valueChanged)
        return slider
    }()
    
    private lazy var bottomView = {
        var stackView = UIStackView(arrangedSubviews: [startButton, scoreLabel, roundLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        InitalSetup()
        
        startButtonClicked()
        
    }
    
    private func bindViewModel() {
          // Update UI elements with ViewModel data
          resultLabel.text = viewModel.targetText
          scoreLabel.text = viewModel.scoreText
          roundLabel.text = viewModel.roundText
          slider.value = viewModel.sliderValue
          slider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(viewModel.sliderTintAlpha))
      }
    
    private func InitalSetup() {
        view.backgroundColor = .tertiarySystemGroupedBackground
        
        view.addSubviews(resultLabel, slider, hitButton, bottomView)
        
        resultLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        resultLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // Slider
        slider.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 40).isActive = true
        slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
        slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Hit Me Button
        hitButton.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 30).isActive = true
        hitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        hitButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        hitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // Bottom View
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        bottomView.topAnchor.constraint(equalTo: hitButton.bottomAnchor, constant: 50).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    // MARK: - Start New Round Method
    func startNewRound() {
        viewModel.startNewRound()
        bindViewModel()
    }
    // MARK: - Show Alert Method
    @objc private func showAlert() {
            let (title, message) = viewModel.calculateScore()
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                self.startNewRound()
            })
            present(alert, animated: true, completion: nil)
        }

    
    // MARK: - Button Method
    @objc private func startButtonClicked() {
        viewModel.startNewGame()
        bindViewModel()
    }
    // MARK: - Slider Method
    @objc func sliderMoved(_ slider: UISlider) {
        viewModel.updateSliderValue(slider.value)
        bindViewModel()
    }
    
}

