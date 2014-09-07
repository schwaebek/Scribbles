//
//  SCRDrawViewController.m
//  Scribbles
//
//  Created by Katlyn Schwaebe on 8/4/14.
//  Copyright (c) 2014 Katlyn Schwaebe. All rights reserved.
//

#import "SCRDrawViewController.h"
#import "SCRDrawView.h"
#import "SCRLineWidthSlider.h"

@interface SCRDrawViewController ()<SCRLineWidthSliderDelegate>

@end

@implementation SCRDrawViewController
{
    UIButton * chooseColorButton;
    UIButton * curlyDrawButton;
    UIButton * lineDrawButton;
    UIButton * drawStyleButton;
    NSMutableArray * colors;
    NSMutableArray * buttons;
    BOOL colorChoicesOpen;
    UIView * lineWidthSize;
    SCRLineWidthSlider * lineSlider;
    UIButton * resetButton;
    UIImage * resetButtonImage;
}

// add reset button ... button should clear screen


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
       buttons = [@[] mutableCopy];
        self.view = [[SCRDrawView alloc] initWithFrame:self.view.frame];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    colors = [@[
                         [UIColor colorWithRed:1.000f green:0.525f blue:0.192f alpha:1.0f],
                         [UIColor colorWithRed:0.800f green:0.992f blue:0.204f alpha:1.0f],
                         [UIColor colorWithRed:1.000f green:0.000f blue:0.380f alpha:1.0f],
                         [UIColor colorWithRed:0.255f green:0.051f blue:0.541f alpha:1.0f],
                         [UIColor colorWithRed:0.004f green:0.973f blue:0.639f alpha:1.0f],
                         [UIColor colorWithRed:0.000f green:0.325f blue:0.820f alpha:1.0f],
                         [UIColor colorWithRed:0.000f green:1.000f blue:0.875f alpha:1.0f],
                         [UIColor colorWithRed:1.000f green:0.906f blue:0.310f alpha:1.0f],
                        
                         ]mutableCopy];
    
    chooseColorButton = [[UIButton alloc] initWithFrame:CGRectMake(136, 455, 50, 50)];
    chooseColorButton.backgroundColor = [UIColor blackColor];
    chooseColorButton.layer.cornerRadius = 25;
    [chooseColorButton addTarget:self action:@selector(showColorChoices) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:chooseColorButton];

    curlyDrawButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 380, 50, 50)];
    curlyDrawButton.backgroundColor = [UIColor whiteColor];
    curlyDrawButton.layer.cornerRadius = 25;
    UIImage * curlyDrawImage = [UIImage imageNamed:@"scribble_button"];
    [curlyDrawButton setImage:curlyDrawImage forState:UIControlStateNormal];
    [self.view addSubview:curlyDrawButton];
    
    lineDrawButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 440, 50, 50)];
    lineDrawButton.backgroundColor = [UIColor whiteColor];
    lineDrawButton.layer.cornerRadius = 25;
    UIImage * lineDrawImage = [UIImage imageNamed:@"lines_button"];
    [lineDrawButton setImage:lineDrawImage forState:UIControlStateNormal];
    [self.view addSubview:lineDrawButton];
    
    drawStyleButton = [[UIButton alloc] initWithFrame:CGRectMake(255, 500, 60, 60)];
    drawStyleButton.backgroundColor = [UIColor whiteColor];
    drawStyleButton.layer.cornerRadius = 30;
    [drawStyleButton setImage:lineDrawImage forState:UIControlStateNormal];
    [self.view addSubview:drawStyleButton];
    
    NSLog(@" %@", self.view);
    
    lineWidthSize = [[UIView alloc] initWithFrame:CGRectMake(0,0,2,2)];
    lineWidthSize.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineWidthSize];
    UIButton * openLineWidthSlider = [[UIButton alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT -60, 40, 40)];
    openLineWidthSlider.layer.cornerRadius =20;
    openLineWidthSlider.layer.borderWidth =1.0;
    openLineWidthSlider.layer.borderColor =[UIColor blackColor].CGColor;
    [openLineWidthSlider addTarget:self action:@selector(openSlider) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openLineWidthSlider];
    lineWidthSize.center = openLineWidthSlider.center;
    
    resetButton = [[UIButton alloc] initWithFrame: CGRectMake(273.0, 10.0, SCREEN_WIDTH -276.0, 40.0)];
    //[resetButton setTitle:@"RESET" forState:UIControlStateNormal];
    //[resetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    resetButton.backgroundColor = [UIColor whiteColor];
    resetButton.layer.borderWidth =1.0;
    resetButton.layer.borderColor =[UIColor blackColor].CGColor;
    UIImage * resetButtonImage = [UIImage imageNamed:@"reset_arrow"];
    [resetButton setImage:resetButtonImage forState:UIControlStateNormal];
    resetButton.layer.cornerRadius = 20.5;
    [resetButton addTarget:self action:@selector(resetButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
   
}


-(void)showColorChoices
{
    if (colorChoicesOpen)
    {
        [self hideColorChoices];
        return;
        
    }
    
    for (UIColor * color in colors)
    {
        NSInteger index = [colors indexOfObject:color];
        
        UIButton * colorButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10 + (50 * index), 40, 40)];
        colorButton.backgroundColor = color;
        colorButton.layer.cornerRadius = 20;
        [colorButton addTarget:self action:@selector(changeLineColor:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:colorButton];
        [buttons addObject:colorButton];
        colorButton.center = chooseColorButton.center;
        
        float radius = 60;
        float mpi = M_PI/180;
        float angle = 360/colors.count;
        float radians = angle * mpi;
        
        float moveX = chooseColorButton.center.x + sinf(radians * index) * radius;
        float moveY = chooseColorButton.center.y + cosf(radians * index) * radius;
        
       
        
        [UIView animateWithDuration:0.2 delay:0.05 * index options: UIViewAnimationOptionAllowUserInteraction animations:^{
            
            colorButton.center =CGPointMake(moveX, moveY);
        
        }completion:^(BOOL finished) {
            
        }];
        
        [self.view insertSubview:colorButton atIndex:0];

    }
    
    colorChoicesOpen = YES;
}

