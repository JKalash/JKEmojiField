# JKEmojiField

A UITextField subclass that imposes emoji input mode restriction on the keyboard and text entry.

[![Version](https://img.shields.io/cocoapods/v/PageMenu.svg?style=flat)](http://cocoapods.org/pods/PageMenu)
[![License](https://img.shields.io/cocoapods/l/PageMenu.svg?style=flat)](http://cocoapods.org/pods/PageMenu)
[![Platform](https://img.shields.io/cocoapods/p/PageMenu.svg?style=flat)](http://cocoapods.org/pods/PageMenu)

<img src="https://s27.postimg.org/saa6okk8j/1.png" alt="img1" style="width: 200px;">
<img src="https://s27.postimg.org/jgja7gx9v/2.png" alt="img2" style="width: 200px;">
<img src="https://s27.postimg.org/aa0zk6s1f/3.png" alt="img3" style="width: 200px;">

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