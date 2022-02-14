//
//  ProgressBarView.swift
//  NavigationProgress-iOS
//
//  Created by Chris Ng on 12/02/2022.
//  Copyright © 2022 NavigationProgress. All rights reserved.
//

import UIKit

@IBDesignable
class ProgressBarView: UIProgressView {
  
  typealias AllPagesCompleted = (ProgressBarView) -> Void
  let accessibilityIdentifierKey = "np_ProgressBarView"
  
  private var basePageNumber: Int?
  private var completion: AllPagesCompleted?
  private var navigationProgress: NavigationProgress?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configure()
  }
  
  convenience init(basePageNumber: Int, navigationProgress: NavigationProgress, completion: AllPagesCompleted? = nil) {
    self.init()
    self.basePageNumber = basePageNumber - 1
    self.navigationProgress = navigationProgress
    self.completion = completion
    configure()
  }
  
  func updateProgress(_ currentPage: Int) {
    guard let np = navigationProgress,
            let basePage = basePageNumber else {
      fatalError("haven't set the basePageNumber or progressBarTotalPages yet")
    }
    
    let current = currentPage - basePage
    let show = current > 0 && current <= np.totalPages
    
    UIView.animate(withDuration: np.animationDuration, animations: { [weak self] in
      self?.alpha = (show) ? 1 : 0
    }, completion: { [weak self] _ in
      self?.removeViewIfNeeded(current)
    })
    
    setProgress(Float(current) / Float(np.totalPages), animated: true)
  }
  
  // MARK: - Layout
  
  /// Invoked when the interface builder renders the control
  override open func prepareForInterfaceBuilder() {
    if #available(iOS 8.0, *) {
      super.prepareForInterfaceBuilder()
    }
    configure()
  }
  
  // MARK: - Internal methods
  
  private func configure() {
    progressTintColor = navigationProgress?.progressTintColor
    trackTintColor = navigationProgress?.trackTintColor
    accessibilityIdentifier = accessibilityIdentifierKey
  }
  
  private func removeViewIfNeeded(_ currentPage: Int) {
    guard let np = navigationProgress,
          ((currentPage > np.totalPages && np.progressType == .oneTime) || currentPage <= 0) else { return }
    completion?(self)
  }
}
