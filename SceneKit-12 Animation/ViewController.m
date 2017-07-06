//
//  ViewController.m
//  SceneKit-12 Animation
//
//  Created by ShiWen on 2017/7/6.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>
@interface ViewController ()<CAAnimationDelegate>

@property (nonatomic,strong) SCNView *mScnView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mScnView];
    
//    添加动画
    CABasicAnimation *postionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    postionAnimation.delegate = self;
//    动画时长
    postionAnimation.duration = 3;
//    重复次数
    postionAnimation.repeatCount = 30;
    
    postionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    postionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(375, 667)];
//    是否播放返回动画
    postionAnimation.autoreverses = YES;
//    设置动画运行模式：先快后慢或者匀速等数据
    postionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    给节点添加动画
    [[self.mScnView.scene.rootNode childNodeWithName:@"Map" recursively:YES]addAnimation:postionAnimation forKey:@"postion"];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"morpher.weights[1]"];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.autoreverses = YES;
    animation.repeatCount = INFINITY;
    animation.duration = 2;
    [[self.mScnView.scene.rootNode childNodeWithName:@"Map" recursively:YES] addAnimation:animation forKey:nil];
    


}
-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"动画开始");
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"动画停止");
}
-(SCNView*)mScnView{
    if (!_mScnView) {
        _mScnView = [[SCNView alloc] initWithFrame:self.view.bounds];
        _mScnView.backgroundColor = [UIColor blackColor];
        _mScnView.allowsCameraControl = YES;
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"foldingMap"withExtension:@"dae"];
        _mScnView.scene = [SCNScene sceneWithURL:url options:nil error:nil];
        
    }
    return _mScnView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
