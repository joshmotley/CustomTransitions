//
//  SecondViewController.m
//  CustomTransitions
//
//  Created by Josh Motley on 4/15/17.
//  Copyright © 2017 Josh Motley. All rights reserved.
//

#import "SecondViewController.h"
#import "CustomAnimator.h"

@interface SecondViewController () <UITabBarControllerDelegate>

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactionController;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    panGesture.cancelsTouchesInView = NO;
    [self.navigationController.view addGestureRecognizer:panGesture];
    
    self.tabBarController.delegate = self;
}

-(id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    CustomAnimator *animator = [[CustomAnimator alloc]init];
    return animator;
}

-(id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return self.interactionController;
}

-(void)pan:(UIPanGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactionController = [[UIPercentDrivenInteractiveTransition alloc]init];
        CGPoint location = [recognizer locationInView:self.view];
        if (location.x < CGRectGetMidX(self.view.frame) && [recognizer velocityInView:self.view].x > 0) {
            if (self.tabBarController.selectedIndex == 0) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                self.tabBarController.selectedIndex = self.tabBarController.selectedIndex - 1;
            }
        }else if(location.x > CGRectGetMidX(self.view.frame) && [recognizer velocityInView:self.view].x < 0){
            self.tabBarController.selectedIndex = 1;
        }
    }else if (recognizer.state == UIGestureRecognizerStateEnded) {

        [self.interactionController finishInteractiveTransition];
        
        self.interactionController = nil;
    }
}

- (IBAction)popAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
