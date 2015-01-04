//
//  ZQLRotateItem.m
//  ZQLRotateMenu
//
//  Created by zangqilong on 15/1/4.
//  Copyright (c) 2015年 zangqilong. All rights reserved.
//

#import "ZQLRotateItem.h"

@interface ZQLRotateItem ()
{
    UIView *controlButton;
    UILabel *titleLabel;
}

@end

@implementation ZQLRotateItem

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withTag:(NSInteger)tag
{
    if (self = [super initWithFrame:frame]) {
        controlButton = [[UIView alloc] init];
        controlButton.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        controlButton.backgroundColor = [UIColor whiteColor];
        controlButton.layer.cornerRadius = 3;
       // controlButton.backgroundColor = [UIColor redColor];
        controlButton.layer.masksToBounds = YES;
        [self addSubview:controlButton];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(-50, 5, 200, 30)];
        titleLabel.text = title;
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
        titleLabel.layer.transform = CATransform3DRotate(titleLabel.layer.transform, M_PI, 1, 0, 0);
        [titleLabel sizeToFit];
        [self addSubview:titleLabel];
        
        self.layer.shouldRasterize = YES;
        self.layer.shadowColor=[UIColor grayColor].CGColor;
        self.layer.shadowOffset=CGSizeMake(-2, -2);
        self.layer.shadowOpacity=.9;
        CGPoint anchorPoint = CGPointMake(0.95, 0.5);
        self.layer.anchorPoint = anchorPoint;
        
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
