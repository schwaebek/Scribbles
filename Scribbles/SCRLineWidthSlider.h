//
//  SCRLineWidthSlider.h
//  Scribbles
//
//  Created by Katlyn Schwaebe on 8/4/14.
//  Copyright (c) 2014 Katlyn Schwaebe. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SCRLineWidthSliderDelegate;

@interface SCRLineWidthSlider : UIView
@property (nonatomic) float maxWidth;
@property (nonatomic) float minWidth;
@property (nonatomic) float currentWidth;
//potentially will use to change slider color based on selcected color
@property (nonatomic) UIColor * lineColor;
@property (nonatomic,assign) id <SCRLineWidthSliderDelegate> delegate;


@end

@protocol SCRLineWidthSliderDelegate <NSObject>

-(void)updateLineWidth:(float) lineWidth;

//@optional
//-(void)optionalMethod;

@end

