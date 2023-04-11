//
//  MainViewController.swift
//  RGB
//
//  Created by M I C H A E L on 11.04.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let rgbVC = segue.destination as? RGBViewController else { return }
        rgbVC.mainColor = view.backgroundColor
    }
}
