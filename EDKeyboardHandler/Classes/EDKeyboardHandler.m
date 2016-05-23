//
//  UIView+Keyboard.m
//
//  Created by Eren Demirbüken on 25/12/15.
//  Copyright © 2015 Eren Demirbüken. All rights reserved.
//

#import "EDKeyboardHandler.h"

@interface KeyboardInfo ()

-(instancetype)initWithDictionary:(NSDictionary *) dictionary andStatus:(KeyboardStatus) status;

@end

@implementation KeyboardInfo

-(instancetype)initWithDictionary:(NSDictionary *) dictionary andStatus:(KeyboardStatus) status
{
    self = [self init];
    
    if (self)
    {
        _keyboardFrame      = [[dictionary objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        _animationDuration  = [[dictionary objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        _animationCurve     = [[dictionary objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
        _status             = status;
    }
    
    return self;
}

@end

@interface EDKeyboardHandler ()

@property (weak,nonatomic) id<KeyboardHandlerDelegate> delegate;
@property (nonatomic, strong) void (^block)(KeyboardInfo *);

@end

@implementation EDKeyboardHandler

- (instancetype)initWithDelegate:(id<KeyboardHandlerDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        [self registerForKeyboardNotification];
    }
    return self;
}

- (void) registerForKeyboardNotification //register for keyboard activity
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}


-(void)listenWithBlock:(void (^)(KeyboardInfo *))block
{
    [self registerForKeyboardNotification];
    self.block = block;
}

-(void) keyboardWillShow:(NSNotification *) notification
{
    [self provideKeyboardFrameFromNotification:notification visibility:KeyboardStatusWillShow];
}
-(void) keyboardDidShow:(NSNotification *) notification
{
    [self provideKeyboardFrameFromNotification:notification visibility:KeyboardStatusDidShow];
}

-(void) keyboardWillHide:(NSNotification *) notification
{
    [self provideKeyboardFrameFromNotification:notification visibility:KeyboardStatusWillHide];
}
-(void) keyboardDidHide:(NSNotification *) notification
{
    [self provideKeyboardFrameFromNotification:notification visibility:KeyboardStatusDidHide];
}

-(void)provideKeyboardFrameFromNotification:(NSNotification *) notification visibility:(KeyboardStatus)visibility
{
    KeyboardInfo * model = [[KeyboardInfo alloc] initWithDictionary:notification.userInfo andStatus:visibility];
    
    [self.delegate currentKeyboardInfo:model];
    
    if (self.block) {
        self.block(model);
    }
}

- (void)dealloc
{
    self.block = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
