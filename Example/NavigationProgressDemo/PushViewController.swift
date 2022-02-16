//
//  PushViewController.swift
//  NavigationProgressDemo
//
//  Created by Chris Ng on 12/2/2022.
//

import UIKit
import NavigationProgress

class PushViewController: UIViewController {
  
  @IBOutlet weak var oneTimeSwitchRow: UIStackView!
  @IBOutlet weak var oneTimeSwitch: UISwitch!
  @IBOutlet weak var startFromStepper: StepperRow!
  @IBOutlet weak var totalPagesStepper: StepperRow!
  @IBOutlet weak var presentModeSegmentControl: UISegmentedControl!
  
  var isOneTime: Bool = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "NavigationProgress Demo"
  }
  
  
  @IBAction func pushButtonDidPressed(_ sender: Any) {
    pushTableViewFromXib()
  }
  
  func pushNewNavVc() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "NavVC")
    navigationController?.present(vc, animated: true, completion: nil)
  }
  
  func pushTableViewFromXib() {
    let vc = TestTableViewController(nibName: "TestTableViewController", bundle: nil)
    let navVc = UINavigationController.init(rootViewController: vc)
    navVc.navigationBar.prefersLargeTitles = true
    if navigationController?.viewControllers.count == 1 {
      vc.isOneTime = oneTimeSwitch.isOn
      vc.startFromPage = startFromStepper.value
      vc.totalPages = totalPagesStepper.value
    }
    
    if presentModeSegmentControl.selectedSegmentIndex == 0 {
      navigationController?.pushViewController(vc, animated: true)
    } else if presentModeSegmentControl.selectedSegmentIndex == 2 {
      navVc.modalPresentationStyle = .overCurrentContext
      navigationController?.present(navVc, animated: true, completion: nil)
    } else {
      navigationController?.present(navVc, animated: true, completion: nil)
    }
  }
  
  
}
