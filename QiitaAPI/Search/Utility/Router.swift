//
//  Router.swift
//  QiitaAPI
//
//  Created by koala panda on 2023/05/05.
//

import UIKit

final class Router {
    static let shared: Router =  .init()
    private init() {}

    private var window: UIWindow?
    func showRoot(window: UIWindow?) {
        guard let vc = UIStoryboard.init(name: "SearchView", bundle: nil).instantiateInitialViewController() else {
            return
        }
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        self.window = window
    }

    func showWeb(from: UIViewController, qiitaModel: QiitaModel) {
        guard let web = UIStoryboard.init(name: "WebView", bundle: nil).instantiateInitialViewController() as? WebViewController else {
            return
        }
        web.configure(qiitaModel: qiitaModel)
        show(from: from, to: web)
    }
}
private func show(from: UIViewController, to: UIViewController, completion:(() -> Void)? = nil) {
    if let nav = from.navigationController {
        nav.pushViewController(to, animated: true)
        completion?()
    } else {
        from.present(to, animated: true, completion: completion)
    }


}
