
import UIKit


@IBDesignable class StepperRow: UIView {
  
  enum Default {
    static let minValue: Double = 1
    static let maxValue: Double = 10
  }
  
  typealias StepperRange = (Int, Int) // min, max
  private var view:UIView!
  
  var value: Int {
    get {
      Int(stepper.value)
    }
  }
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var valueLabel: UILabel!
  @IBOutlet weak var stepper: UIStepper!
  
  @IBInspectable var minValue: Double {
    get { return stepper.minimumValue }
    set {
      if newValue >= Default.minValue && newValue <= maxValue && newValue <= stepper.maximumValue {
        stepper.minimumValue = newValue
      }
      let value = Double(valueLabel.text ?? "0")!
      if value < stepper.minimumValue {
        valueLabel.text = "\(Int(stepper.minimumValue))"
      }
    }
  }
  @IBInspectable var maxValue: Double {
    get { return stepper.maximumValue }
    set {
      if newValue <= Default.maxValue && newValue >= minValue && newValue >= stepper.minimumValue {
        stepper.maximumValue = newValue
      }
      let value = Double(valueLabel.text ?? "0")!
      if value > stepper.maximumValue {
        valueLabel.text = "\(Int(stepper.maximumValue))"
      }
    }
  }
  @IBInspectable var titleString: String? {
    get { return titleLabel.text }
    set {
      titleLabel.text = newValue
    }
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    setup()
    
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    
  }
  
  func setup() {
    view = loadViewFromNib()
    view.frame = bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    addSubview(view)
  }
  
  func loadViewFromNib() -> UIView {
  
    let bundle = Bundle(for:type(of: self))
    let nib = UINib(nibName: String(describing: StepperRow.self), bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    
    return view

  }
  
  @IBAction func stepperValueChanged(_ sender: Any) {
    valueLabel.text = "\(Int(stepper.value))"
  }
  
}


