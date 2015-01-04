//
//  ZQLRotateView.h
//  ZQLRotateMenu
//
//  Created by zangqilong on 15/1/4.
//  Copyright (c) 2015年 zangqilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZQLRotateViewDelegate <NSObject>

- (void)ZQLRotateView:(UIView *)view DidChoose:(NSInteger)tag;

@end

@interface ZQLRotateView : UIView

@property (nonatomic, weak) id<ZQLRotateViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame WithTitleArrays:(NSArray *)titleArray;

- (void)startAnimation;

- (void)hideAnimation;

@end
