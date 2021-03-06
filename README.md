# JKEmojiField

A UITextField subclass that imposes emoji input mode restriction on the keyboard and text entry.

[![Version](https://img.shields.io/cocoapods/v/JKEmojiField.svg?style=flat)](https://cocoapods.org/pods/JKEmojiField)
[![License](https://img.shields.io/cocoapods/l/JKEmojiField.svg?style=flat)](https://cocoapods.org/pods/JKEmojiField)
[![Platform](https://img.shields.io/cocoapods/p/JKEmojiField.svg?style=flat)](https://cocoapods.org/pods/JKEmojiField)
[![Downloads](https://img.shields.io/cocoapods/dt/JKEmojiField.svg?style=flat)](https://cocoapods.org/pods/JKEmojiField)

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