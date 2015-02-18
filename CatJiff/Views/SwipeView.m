//
//  SwipeView.m
//  CatJiff
//
//  Created by Mattias Bergström on 18/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import "SwipeView.h"

static CGFloat const kFlickThreshold = 80.0f;
static CGFloat const kDamping = 0.8f;
static CGFloat const kGravityMagnitude = 1.0f;
static CGFloat const kAngularResistance = 2.0f;

@interface SwipeView ()

@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;

// UIDynamics

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UISnapBehavior *snapBehaviour;
@property (nonatomic, strong) UIGravityBehavior *gravityBehaviour;
@property (nonatomic, strong) UIAttachmentBehavior *attachmentBehaviour;

@property (nonatomic, assign) CGPoint startCenter;
@property (nonatomic, assign) CFAbsoluteTime lastTime;
@property (nonatomic, assign) CGFloat lastAngle;
@property (nonatomic, assign) CGFloat angularVelocity;

@end

@implementation SwipeView

#pragma mark - Life Cycle

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
}

- (void)dealloc
{
    self.animator = nil;
}

-(void)setContentView:(UIView *)contentView
{
    if (_contentView) {
        [_contentView removeFromSuperview];
        _contentView = nil;
    }

    _contentView = contentView;
    self.panRecognizer = nil;
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [contentView addGestureRecognizer:self.panRecognizer];
    [self addSubview:contentView];
}

#pragma mark - Actions

- (void)handlePan:(UIPanGestureRecognizer *)gesture
{
    if (self.snapBehaviour) {
        [self.animator removeBehavior:self.snapBehaviour];
        self.snapBehaviour = nil;
    }

    __weak SwipeView *welf = self;

    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.startCenter = gesture.view.center;

        CGPoint pointWithinAnimatedView = [gesture locationInView:gesture.view];

        UIOffset offset = UIOffsetMake((CGFloat) (pointWithinAnimatedView.x - gesture.view.bounds.size.width / 2.0),
                                       (CGFloat) (pointWithinAnimatedView.y - gesture.view.bounds.size.height / 2.0));

        CGPoint anchor = [gesture locationInView:gesture.view.superview];

        self.lastTime = CFAbsoluteTimeGetCurrent();
        self.lastAngle = [self angleOfView:gesture.view];
        self.attachmentBehaviour = [[UIAttachmentBehavior alloc] initWithItem:gesture.view
                                                    offsetFromCenter:offset
                                                    attachedToAnchor:anchor];
        self.attachmentBehaviour.action = ^{
            CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();
            CGFloat angle = [welf angleOfView:gesture.view];
            if (time > welf.lastTime) {
                welf.angularVelocity = (CGFloat) ((angle - welf.lastAngle) / (time - welf.lastTime));
                welf.lastTime = time;
                welf.lastAngle = angle;
            }
        };

        [self.animator addBehavior:self.attachmentBehaviour];

    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint anchor = [gesture locationInView:gesture.view.superview];
        self.attachmentBehaviour.anchorPoint = anchor;
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        [self.animator removeBehavior:self.attachmentBehaviour];
        CGPoint velocity = [gesture velocityInView:gesture.view.superview];
        if (fabs(velocity.x) < kFlickThreshold || fabs(velocity.y) < kFlickThreshold) {
            self.snapBehaviour = [[UISnapBehavior alloc] initWithItem:gesture.view snapToPoint:self.startCenter];
            self.snapBehaviour.damping = kDamping;
            [self.animator addBehavior:self.snapBehaviour];
        } else {
            UIDynamicItemBehavior *dynamic = [[UIDynamicItemBehavior alloc] initWithItems:@[gesture.view]];
            [dynamic addLinearVelocity:velocity forItem:gesture.view];
            [dynamic addAngularVelocity:self.angularVelocity forItem:gesture.view];
            [dynamic setAngularResistance:kAngularResistance];
            [self.animator addBehavior:dynamic];

            UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[gesture.view]];
            gravity.magnitude = kGravityMagnitude;
            gravity.angle = atan2(velocity.y, velocity.x);
            [self.animator addBehavior:gravity];

            dynamic.action = ^{
                if (welf.delegate) {
                    [welf.delegate swipeViewDidMove:welf];
                }
            };

            [self removeGestureRecognizer:self.panRecognizer];
            // Setting user interaction enabled to NO allows taps to pass through to the view behind.
            self.userInteractionEnabled = NO;
            if (self.delegate) {
                [self.delegate swipeViewWasDismissed:self];
            }
        }
    }
}

- (CGFloat)angleOfView:(UIView *)view
{
    return (CGFloat) atan2(view.transform.b, view.transform.a);
}

@end
