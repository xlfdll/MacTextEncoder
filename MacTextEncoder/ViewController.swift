//
//  ViewController.swift
//  MacTextEncoder
//
//  Created by Xlfdll on 2020/06/18.
//  Copyright © 2020 Xlfdll Workstation. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSComboBoxDelegate, NSTextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        TargetEncodingComboBox.dataSource = self.dataSource
        TargetEncodingComboBox.selectItem(at: self.dataSource.Encodings.firstIndex(of: String.Encoding.utf8.rawValue) ?? 0)
        TargetEncodingComboBox.delegate = self
        SourceTextField.delegate = self
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    func comboBoxSelectionDidChange(_ notification: Notification) {
        performTextConversion()
    }

    func controlTextDidEndEditing(_ obj: Notification) {
        performTextConversion()
    }

    private func performTextConversion() {
        // Get unconverted bytes using Swift's internal encoding (currently UTF-8)
        // (Can print individual bytes using indexer)
        // Refer to https://swift.org/blog/utf8-string/
        let sourceTextData = SourceTextField.stringValue.data(using: .utf8)!
        let targetEncoding = String.Encoding(rawValue: self.dataSource.Encodings[TargetEncodingComboBox.indexOfSelectedItem])

        ResultTextField.stringValue = String(data: sourceTextData, encoding: targetEncoding) ?? ""
    }

    let dataSource = EncodingListDataSource(encodingListPointer: NSString.availableStringEncodings)

    @IBOutlet weak var SourceTextField: NSTextField!
    @IBOutlet weak var TargetEncodingComboBox: NSComboBox!
    @IBOutlet weak var ResultTextField: NSTextField!
}

