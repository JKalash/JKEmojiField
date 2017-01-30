// MIT License
//
// Copyright (c) 2017 Joseph Kalash
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

@objc public protocol JKEmojiFieldDelegate : NSObjectProtocol {
    
    @objc @available(iOS 2.0, *)
    optional func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool // return NO to disallow editing.
    
    @objc @available(iOS 2.0, *)
    optional func textFieldDidBeginEditing(_ textField: UITextField) // became first responder
    
    @objc @available(iOS 2.0, *)
    optional func textFieldShouldEndEditing(_ textField: UITextField) -> Bool // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    
    @objc @available(iOS 2.0, *)
    optional func textFieldDidEndEditing(_ textField: UITextField) // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    
    @objc @available(iOS 10.0, *)
    optional func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) // if implemented, called in place of textFieldDidEndEditing:
    
    @objc @available(iOS 2.0, *)
    optional func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool // return NO to not change text
    
    @objc @available(iOS 2.0, *)
    optional func textFieldShouldClear(_ textField: UITextField) -> Bool // called when clear button pressed. return NO to ignore (no notifications)
    
    @objc @available(iOS 2.0, *)
    optional func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
}

class JKEmojiField: UITextField, UITextFieldDelegate {
    
    /* Force the text field to contain only *one* emoji */
    public var shouldResignAfterOneChar = true
    
    /* Set the emojiDelegate instead of the parent's UITextfieldDelegate delegate */
    weak open var emojiDelegate : JKEmojiFieldDelegate? = nil
    
    override weak open var delegate : UITextFieldDelegate? {
        willSet {
            assert(delegate == nil || delegate is JKEmojiField, "Do not override the delegate. The delegate of EmojiField must be itself. Instead, use equivalent EmojiFieldDelegate property.")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
    }
    
    override var textInputMode : UITextInputMode {
        get {
            for inputMode in activeInputModes() {
                if inputMode.primaryLanguage == "emoji" { return inputMode }
            }
            return super.textInputMode!
        }
    }
    
    private func activeInputModes() -> [UITextInputMode] {
        return UITextInputMode.activeInputModes
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponder.paste(_:)) { return false }
        return super.canPerformAction(action, withSender: sender)
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField.textInputMode?.primaryLanguage != "emoji" {
            
            // Try to alert
            let alertController = UIAlertController(title: "Emoji Keyboard", message: "Go Settings -> General -> Keyboard and add the emoji keyboard.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                
            if let override = emojiDelegate?.textFieldShouldBeginEditing?(textField) {
                return override
            }
            
            return false
        }
        
        if shouldResignAfterOneChar {
            text = ""
        }
        
        if let override = emojiDelegate?.textFieldShouldBeginEditing?(textField) {
            return override
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //Only allow emoji
        let newString = (textField.text as NSString!).replacingCharacters(in: range, with: string)
        
        if newString == "" || ( (!shouldResignAfterOneChar || newString.characters.count < 5) && newString.isIncludingEmoji() && newString.stringByRemovingEmoji() == "") {
            
            textField.text = newString
            if shouldResignAfterOneChar {
                textField.resignFirstResponder()
            }
            
            if let override = emojiDelegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) {
                return override
            }
            return false
        }
        
        if let override = emojiDelegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) {
            return override
        }
        
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        emojiDelegate?.textFieldDidBeginEditing?(textField)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let override = emojiDelegate?.textFieldShouldEndEditing?(textField) {
            return override
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        emojiDelegate?.textFieldDidEndEditing?(textField)
    }
    
    @available(iOS 10.0, *)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        emojiDelegate?.textFieldDidEndEditing?(textField, reason: reason)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if let override = emojiDelegate?.textFieldShouldClear?(textField) {
            return override
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let override = emojiDelegate?.textFieldShouldReturn?(textField) {
            return override
        }
        
        return true
    }
}


extension NSString {
    
    func isEmoji() -> Bool {
        
        let high : unichar = self.character(at: 0)
        
        // Surrogate pair (U+1D000-1F9FF)
        if 0xd800 <= high && high <= 0xdbff {
            let low = self.character(at: 1)
            
            let codepoint : Int = ((Int(high) - 0xd800) * 0x400) + (Int(low) - 0xdc00) + 0x10000
            return (0x1d000 <= codepoint && codepoint <= 0x1f77f) || (0x1F900 <= codepoint && codepoint <= 0x1f9ff)
        }
            // Not surrogate pair (U+2100-27BF)
        else { return (0x2100 <= high && high <= 0x27bf) }
    }
    
    func isIncludingEmoji() -> Bool {
        
        var result = false
        
        self.enumerateSubstrings(in: NSMakeRange(0, self.length),
                                 options:NSString.EnumerationOptions.byComposedCharacterSequences,
                                 using: { (substring, substringRange, enclosingRange, stop) -> () in
                                    
                                    if let s = substring , s.isEmoji() == true {
                                        stop.pointee = true
                                        result = true
                                    }
        })
        
        return result
    }
    
    func stringByRemovingEmoji() -> String {
        let buffer = NSMutableString(capacity: self.length)
        
        self.enumerateSubstrings(in: NSMakeRange(0, self.length),
                                 options:NSString.EnumerationOptions.byComposedCharacterSequences,
                                 using:{ (substring, substringRange, enclosingRange, stop) -> () in
                                    if substring != nil {
                                        buffer.append( substring!.isEmoji() == true ? "": substring! )
                                    }
        })
        
        return buffer as String;
    }
    
    func removedEmojiString() -> String {
        return self.stringByRemovingEmoji()
    }
}
