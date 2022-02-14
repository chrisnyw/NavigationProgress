//
//  NavigationProgress.swift
//  NavigationProgress-iOS
//
//  Created by Chris Ng on 12/02/2022.
//  Copyright © 2022 NavigationProgress. All rights reserved.
//

import Foundation
import UIKit

public struct NavigationProgress {
  
  fileprivate struct Default {
    static let progressTintColor: UIColor = .orange
    static let trackTintColor: UIColor = .gray
    static let animationDuration: Double = 0.3
  }
  
  public enum ProgressType {
    case oneTime
    case always
  }
  
  public var totalPages: UInt
  public var progressType: ProgressType
  public var progressTintColor: UIColor
  public var trackTintColor: UIColor
  public var animationDuration: Double
  
  @discardableResult
  public init(totalPages: UInt, progressType: ProgressType = .oneTime, progressTintColor: UIColor? = nil, trackTintColor: UIColor? = nil, animationDuration: Double? = nil) {
    guard totalPages > 0 else {
      fatalError("NavigationProgress: totalPages must > 0")
    }
    self.totalPages = totalPages
    self.progressType = progressType
    self.progressTintColor = progressTintColor ?? Default.progressTintColor
    self.trackTintColor = trackTintColor ?? Default.trackTintColor
    self.animationDuration = animationDuration ?? Default.animationDuration
  }
  
  // initialize swizzle helper functions
  public static func setup() {
    UIViewController.swizzle()
  }
  
}

