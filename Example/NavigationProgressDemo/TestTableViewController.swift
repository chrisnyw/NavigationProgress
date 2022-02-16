//
//  TestTableViewController.swift
//  NavigationProgressDemo
//
//  Created by Chris Ng on 13/2/2022.
//

import UIKit
import NavigationProgress

class TestTableViewController: UITableViewController {
  
  let cellReuseIdentifier = "cell"
  var isOneTime: Bool = true
  var startFromPage: Int = 1
  var totalPages: Int = 1
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    title = "TableVC: \(navigationController?.viewControllers.count ?? 0)"
    if navigationController?.viewControllers.count == startFromPage {
      startNavigationProgress(with: NavigationProgress(totalPages: UInt(totalPages), progressType: isOneTime ? .oneTime : .always))
    }
    
    if isModal {
      let doneButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
      navigationItem.rightBarButtonItem = doneButton
    }
    
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
    cell.textLabel?.text = "index: \(indexPath.row + 1)"
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    pushTableViewFromXib()
  }
  
  private func pushTableViewFromXib() {
    let vc = TestTableViewController(nibName: "TestTableViewController", bundle: nil)
    navigationController?.pushViewController(vc, animated: true)
    vc.isOneTime = isOneTime
    vc.startFromPage = startFromPage
    vc.totalPages = totalPages
  }
  
  @objc private func doneAction() {
    dismiss(animated: true, completion: nil)
  }
  
  // helper to check if current VC is presented in modal view
  private var isModal: Bool {
    return self.presentingViewController?.presentedViewController == self
      || (self.navigationController != nil && self.navigationController?.presentingViewController?.presentedViewController == self.navigationController)
      || self.tabBarController?.presentingViewController is UITabBarController
  }
  
}
