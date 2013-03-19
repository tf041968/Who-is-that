//
//  testing.h
//  Pekbok
//
//  Created by Johan Persson on 2012-12-16.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollViewSubClass : UIScrollView<UIScrollViewDelegate>{

    UILabel *label;
}

@property (nonatomic) CGPoint point;


@end
