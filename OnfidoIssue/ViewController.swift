//
//  ViewController.swift
//  OnfidoIssue
//
//  Created by Quentin Eude on 17/06/2022.
//

import UIKit
import Onfido

class ViewController: UIViewController {

  private var button: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    initUI()
    // Do any additional setup after loading the view.
  }

  private func initUI() {
    button.setTitle("Launch Onfido", for: .normal)
    button.addTarget(self, action: #selector(launchOnfidoFlow), for: .touchUpInside)
    button.setTitleColor(UIColor.systemBlue, for: .normal)
    self.view.addSubview(button)
    button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }

  @objc private func launchOnfidoFlow() {
    do {
      let appearance = Appearance()
      appearance.primaryColor = .purple
      appearance.primaryTitleColor = .white
      appearance.primaryBackgroundPressedColor = .systemIndigo
      appearance.secondaryBackgroundPressedColor = .lightGray
      appearance.buttonCornerRadius = 8
      appearance.supportDarkMode = false
      appearance.fontRegular = nil
      appearance.fontBold = nil

      let config = try OnfidoConfig.builder()
        .withSDKToken(<SDKTOKEN>)
        .withAppearance(appearance)
//        .withWelcomeStep()
        .withFaceStep(ofVariant: .photo(withConfiguration: nil))
        .build()

      let onfidoFlow = OnfidoFlow(withConfiguration: config).with(responseHandler: { response in
        switch response {
        case .error(let error):
          print(error)
        case .success(_):
          print("success")
        case .cancel:
          break
        @unknown default:
          debugPrint("⚠️ Unknown switch case in \(#function)")
        }
      })

      let vc = try onfidoFlow.run()
      present(vc, animated: true)
    } catch let error {
      print(error)
    }
  }


}

