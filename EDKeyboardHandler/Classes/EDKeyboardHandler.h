//
//  UIView+Keyboard.h
//  ChatViewApp
//
//  Created by Eren Demirbüken on 25/12/15.
//  Copyright © 2015 Eren Demirbüken. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    KeyboardStatusDidShow,
    KeyboardStatusWillShow,
    KeyboardStatusDidHide,
    KeyboardStatusWillHide,
} KeyboardStatus;

@interface KeyboardInfo:NSObject

@property (nonatomic,readonly) NSTimeInterval animationDuration;
@property (nonatomic,readonly) CGRect    keyboardFrame;
@property (nonatomic,readonly) NSInteger animationCurve;
@property (nonatomic,readonly) KeyboardStatus status;

@end


@protocol KeyboardHandlerDelegate <NSObject>

@optional
- (void)currentKeyboardInfo:(KeyboardInfo *) keyboardInfo;

@end


@interface EDKeyboardHandler:NSObject

- (instancetype) initWithDelegate:(id<KeyboardHandlerDelegate>)theDelegate;
- (void)listenWithBlock:(void (^)(KeyboardInfo *))block;

@end
