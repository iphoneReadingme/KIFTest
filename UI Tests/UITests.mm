//
//  UITests.m
//  solanum
//
//  Created by yangfs on 14-11-5.
//  Copyright (c) 2014年 Razeware. All rights reserved.
//


#ifdef Test_Enable
#import "NBAccessibilityNames.h"
#import "UITests.h"

@implementation UITests

/*
 beforeAll 是一个实际上只是在所有测试运行之前被调用一次的特殊方法. 你可以为你这里运行的测试设置任何实体变量和初始化条件.
 tester 对象是指定的KIFUITestActor 类的一个缩略名称. 这个类包含了可以模拟用户动作的方法，包括触及还有在视图上滑动.
 tapViewWithAccessibilityLabel: 也许是最常被用到的测试动作方法. 正如其名称所揭示的，它使用在给定的可访问标签上模拟在视图上的触击. 在大多数情况下，可访问标签都是匹配诸如按钮这种组件的可视的文本标签. 如果不是这样的，那就会如你在下一节将会看到了，你将需要手动设置访问标签.
 一些控件，诸如 UISwitch, 相较而言更加复杂而比仅仅只需要简单的触击更甚的动作. KIF 提供了一个特殊的 setOn:forSwitchWithAccessibilityLabel: 方法来改变一个切换的状态.
 总结起来：这个方法对测试动作进行了四步操作:
 1. 触击“Settings” 选项卡按钮条.
 2. 将 “调试模式Debug Mode” 切换到它的“开启”状态.
 3. 触击 “Clear History” 按钮.
 4. 在UIAlertView上触击“Clear”按钮.
 
 
 */

- (void)beforeAll
{
	[tester tapViewWithAccessibilityLabel:NBAccessibilityLabel_Setting_Button];
	[tester setOn:YES forSwitchWithAccessibilityLabel:NBAccessibilityLabel_Debug_Mode_Switch];
	[tester tapViewWithAccessibilityLabel:NBAccessibilityLabel_Clear_History_Button];
	[tester tapViewWithAccessibilityLabel:NBAccessibilityLabel_AlertView_Clear_Button];
	[tester tapViewWithAccessibilityLabel:NBAccessibilityLabel_Timer_Button];
}

@end

#endif


//
//  UITests.m
//  solanum
//
//  Created by Matt Galloway on 01/02/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <SenTestingKit/SenTestCase_Macros.h>
#import <SenTestingKit/SenTestCase.h>
#import "UITests.h"

@implementation UITests

- (void)beforeAll {
    [tester tapViewWithAccessibilityLabel:@"Settings"];
    
    [tester setOn:YES forSwitchWithAccessibilityLabel:@"Debug Mode"];
    
    [tester tapViewWithAccessibilityLabel:@"Clear History"];
    [tester tapViewWithAccessibilityLabel:@"Clear"];
}

