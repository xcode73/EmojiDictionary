//
//  AddEditEmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Nikolai Eremenko on 12/5/22.
//

import UIKit

class AddEditEmojiTableViewController: UITableViewController {

    @IBOutlet var symbolTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var usageTextField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let emoji = emoji {
            symbolTextField.text = emoji.symbol
            nameTextField.text = emoji.name
            descriptionTextField.text = emoji.description
            usageTextField.text = emoji.usage
            title = "Edit Emoji"
        } else {
            title = "Add Emoji"
        }
        
        updateSaveButtonState()

    }

    // MARK: - Table view data source
    
    var emoji: Emoji?
    
    init(coder: NSCoder, emoji: Emoji?) {
        self.emoji = emoji
        super.init(coder: coder)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //Check that all textfields is not emty and enable save button
    func updateSaveButtonState() {
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        let usageText = usageTextField.text ?? ""
        saveButton.isEnabled = containsSingleEmoji(symbolTextField) && !nameText.isEmpty && !descriptionText.isEmpty && !usageText.isEmpty
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    // Validate that textfield contains one emoji
    func containsSingleEmoji(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text.count == 1 else {
            return false
        }
        let isCombinedIntoEmoji = text.unicodeScalars.count > 1 && text.unicodeScalars.first?.properties.isEmoji ?? false
        let isEmojiPresentation = text.unicodeScalars.first?.properties.isEmojiPresentation ?? false
        return isEmojiPresentation || isCombinedIntoEmoji
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveUnwind" else { return }
        
        let symbol = symbolTextField.text!
        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        let usage = usageTextField.text ?? ""
        emoji = Emoji(symbol: symbol, name: name, description: description, usage: usage)
    }
 
}
