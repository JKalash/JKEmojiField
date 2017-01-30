# JKEmojiField

A UITextField subclass that imposes emoji input mode restriction on the keyboard and text entry.

[![Version](https://img.shields.io/cocoapods/v/PageMenu.svg?style=flat)](http://cocoapods.org/pods/PageMenu)
[![License](https://img.shields.io/cocoapods/l/PageMenu.svg?style=flat)](http://cocoapods.org/pods/PageMenu)
[![Platform](https://img.shields.io/cocoapods/p/PageMenu.svg?style=flat)](http://cocoapods.org/pods/PageMenu)

<img src="https://raw.githubusercontent.com/JKalash/JKEmojiField/master/Screenshots/1.png">
<img src="https://raw.githubusercontent.com/JKalash/JKEmojiField/master/Screenshots/2.png">
<img src="https://raw.githubusercontent.com/JKalash/JKEmojiField/master/Screenshots/3.png">

## Usage

Create a JKEmojiField just like you would create a regular UITextField.

Swift
```
let emojiField = JKEmojiField(frame: frameRect)
emojiField.shouldResignAfterOneChar = true //Force field to contain only one emoji
emojiField.emojiDelegate = self
```

Objective-C
```
JKEmojiField *emojiField = [[JKEmojiField alloc] initWithFrame:frameRect];
emojiField.shouldResignAfterOneChar = true; //Force field to contain only one emoji
emojiField.emojiDelegate = self;
```

## Installing

### CocoaPods

Include the following in your podfile

```
pod 'JKEmojiField'
```

### Manual

Add the `JKEmojiField.swift` file to your project


## Authors

* **Joseph Kalash** - *Stalkie* - [Stalkie](https://stalkie.tv) - [Git](https://github.com/JKalash)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details