//
//  AddLocation + Delegate.swift
//  FINAL Project
//
//  Created by Katherine on 10/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import UIKit

extension AddLocationVC : UITextViewDelegate {
    ///оповещает о том, что пользователь закончил вводить что-либо в текстовые поля
    func textViewDidChange(_ textView: UITextView) {
        viewModel.refreshLocation(addAdressText: addAdressTextView.text, addCityText:  addCityTextView.text, addIdText: addIdTextView.text, addPswText: addPswTextView.text)        
    }
    
    ///обновляет поле ввода
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.viewModel.refreshNilLocation(textView: textView)
    }
    
}
