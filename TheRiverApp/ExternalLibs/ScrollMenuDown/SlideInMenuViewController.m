//
//  SlideInMenuViewController.m
//  FINN
//
//  Created by Langstrand, Alexander on 29.01.13.
//  Copyright (c) 2013 FINN.no. All rights reserved.
//

#import "SlideInMenuViewController.h"

@interface SlideInMenuViewController ()

@end

@implementation SlideInMenuViewController {
    
    BOOL _menuViewIsReset;
    BOOL _menuViewShouldReset;

    CGFloat _menuViewHeight;
    UIView *_menuView;
    CGFloat _lastContentOffset;    
}

-(id)initWithMenuView:(UIView *)menuView {
    
    if (self = [super init]) {
    
        _menuView = menuView;
        _menuViewHeight = _menuView.frame.size.height;
        _menuViewShouldReset = false;
    }
    
    return self;
}

-(void)loadView {
    
    [super loadView];
    self.view = _menuView;
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint menuViewPoint = CGPointMake(_menuView.frame.origin.x, _menuView.frame.origin.y);
    CGPoint fakePoint = CGPointMake(_menuView.frame.origin.x, _menuView.frame.origin.y+_menuViewHeight);
    
    // If user drags the scrollView down when on the top, the menuView needs to be locked in place regardless of direction.
    if (lroundf((scrollView.bounds.origin.y+_menuViewHeight)) <= 0) {
        [self lockMenuViewInPlace:scrollView];
    }
    
    // Locking the menuView in place if user scrolls upwards while at the top of the scrollView.
    if ([self getDirection:scrollView] == Upwards)
    {

        // Locking the menuView in place if the user is scrolling upwards and the view becomes visible.
        if ([self menuViewIsWithinBounds:scrollView.bounds withPoint:menuViewPoint]) {
            
            [self lockMenuViewInPlace:scrollView];
            _menuViewIsReset = NO;
        }
    }
    else if ([self getDirection:scrollView] == Downwards)
    {
        if ([self menuViewIsWithinBounds:scrollView.bounds withPoint:menuViewPoint])
        {
            [self lockMenuViewInPlace:scrollView];
            _menuViewIsReset = NO;
        }
        
        // Checks if the user is scrolling downwards and resets the menuView to original position if the menuView goes out of view.
        else if (![self menuViewIsWithinBounds:scrollView.bounds withPoint:fakePoint])
        {
            if (!_menuViewIsReset) {
                [self resetMenuInScrollView:scrollView];
            }
        }
    }
}


// When user drags up and lets go when view.bounds is negative.

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{

    CGPoint fakePoint = CGPointMake(_menuView.frame.origin.x, _menuView.frame.origin.y);
    
    if ([self getDirection:scrollView] == Upwards)
    {
        if (scrollView.bounds.origin.y+_menuViewHeight <= 0) {
            [self lockMenuViewInPlace:scrollView];
        }
        else
        {
            if (!_menuViewIsReset) {

                // Just after the else has been triggered, this will trigger the locking of the menu,
                CGRect fixedFrame = _menuView.frame;
                fixedFrame.origin.y = scrollView.bounds.origin.y;
                _menuView.frame = fixedFrame;
                _menuViewIsReset = YES;
            } else {

                // If user scrolls fast upwards, the menu will be added just above the visible rows.
                // This is to insure that it will get a smooth animation fade in.

                CGRect fixedFrame = _menuView.frame;
                fixedFrame.origin.y = scrollView.bounds.origin.y-_menuViewHeight;
                _menuView.frame = fixedFrame;
            }
            }

    }
    
    if([self getDirection:scrollView] == Downwards)
    {
        if ((scrollView.bounds.origin.y+_menuViewHeight) <= 0) {
            [self lockMenuViewInPlace:scrollView];
        }
        
        // Resets the menuView to starting point if user scrolls down and the menuView goes out of view
        else if (![self menuViewIsWithinBounds:scrollView.bounds withPoint:fakePoint]) {
            
            if (!_menuViewIsReset && scrollView.bounds.origin.y >= 0) {
                [self resetMenuInScrollView:scrollView];
            }
        }
    }
}

// Storing the last contentOffset for comparison
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_menuViewShouldReset) {
        
        if (!_menuViewIsReset) {
            [self resetMenuInScrollView:scrollView];
        }
    }
    _lastContentOffset = scrollView.contentOffset.y;    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // Slide menu to be completely shown or hidden depending on its position.
    CGFloat scrollViewMenuViewDiff = (scrollView.bounds.origin.y -_menuView.frame.origin.y);
    
    // Slide up because the user has released the touch on the bottom part of menuView
    if (scrollViewMenuViewDiff <_menuViewHeight && scrollViewMenuViewDiff >= (_menuViewHeight/2))
    {
        if (scrollView.bounds.origin.y+_menuViewHeight <_menuViewHeight) {
            [self slideMenuView:_menuView toYPos:scrollView.bounds.origin.y];
        } else {
            
            if (scrollView.bounds.origin.y<=_menuViewHeight) {
                [self slideMenuView:_menuView toYPos:scrollView.frame.origin.y-_menuViewHeight];
            } else {
                [self slideMenuView:_menuView toYPos:scrollView.bounds.origin.y-_menuViewHeight];
                _menuViewShouldReset = YES;
            }
        }
    }
    // Slide down because the user has released the touch on the upper part of menuView
    else if (scrollViewMenuViewDiff < (_menuViewHeight/2) && scrollViewMenuViewDiff !=0)
    {
        [self slideMenuView:_menuView toYPos:scrollView.bounds.origin.y];
    }
}

#pragma mark -
#pragma mark Class Specific Methods

// Get the direction of the scroll
-(int)getDirection:(UIScrollView *)scrollView
{
    if (_lastContentOffset > scrollView.contentOffset.y)
    {
        return Upwards;
    } else if (_lastContentOffset < scrollView.contentOffset.y)
    {
        return Downwards;
    }
    return None;
}

-(void)lockMenuViewInPlace:(UIScrollView *)scrollView
{
    CGRect fixedFrame = _menuView.frame;
    fixedFrame.origin.y = scrollView.bounds.origin.y;
    _menuView.frame = fixedFrame;
}

// Reset the menuView to the top of the scrollView
-(void)resetMenuInScrollView:(UIScrollView *)scrollView
{
    CGRect fixedFrame = _menuView.frame;
    fixedFrame.origin.y = scrollView.frame.origin.y-_menuView.frame.size.height;
    _menuView.frame = fixedFrame;
    
    _menuViewShouldReset = false;
    _menuViewIsReset = true;
}

// Check if menuView is within the specified bounds
-(BOOL)menuViewIsWithinBounds:(CGRect)cgRect withPoint:(CGPoint)cgPoint
{
    if (CGRectContainsPoint(cgRect, cgPoint)) {
        return true;
    } else {
        return false;
    }
}

// Move and animate insets to the specified Y-position.
-(void)slideMenuView:(UIView *)menuView toYPos:(CGFloat)cgFloat {
    
    [UIView beginAnimations:@"movemenuview" context:nil];
    
    CGRect fixedFrame = menuView.frame;
    fixedFrame.origin.y = cgFloat;
    _menuView.frame = fixedFrame;
    
    [UIView commitAnimations];
}

-(void)menuPushed:(id)sender {
    NSLog(@"Menu button pressed");
}

@end
