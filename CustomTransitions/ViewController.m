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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.animator = [CustomAnimator new];
    self.navigationController.delegate = self;
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
        return self.animator;
    }
    return nil;
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
