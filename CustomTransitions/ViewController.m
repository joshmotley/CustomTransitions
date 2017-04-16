//
//  ViewController.m
//  CustomTransitions
//
//  Created by Josh Motley on 4/15/17.
//  Copyright © 2017 Josh Motley. All rights reserved.
//

#import "ViewController.h"
#import "CustomAnimator.h"
#import "SecondViewController.h"

@interface ViewController () <UINavigationControllerDelegate>

@property (strong, nonatomic) CustomAnimator *animator;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactionController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.animator = [CustomAnimator new];
    self.navigationController.delegate = self;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    panGesture.cancelsTouchesInView = NO;
    [self.navigationController.view addGestureRecognizer:panGesture];
}

-(void)pan:(UIPanGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactionController = [[UIPercentDrivenInteractiveTransition alloc]init];
        CGPoint location = [recognizer locationInView:self.view];
        if (location.x < CGRectGetMidX(self.view.frame)) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat d = ([recognizer translationInView:self.view].x / CGRectGetWidth(self.view.bounds)) * 1;
        [self.interactionController updateInteractiveTransition:d];
    }else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([recognizer velocityInView:self.view].x > 0) {
            [self.interactionController finishInteractiveTransition];
        } else {
            [self.interactionController cancelInteractiveTransition];
        }
        self.interactionController = nil;
    }
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    return self.animator;
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    
    return self.interactionController;
}

-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (IBAction)pushAction:(id)sender {
    SecondViewController *secondVC = [self.storyboard instantiateViewControllerWithIdentifier:@"secondVC"];
    [self.navigationController pushViewController:secondVC animated:true];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
