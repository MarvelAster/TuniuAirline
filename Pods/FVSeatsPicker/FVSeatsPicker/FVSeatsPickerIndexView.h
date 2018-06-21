//
//  FVSeatsPickerIndexView.h
//  FVCinemaSeatsView
//
//  Created by iforvert on 2016/11/13.
//  Copyright © 2016年 iforvert. All rights reserved.
//  代码地址：https://www.github.com/Upliver/FVSeatsPicker

#import <UIKit/UIKit.h>

@interface FVSeatsPickerIndexView : UIView

@property (nonatomic, strong) NSArray<NSString*>* indexList;
@property (nonatomic, strong) UIColor* indexNumColor;
@property (nonatomic, strong) UIFont* indexNumFont;

@end
