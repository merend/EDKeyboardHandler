//
//  EDViewController.m
//  EDKeyboardHandler
//
//  Created by Eren Demirbuken on 04/27/2016.
//  Copyright (c) 2016 Eren Demirbuken. All rights reserved.
//

#import "EDViewController.h"
#import "EDKeyboardHandler.h"

@interface EDViewController ()<KeyboardHandlerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *inputView;
@property(nonatomic,strong) EDKeyboardHandler * keyboardHandler;
@end

@implementation EDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //  [self registerWithDelegate];
    [self registerWithBlock];
}


-(void)registerWithBlock{
    
    self.keyboardHandler = [EDKeyboardHandler new];
    [self.keyboardHandler listenWithBlock:^(KeyboardInfo *model) {
        
        CGRect inputViewFrame = self.inputView.frame;
        inputViewFrame.origin.y = model.keyboardFrame.origin.y - inputViewFrame.size.height ;
        self.inputView.frame = inputViewFrame;
    }];
}

-(void)registerWithDelegate
{
    self.keyboardHandler = [[EDKeyboardHandler alloc] initWithDelegate:self];
}

- (void)currentKeyboardInfo:(KeyboardInfo *) keyboardInfo
{
    CGRect inputViewFrame = self.inputView.frame;
    inputViewFrame.origin.y = keyboardInfo.keyboardFrame.origin.y - inputViewFrame.size.height ;
    self.inputView.frame = inputViewFrame;
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    if (!CGRectContainsPoint(self.inputView.frame, location) ){
        [self.textField resignFirstResponder];
    }
    
    
}

@end