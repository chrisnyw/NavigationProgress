//
//  UIViewController+NavigationProgress.swift
//  NavigationProgress-iOS
//
//  Created by Chris Ng on 12/02/2022.
//  Copyright © 2022 NavigationProgress. All rights reserved.
//


import UIKit

extension UIViewController {
  
  private var progressBarView: ProgressBarView? {
    return navigationController?.view.subviews.first(where: {$0.isKind(of: ProgressBarView.self)}) as? ProgressBarView
  }
  private var currentNavigationPage: Int? {
    return navigationController?.viewControllers.count
  }
  public var npCurrentProgress: Float? {
    return progressBarView?.progress
  }
  
  @objc private func np_viewDidLayoutSubviews() {
    guard progressBarView != nil else { return }
    updateProgressBarViewFrame()
  }
  
  @objc private func np_viewDidAppear(_ animated: Bool) {
    guard let progressBarView = progressBarView, let currentPage = currentNavigationPage else { return }
    progressBarView.updateProgress(currentPage)
  }
  
  // public function
  /**
   Ensure your `UIViewController` is under `UINavigationController`, and calls `startNavigationProgress(with:)` in your current `viewController` class.
   Once your call `startNavigationProgress()`, it treats your current page is first page and NavigationProgress will be shown. Meanwhile, when your back to your previous page, NavigationProgress will be remove from your navigationController.
   
   - Parameter navigationProgress: NavigationProgress object passes to init progressBar
   */
  public func startNavigationProgress(with navigationProgress: NavigationProgress) {
    if progressBarView != nil {
      print("NavigationProgress: progressBarView exist, remove previous one")
      removeNavigationProgress()
    }
    guard let currentPage = currentNavigationPage else {
      print("NavigationProgress: startNavigationProgress is called, but no navigationController found")
      return
    }
    
    let progressBarView = ProgressBarView(basePageNumber: currentPage,
                                          navigationProgress: navigationProgress) { progressBarView in
      progressBarView.removeFromSuperview()
    }
    navigationController?.view.addSubview(progressBarView)
  }
  
  /**
    Force remove the existing NavigationProgress from your navigationController
   */
  public func removeNavigationProgress() {
    progressBarView?.removeFromSuperview()
  }
  
  // private method
  
  private func updateProgressBarViewFrame() {
    guard var frame = navigationController?.view.frame else { return }
    if #available(iOS 11.0, *) {
      frame.origin.y = navigationController!.view.safeAreaInsets.top
    } else {
      frame.origin.y = 20
    }
    progressBarView?.frame = frame
  }
  
}

// swizzle helper
extension UIViewController {
  static func swizzle() {
    swizzleHelper(original: #selector(viewDidLayoutSubviews), swizzled: #selector(np_viewDidLayoutSubviews))
    swizzleHelper(original: #selector(viewDidAppear(_:)), swizzled: #selector(np_viewDidAppear(_:)))
  }
  
  private static func swizzleHelper(original: Selector, swizzled: Selector) {
    let originalMethod = class_getInstanceMethod(self, original)
    let swizzledMethod = class_getInstanceMethod(self, swizzled)
    if let originalMethod = originalMethod, let swizzledMethod = swizzledMethod {
      method_exchangeImplementations(originalMethod, swizzledMethod)
    }
  }
}
