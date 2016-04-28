# EDKeyboardHandler

[![CI Status](http://img.shields.io/travis/Eren Demirbuken/EDKeyboardHandler.svg?style=flat)](https://travis-ci.org/Eren Demirbuken/EDKeyboardHandler)
[![Version](https://img.shields.io/cocoapods/v/EDKeyboardHandler.svg?style=flat)](http://cocoapods.org/pods/EDKeyboardHandler)
[![License](https://img.shields.io/cocoapods/l/EDKeyboardHandler.svg?style=flat)](http://cocoapods.org/pods/EDKeyboardHandler)
[![Platform](https://img.shields.io/cocoapods/p/EDKeyboardHandler.svg?style=flat)](http://cocoapods.org/pods/EDKeyboardHandler)

## Usage
To run the example project, clone the repo, and run `pod install` from the Example directory first.

just init and listen to keyboard with block
``` objective-c
  self.keyboardHandler = [EDKeyboardHandler new];
    
  [self.keyboardHandler listenWithBlock:^(KeyboardInfo *model)
  {
    //adjust view positions according to keyboard position here
  }];
```
KeyboardHandler also provides KeyboardHandlerDelegate to listen keyboard position with delegation
``` objective-c
@protocol KeyboardHandlerDelegate <NSObject>
@optional
- (void)currentKeyboardInfo:(KeyboardInfo *) keyboardInfo;
@end
```

KeyboardInfo model has the following properties:
``` objective-c

typedef enum : NSUInteger {
    KeyboardStatusDidShow,
    KeyboardStatusWillShow,
    KeyboardStatusDidHide,
    KeyboardStatusWillHide,
} KeyboardStatus;

@interface KeyboardInfo:NSObject

@property (nonatomic,readonly) NSTimeInterval animationDuration;
@property (nonatomic,readonly) CGRect keyboardFrame;
@property (nonatomic,readonly) NSInteger animationCurve;
@property (nonatomic,readonly) KeyboardStatus status;

@end
```
TL;DR sample usage:
``` objective-c
    self.keyboardHandler = [EDKeyboardHandler new];
 
    [self.keyboardHandler listenWithBlock:^(KeyboardInfo *keyboardInfo)
    {
      if (keyboardInfo.status == KeyboardStatusWillShow || keyboardInfo.status == KeyboardStatusDidShow)
       {
          CGRect inputViewFrame = self.inputView.frame;
          inputViewFrame.origin.y = keyboardInfo.keyboardFrame.origin.y - inputViewFrame.size.height ;
          self.inputView.frame = inputViewFrame;
          
      }else{
          //handle keyboard hiding here
      }
    }];

```
## Screen shot
![alt tag](http://i.imgur.com/zohhe7K.gif)
## Requirements

## Installation

EDKeyboardHandler is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "EDKeyboardHandler"
```

## Author

Eren Demirbuken, erendemirbuken@peakgames.net

## License

EDKeyboardHandler is available under the MIT license. See the LICENSE file for more info.
