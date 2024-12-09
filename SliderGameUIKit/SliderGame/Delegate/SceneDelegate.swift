import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let sceneWindow = (scene as? UIWindowScene) else { fatalError("scene can't be converted into window scene") }
        let window = UIWindow(windowScene: sceneWindow)
        window.rootViewController = SliderGameScreenViewController()
        self.window = window
        window.makeKeyAndVisible()
    }

}