-(void)hideColorChoices
{
    
    for (UIButton * colorButton in buttons)
    {
        NSInteger index = [buttons indexOfObject:colorButton];
        
        [UIView animateWithDuration:0.2 delay:0.05 * index options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            colorButton.center = chooseColorButton.center;
            
        
        } completion:^(BOOL finished) {
            [colorButton removeFromSuperview];
        }];
    }
    
    [buttons removeAllObjects];
    
    colorChoicesOpen = NO;
    
}
-(void)resetButtonClicked
{
    [self.view.scribbles removeAllObjects];
    [self.view setNeedsDisplay];
}

-(void)updateLineWidth:(float)lineWidth
{
    self.view.lineWidth = lineWidth;
    
    CGPoint center = lineWidthSize.center;
    lineWidthSize.frame = CGRectMake(0, 0, lineWidth * 2, lineWidth * 2);
    lineWidthSize.center = center;
    lineWidthSize.layer.cornerRadius = lineWidth;
}

-(void)changeLineColor:(UIButton*)button
{
    SCRDrawView * view = (SCRDrawView *)self.view;
    view.lineColor = button.backgroundColor;
    chooseColorButton.backgroundColor = button.backgroundColor;
    [view setNeedsDisplay];
    [self hideColorChoices];
}

-(void)openSlider
{
    if (lineSlider)
    {
        [lineSlider removeFromSuperview];
        lineSlider = nil;
        return;
    }
    lineSlider = [[SCRLineWidthSlider alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT -280, 40, 200)];
    lineSlider.currentWidth = self.view.lineWidth;
    lineSlider.delegate = self;
    [self.view addSubview:lineSlider];
}

//-(void)showColorChoices
//{
//    if(colorChoicesOpen)
//    {
//        [self hideColorChoices];
//        return;
//    }

-(BOOL)prefersStatusBarHidden {return YES;}


@end
