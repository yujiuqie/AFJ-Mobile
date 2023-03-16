//
//  AFJPMTweenViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/26.
//

#import "AFJPMTweenViewController.h"
#import "BasicTweenVC.h"
#import "AdditiveVC.h"
#import "BasicPhysicsTweenVC.h"
#import "GroupTweenVC.h"
#import "SequenceTweenVC.h"
#import "SequenceNoncontiguousVC.h"
#import "Transform3DVC.h"
#import "DynamicTweenVC.h"
#import "MassTweensVC.h"

typedef NS_ENUM(NSInteger, PMTweenExampleType) {
    PMTweenExampleBasic                     = 0,
    PMTweenExampleAdditive                  = 1,
    PMTweenExampleBasicPhysics              = 2,
    PMTweenExampleGroup                     = 3,
    PMTweenExampleSequence                  = 4,
    PMTweenExampleNoncontiguousSequence     = 5,
    PMTweenExampleTransform3D               = 6,
    PMTweenExampleDynamic                   = 7,
    PMTweenExampleMassTweens                = 8
};

@interface AFJPMTweenViewController ()
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *examples;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL uiCreated;

@end

@implementation AFJPMTweenViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        // Custom initialization
        
        _examples = @[@"Basic Tween",
                      @"Additive Tween",
                      @"Basic Physics Tween",
                      @"Group (+Reversing)",
                      @"Sequence (Rev. Contiguous)",
                      @"Sequence (Rev. Noncontiguous)",
                      @"CATransform3D Tween",
                      @"Dynamic Additive Tween",
                      @"250 Random Tweens"
                     ];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Examples";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    if (!self.uiCreated) {
        [self setupUI];
    }
    
}

- (void)setupUI {
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.clipsToBounds = YES;
    self.tableView.estimatedRowHeight = 44.0;
    [self.view addSubview:self.tableView];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint constraintWithItem:self.tableView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:0.0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.tableView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeHeight
                                multiplier:1.0
                                  constant:0.0].active = YES;
    
    self.uiCreated = YES;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (NSInteger)[self.examples count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger index = (NSUInteger)[indexPath row];
    static NSString *identifier = @"ExampleCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    NSString *label_text = self.examples[index];
    
    
    [cell.textLabel setText:label_text];
    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger index = (NSUInteger)[indexPath row];

    UIViewController *vc = nil;
    switch (index) {
        case PMTweenExampleBasic:
            vc = [[BasicTweenVC alloc] init];
            break;
        case PMTweenExampleAdditive:
            vc = [[AdditiveVC alloc] init];
            break;
        case PMTweenExampleBasicPhysics:
            vc = [[BasicPhysicsTweenVC alloc] init];
            break;
        case PMTweenExampleGroup:
            vc = [[GroupTweenVC alloc] init];
            break;
        case PMTweenExampleSequence:
            vc = [[SequenceTweenVC alloc] init];
            break;
        case PMTweenExampleNoncontiguousSequence:
            vc = [[SequenceNoncontiguousVC alloc] init];
            break;
        case PMTweenExampleTransform3D:
            vc = [[Transform3DVC alloc] init];
            break;
        case PMTweenExampleDynamic:
            vc = [[DynamicTweenVC alloc] init];
            break;
        case PMTweenExampleMassTweens:
            vc = [[MassTweensVC alloc] init];
            break;
        default:
            vc = [[BasicTweenVC alloc] init];
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    vc.title = self.examples[index];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