- (void)selectPresetAtIndex:(NSInteger)index {
    [tester tapViewWithAccessibilityLabel:@"Timer"];
    
    [tester tapViewWithAccessibilityLabel:@"Presets"];
    [tester tapRowInTableViewWithAccessibilityLabel:@"Presets List"
                                        atIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    
    [tester waitForAbsenceOfViewWithAccessibilityLabel:@"Presets List"];
}

- (void)test00TabBarButtons {
    // 1
    [tester tapViewWithAccessibilityLabel:@"History"];
    [tester waitForViewWithAccessibilityLabel:@"History List"];
    
    // 2
    [tester tapViewWithAccessibilityLabel:@"Timer"];
    [tester waitForViewWithAccessibilityLabel:@"Task Name"];
    
    // 3
    [tester tapViewWithAccessibilityLabel:@"Settings"];
    [tester waitForViewWithAccessibilityLabel:@"Debug Mode"];
}

- (void)test10PresetTimer {
    // 1
    [tester tapViewWithAccessibilityLabel:@"Timer"];
    
    // 2
    [tester enterText:@"Set up a test" intoViewWithAccessibilityLabel:@"Task Name"];
    [tester tapViewWithAccessibilityLabel:@"done"];
    
    // 3
    [self selectPresetAtIndex:1];
    
    // 4
    UISlider *slider = (UISlider *)[tester waitForViewWithAccessibilityLabel:@"Work Time Slider"];
    STAssertEqualsWithAccuracy((CGFloat)[slider value], 15.0f, 0.1f, @"Work time slider was not set!");
	slider = nil;
}

- (void)test20StartTimerAndWaitForFinish {
    [tester tapViewWithAccessibilityLabel:@"Timer"];
    
    [tester clearTextFromAndThenEnterText:@"Test the timer"
           intoViewWithAccessibilityLabel:@"Task Name"];
    [tester tapViewWithAccessibilityLabel:@"done"];
    
    [tester setValue:1 forSliderWithAccessibilityLabel:@"Work Time Slider"];
    [tester setValue:50 forSliderWithAccessibilityLabel:@"Work Time Slider"];
    [tester setValue:1 forSliderWithAccessibilityLabel:@"Work Time Slider"];
    [tester setValue:8 forSliderWithAccessibilityLabel:@"Work Time Slider"];
    
    [tester setValue:1 forSliderWithAccessibilityLabel:@"Break Time Slider"];
    [tester setValue:25 forSliderWithAccessibilityLabel:@"Break Time Slider"];
    [tester setValue:2 forSliderWithAccessibilityLabel:@"Break Time Slider"];
    
    // 1
    UIStepper *repsStepper = (UIStepper*)[tester waitForViewWithAccessibilityLabel:@"Reps Stepper"];
    CGPoint stepperCenter = [repsStepper.window convertPoint:repsStepper.center
                                                    fromView:repsStepper.superview];
    
    CGPoint minusButton = stepperCenter;
    minusButton.x -= CGRectGetWidth(repsStepper.frame) / 4;
    
    CGPoint plusButton = stepperCenter;
    plusButton.x += CGRectGetWidth(repsStepper.frame) / 4;
    
    // 2
    [tester waitForTimeInterval:1];
    
    // 3
    for (int i = 0; i < 20; i++) {
        [tester tapScreenAtPoint:minusButton];
    }
    
    [tester waitForTimeInterval:1];
    [tester tapScreenAtPoint:plusButton];
    [tester waitForTimeInterval:1];
    [tester tapScreenAtPoint:plusButton];
    [tester waitForTimeInterval:1];
    
    // 4
    [KIFUITestActor setDefaultTimeout:60];
    
    // 5
    [tester tapViewWithAccessibilityLabel:@"Start Working"];
    // the timer is ticking away in the modal view...
    [tester waitForViewWithAccessibilityLabel:@"Start Working"];
    
    // 6
    [KIFUITestActor setDefaultTimeout:10];
}

- (void)test30StartTimerAndGiveUp {
    [tester tapViewWithAccessibilityLabel:@"Timer"];
    
    [tester clearTextFromAndThenEnterText:@"Give Up"
           intoViewWithAccessibilityLabel:@"Task Name"];
    [tester tapViewWithAccessibilityLabel:@"done"];
    [self selectPresetAtIndex:2];
    
    [tester tapViewWithAccessibilityLabel:@"Start Working"];
    [tester waitForTimeInterval:3];
    
    [tester tapViewWithAccessibilityLabel:@"Give Up"];
    [[tester usingTimeout:1] waitForViewWithAccessibilityLabel:@"Start Working"];
}

- (void)test40SwipeToDeleteHistoryItem
{
    // 1
    [tester tapViewWithAccessibilityLabel:@"History"];
    
    // 2
    UITableView *tableView = (UITableView *)[tester waitForViewWithAccessibilityLabel:@"History List"];
    NSInteger originalHistoryCount = [tableView numberOfRowsInSection:0];
    STAssertTrue(originalHistoryCount > 0, @"There should be at least 1 history item!");
	originalHistoryCount = 0;
    
    // 3
    [tester swipeViewWithAccessibilityLabel:@"Section 0 Row 0" inDirection:KIFSwipeDirectionLeft];
    [tester tapViewWithAccessibilityLabel:@"Delete"];
    
    // 4
    [tester waitForTimeInterval:1];
    NSInteger currentHistoryCount = [tableView numberOfRowsInSection:0];
    STAssertTrue(currentHistoryCount == originalHistoryCount - 1,
                 @"The history item was not deleted :[");
	currentHistoryCount = 0;
}

@end
