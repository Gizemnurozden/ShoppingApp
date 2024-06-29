//
//  SceneDelegate.swift
//  ShoppingApp
//
//  Created by Gizemnur Özden on 11.05.2024.
//
import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var hesapSayfasiDelegate: HesapSayfasiDelegate?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // FirebaseApp.configure() // Firebase entegrasyonu için gerekiyorsa burada configure çağrısını yapabilirsiniz
        
        let window = UIWindow(windowScene: windowScene)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Kullanıcı oturum durumunu kontrol etmeden Tab Bar Controller'ı başlat
        let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
        window.rootViewController = mainTabBarController
        
        // Hesap Sayfası'na yönlendirme için delegate ataması yapın
        // Hesap Sayfası'na yönlendirme için delegate ataması yapın
        // Hesap Sayfası'na yönlendirme için delegate ataması yapın
        if let mainTabBarController = mainTabBarController as? UITabBarController {
            if let tabBarControllers = mainTabBarController.viewControllers {
                for viewController in tabBarControllers {
                    if let navigationController = viewController as? UINavigationController,
                       let topViewController = navigationController.topViewController as? HesapSayfasi {
                        topViewController.delegate = self
                    } else if let hesapSayfasi = viewController as? HesapSayfasi {
                        hesapSayfasi.delegate = self
                    }
                }
            }
        }

        
        self.window = window
        window.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

extension SceneDelegate: HesapSayfasiDelegate {
    func navigateToLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        loginViewController.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(loginViewController, animated: true, completion: nil)
    }
}

