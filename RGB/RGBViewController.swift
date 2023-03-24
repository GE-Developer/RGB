//
//  ViewController.swift
//  RGB
//
//  Created by M I C H A E L on 23.03.2023.
//

import UIKit

final class RGBViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var colorView: UIView!
    
    @IBOutlet private weak var redLabel: UILabel!
    @IBOutlet private weak var greenLabel: UILabel!
    @IBOutlet private weak var blueLabel: UILabel!
    
    @IBOutlet private weak var redSlider: UISlider!
    @IBOutlet private weak var greenSlider: UISlider!
    @IBOutlet private weak var blueSlider: UISlider!
    
    @IBOutlet private weak var hexLabel: UILabel!
    
    // MARK: - Private Propeties
    private var redValue: Float = 0.75
    private var greenValue: Float = 0.5
    private var blueValue: Float = 0.25
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setColorView()
        setupRGBLabels()
        setupRGBSliders()
        
        hexLabel.text = hexStringFromColor()
    }
    
    override func viewWillLayoutSubviews() {
        colorView.layer.cornerRadius = colorView.frame.height / 10
    }
    
    // MARK: - IBAction Methods
    @IBAction private func redSliderMoved() {
        redValue = redSlider.value
        redLabel.text = String(format: "%.2f", redValue)
    }
    
    @IBAction private func greenSliderMoved() {
        greenValue = greenSlider.value
        greenLabel.text = String(format: "%.2f", greenValue)
    }
    
    @IBAction private func blueSliderMoved() {
        blueValue = blueSlider.value
        blueLabel.text = String(format: "%.2f", blueValue)
    }
    
    @IBAction private func anySliderMoved() {
        setColorView()
        hexLabel.text = hexStringFromColor()
    }
    
    // MARK: - Private Methods
    private func setColorView() {
        colorView.backgroundColor = UIColor(red: CGFloat(redValue),
                                            green: CGFloat(greenValue),
                                            blue: CGFloat(blueValue),
                                            alpha: 1)
    }
    
    private func setupRGBLabels() {
        redLabel.text = String(format: "%.2f", redValue)
        greenLabel.text = String(format: "%.2f", greenValue)
        blueLabel.text = String(format: "%.2f", blueValue)
    }
    
    private func setupRGBSliders() {
        redSlider.value = redValue
        greenSlider.value = greenValue
        blueSlider.value = blueValue
    }
    
    private func hexStringFromColor() -> String {
        var hexString = ""
        
        if let color = colorView.backgroundColor {
            let components = color.cgColor.components
            let red: CGFloat = components?[0] ?? 0.0
            let green: CGFloat = components?[1] ?? 0.0
            let blue: CGFloat = components?[2] ?? 0.0
            
            hexString = String(format: "#%02lX%02lX%02lX",
                               lroundf(Float(red * 255)),
                               lroundf(Float(green * 255)),
                               lroundf(Float(blue * 255)))
        }
        return "Hex Color: \(hexString)"
     }
}
