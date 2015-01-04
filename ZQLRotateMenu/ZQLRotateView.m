//
//  ZQLRotateView.m
//  ZQLRotateMenu
//
//  Created by zangqilong on 15/1/4.
//  Copyright (c) 2015年 zangqilong. All rights reserved.
//

#import "ZQLRotateView.h"
#import "ZQLRotateItem.h"

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)

const float kMaxAngle = 240.;
const float kMinAngle = 120.;
const float kBeginDuration = 0.25;
const float kTimeDelta = 0.05;

@interface ZQLRotateView()
{
    NSMutableArray *arr;
    
    NSMutableArray *hideArr;
    
    CALayer *layer;
}
@end

@implementation ZQLRotateView

- (id)initWithFrame:(CGRect)frame WithTitleArrays:(NSArray *)titleArray
{
    if (self = [super initWithFrame:frame]) {
        arr = [NSMutableArray array];
        
        hideArr = [NSMutableArray array];
        
        for (int i = 0; i < titleArray.count; i++) {
            ZQLRotateItem *item = [[ZQLRotateItem alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-40, 40) withTitle:titleArray[i] withTag:i];
            item.layer.position = CGPointMake(30, CGRectGetHeight(self.bounds)/2);
            item.userInteractionEnabled = NO;
            [self addSubview:item];
            [arr addObject:item];

        }
        
        
        for (int i = (int)(titleArray.count-1); i>=0; i--) {
            ZQLRotateItem *item = arr[i];
            
            [self bringSubviewToFront:item];
        }
        
        CGFloat delta = (kMaxAngle-kMinAngle)/(arr.count-1);
        for (int i =0 ; i< titleArray.count; i++) {
            UIView *item = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-40, 40)];
            item.layer.anchorPoint = CGPointMake(0.95, 0.5);
            item.layer.position = CGPointMake(30, CGRectGetHeight(self.bounds)/2);
            item.tag = i;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleItemTapAction:)];
            [item addGestureRecognizer:tap];
            
            CGFloat degrees = -(kMaxAngle-delta*i);
            item.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(degrees), 0, 0, 1);
            
            item.backgroundColor = [UIColor clearColor];
            item.userInteractionEnabled = NO;
            
            [self addSubview:item];
            [hideArr addObject:item];
            
            
        }
        
        
        
       // [self beginingAnimation];
        
    }
    
    return self;
}

- (void)startAnimation
{
    for (UIView *item in hideArr) {
        item.userInteractionEnabled = YES;
    }
    
    CGFloat delta = (kMaxAngle-kMinAngle)/(arr.count-1);
    for (int i =0; i<arr.count; i++) {
        
        CGFloat degrees = -(kMaxAngle-delta*i);
        CGFloat duration = kBeginDuration+kTimeDelta*i;
        ZQLRotateItem *item = arr[i];
        
        [item.layer addAnimation:[self rotateArrowViewByAngle:degrees withDuration:duration] forKey:@"rotate"];
   
   
    }
   
}

- (void)hideAnimation
{
    for (UIView *item in hideArr) {
        item.userInteractionEnabled = NO;
    }
    
    CGFloat delta = (kMaxAngle-kMinAngle)/(arr.count-1);
    for (int i =0; i<arr.count; i++) {
        
        CGFloat radians = -(kMaxAngle-delta*i);
        CGFloat duration = kBeginDuration+kTimeDelta*(arr.count - i -1);
        ZQLRotateItem *item = arr[i];
        item.layer.transform = CATransform3DIdentity;
        [item.layer removeAllAnimations];
        [item.layer addAnimation:[self rotateBackArrowViewByAngle:radians withDuration:duration] forKey:@"rotateBack"];
        
    }
    
    
}

- (void)beginingAnimation
{
    CGFloat delta = (kMaxAngle-kMinAngle)/(arr.count-1);
    for (int i =0; i<arr.count; i++) {
        
        CGFloat radians = -(kMaxAngle-delta*i);
        CGFloat duration = kBeginDuration+kTimeDelta*(arr.count - i -1);
        ZQLRotateItem *item = arr[i];
        item.layer.transform = CATransform3DIdentity;
        [item.layer removeAllAnimations];
        [item.layer addAnimation:[self rotateBackArrowViewByAngle:radians withDuration:0.01] forKey:@"rotateBack"];
        
    }
}

- (CABasicAnimation *)rotateArrowViewByAngle:(CGFloat)degrees
                  withDuration:(NSTimeInterval)duration {
    
    CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    spinAnimation.fromValue = [NSNumber numberWithFloat:0];
    spinAnimation.toValue = [NSNumber numberWithFloat:degrees / 180.0 * M_PI];
    spinAnimation.duration = duration;
    spinAnimation.cumulative = YES;
    spinAnimation.additive = YES;
    spinAnimation.delegate = self;
    spinAnimation.removedOnCompletion = NO;
  
    spinAnimation.fillMode = kCAFillModeForwards;
    
    return spinAnimation;
}



- (CABasicAnimation *)rotateBackArrowViewByAngle:(CGFloat)degrees
                                withDuration:(NSTimeInterval)duration {
    
    CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    spinAnimation.fromValue = [NSNumber numberWithFloat:degrees / 180.0 * M_PI];
    spinAnimation.toValue = [NSNumber numberWithFloat:0];
    spinAnimation.duration = duration;
    spinAnimation.cumulative = YES;
    spinAnimation.additive = YES;
    spinAnimation.removedOnCompletion = NO;
    spinAnimation.delegate = self;
    spinAnimation.fillMode = kCAFillModeForwards;
    
    return spinAnimation;
}

- (void)handleItemTapAction:(UITapGestureRecognizer *)tap
{
    NSLog(@"tap tag is %d",tap.view.tag);
    if ([self.delegate respondsToSelector:@selector(ZQLRotateView:DidChoose:)]) {
        [self.delegate ZQLRotateView:self DidChoose:tap.view.tag];
    }
    [self hideAnimation];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
