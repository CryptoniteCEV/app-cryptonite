

import UIKit

class UnderlinedTextField: UITextField {

    private let underline = CALayer()
        
        private func setupUnderline() {
        // Borramos los bordes que tienen los UITextField por defecto.
        borderStyle = .none
            
        // Borramos los horrorosos bordes que tienen los UITextField por defecto.
        let lineWidth: CGFloat = 1.0
        
        underline.borderColor = UIColor.lightGray.cgColor
        underline.frame = CGRect(
            x: 0,
            y: frame.size.height - lineWidth,
            width: frame.size.width,
            height: frame.size.height
        )
        underline.borderWidth = lineWidth
            
        //  Añadimos la línea a la pila de capas (layer stack)3
        layer.addSublayer(underline)
        layer.masksToBounds = true
    }

       override func setNeedsLayout() {
        super.setNeedsLayout()
        setupUnderline()
    }


}
